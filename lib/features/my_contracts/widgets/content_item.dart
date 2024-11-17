import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/custom_image.dart';

class ContentItem extends StatelessWidget {
  final String icon, title;
  final Color? color;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  const ContentItem({
    super.key,
    required this.icon,
    required this.title,
    this.color,
    this.mainAxisAlignment,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          CustomImage(
            icon,
            height: 18.h,
            width: 18.h,
            color: color,
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              title,
              style: context.mediumText.copyWith(fontSize: 10, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
