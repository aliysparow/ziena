import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../utils/extensions.dart';
import 'app_sheet.dart';
import 'custom_image.dart';

class SelectItemSheet extends StatefulWidget {
  final String title;
  final List items;
  final dynamic initItem;
  final bool withImage;
  const SelectItemSheet({
    super.key,
    this.withImage = false,
    required this.title,
    required this.items,
    this.initItem,
  });

  @override
  State<SelectItemSheet> createState() => _SelectItemSheetState();
}

class _SelectItemSheetState extends State<SelectItemSheet> {
  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: widget.title,
      children: [
        SizedBox(height: 16.h),
        ...List.generate(
          widget.items.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.pop(context, widget.items[index] != widget.initItem ? widget.items[index] : null);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: context.borderColor),
              ),
              child: Row(
                children: [
                  if (widget.withImage)
                    CustomImage(
                      widget.items[index].image,
                      height: 30.h,
                      width: 40.h,
                      borderRadius: BorderRadius.circular(4.r),
                    ).withPadding(end: 8.w),
                  Expanded(
                    child: Text(
                      widget.items[index].name,
                      style: context.mediumText.copyWith(fontSize: 16),
                    ),
                  ),
                  if (widget.initItem == widget.items[index])
                    Icon(
                      Icons.check,
                      color: context.primaryColor,
                      size: 18.h,
                    ),
                ],
              ),
            ),
          ),
        ),
        const SafeArea(child: SizedBox()),
      ],
    );
  }
}

class SelectMultiItemSheet extends StatefulWidget {
  final String title;
  final List items;
  final List initItems;
  final bool withImage;
  const SelectMultiItemSheet({
    super.key,
    this.withImage = false,
    required this.title,
    required this.items,
    this.initItems = const [],
  });

  @override
  State<SelectMultiItemSheet> createState() => _SelectMultiItemSheetState();
}

class _SelectMultiItemSheetState extends State<SelectMultiItemSheet> {
  late List selectedItems = [...widget.initItems];
  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: widget.title,
      children: [
        SizedBox(height: 16.h),
        ...List.generate(
          widget.items.length,
          (index) {
            final selected = selectedItems.contains(widget.items[index]);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selected) {
                    selectedItems.remove(widget.items[index]);
                  } else {
                    selectedItems.add(widget.items[index]);
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: context.borderColor),
                ),
                child: Row(
                  children: [
                    if (widget.withImage)
                      CustomImage(
                        widget.items[index].image,
                        height: 30.h,
                        width: 40.h,
                        borderRadius: BorderRadius.circular(4.r),
                      ).withPadding(end: 8.w),
                    Expanded(
                      child: Text(
                        widget.items[index].name,
                        style: context.mediumText.copyWith(fontSize: 16),
                      ),
                    ),
                    if (selected)
                      Icon(
                        Icons.check,
                        color: context.primaryColor,
                        size: 18.h,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        AppBtn(
          title: LocaleKeys.confirm.tr(),
          onPressed: () => Navigator.pop(context, widget.initItems == selectedItems ? null : selectedItems),
        )
      ],
    );
  }
}

class SelectModel extends Equatable {
  final dynamic id;
  final String name;

  final String? image, desc;
  final dynamic data;

  const SelectModel({this.desc, this.image, required this.id, required this.name, this.data});

  @override
  List<Object?> get props => [id];
}
