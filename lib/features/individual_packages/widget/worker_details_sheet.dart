import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/models/worker_model.dart';

import '../../../core/widgets/app_sheet.dart';
import '../../../gen/locale_keys.g.dart';

class WorkerDetailsSheet extends StatelessWidget {
  final WorkerModel item;
  const WorkerDetailsSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final viewMap = {
      LocaleKeys.years_of_experience.tr(): "${item.experienceYears}",
      LocaleKeys.age.tr(): "${item.age}",
      // LocaleKeys.services.tr(): item.nationalityStr,
      // LocaleKeys.religion.tr(): item.nationalityStr,
      LocaleKeys.skills.tr(): "${item.skills}",
    };
    return CustomAppSheet(
      title: LocaleKeys.choose_from_the_workers.tr(),
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            CustomImage(
              item.icon,
              height: 50.h,
              width: 50.h,
              borderRadius: BorderRadius.circular(100),
            ),
            Expanded(
              child: Text(
                item.name,
                style: context.semiboldText.copyWith(fontSize: 16),
              ).withPadding(horizontal: 8.w),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...List.generate(
          viewMap.length,
          (index) {
            final key = viewMap.keys.toList()[index];
            final value = viewMap.values.toList()[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key,
                    style: context.mediumText.copyWith(fontSize: 16),
                  ),
                  Text(
                    value,
                    style: context.mediumText.copyWith(fontSize: 16, color: context.primaryColor),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 12.h),
        AppBtn(
          title: LocaleKeys.back.tr(),
          onPressed: () => Navigator.pop(context),
          textColor: context.primaryColor,
          backgroundColor: context.scaffoldBackgroundColor,
        ),
      ],
    );
  }
}
