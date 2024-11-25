import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/locale_keys.g.dart';
import '../utils/extensions.dart';
import 'app_btn.dart';
import 'custom_image.dart';

class SuccessfullyPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String? btnTitle;
  final Function()? onTap;

  const SuccessfullyPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.btnTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              image,
              height: 300.h,
              width: 300.h,
            ),
            SizedBox(height: 36.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.semiboldText.copyWith(fontSize: 16),
            ),
            SizedBox(height: 18.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.lightText.copyWith(fontSize: 16),
            ),
          ],
        ).withPadding(horizontal: 35.w),
        bottomNavigationBar: AppBtn(
          onPressed: onTap ?? () => Navigator.pop(context, true),
          title: btnTitle ?? LocaleKeys.close.tr(),
          backgroundColor: btnTitle != null ? context.indicatorColor : Colors.transparent,
          textColor: btnTitle != null ? Colors.white : '#A4A4A4'.color,
        ).withPadding(
          horizontal: 20.w,
          vertical: 12.h,
        ),
      ),
    );
  }
}
