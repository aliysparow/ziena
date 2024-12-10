import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';

class TermsConditionsView extends StatefulWidget {
  const TermsConditionsView({super.key});

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.terms_and_conditions_of_zina.tr(),
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          CustomImage(
            Assets.images.logoAuth,
            height: 96.h,
            width: 96.h,
          ).center,
          SizedBox(height: 28.h),
          HtmlWidget(text),
        ],
      ),
    );
  }

  String text = '''
نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط نص تجريبي فقط فقط نص تجريبي فقط نص تجريبي فقط ''';
}
