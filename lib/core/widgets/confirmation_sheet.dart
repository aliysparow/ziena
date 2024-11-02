import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/locale_keys.g.dart';
import '../utils/extensions.dart';

class ConfirmDialog extends StatelessWidget {
  final String title, subTitle;
  const ConfirmDialog({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: context.boldText.copyWith(fontSize: 18)),
          Text(subTitle, style: context.regularText.copyWith(color: context.hintColor)).withPadding(bottom: 20.h, top: 16.h),
          SizedBox(
            height: 40.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: context.primaryColorLight,
                      shape: RoundedRectangleBorder(side: BorderSide(color: context.splashColor), borderRadius: BorderRadius.circular(80.r)),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.yes.tr(),
                        style: context.semiboldText.copyWith(color: context.splashColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: context.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.r),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.no.tr(),
                      style: context.semiboldText.copyWith(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ).withPadding(all: 20.w),
    );
  }
}
