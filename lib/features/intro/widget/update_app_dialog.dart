import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/gen/locale_keys.g.dart';

class UpdateAppDialog extends StatefulWidget {
  const UpdateAppDialog({super.key});

  @override
  State<UpdateAppDialog> createState() => _UpdateAppDialogState();
}

class _UpdateAppDialogState extends State<UpdateAppDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.update_available.tr(),
        style: context.semiboldText.copyWith(fontSize: 16),
      ),
      content: Text(
        LocaleKeys.a_new_version_of_the_app_is_available_please_update_to_continue.tr(),
        style: context.regularText.copyWith(fontSize: 14),
      ),
      actions: [
        // AppBtn(
        //   textColor: context.primaryColor,
        //   height: 35.h,
        //   backgroundColor: Colors.transparent,
        //   title: LocaleKeys.later.tr(),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        AppBtn(
          height: 35.h,
          title: LocaleKeys.update_now.tr(),
          onPressed: () {
            Navigator.of(context).pop();
            _launchStore();
          },
        ),
      ],
    );
  }

  void _launchStore() async {
    String url;
    if (Platform.isAndroid) {
      url = AppConstants.googlePlayLink;
    } else {
      url = AppConstants.appleStoreLink;
    }
    launchUrl(
      Uri.parse(url),
      mode: Platform.isAndroid ? LaunchMode.externalApplication : LaunchMode.platformDefault,
    );
  }
}
