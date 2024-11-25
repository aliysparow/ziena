import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/features/driver_home/cubit/driver_home_cubit.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/user_model.dart';
import '../../home/bloc/home_bloc.dart';

class SelectLanguageSheet extends StatefulWidget {
  const SelectLanguageSheet({super.key});

  @override
  State<SelectLanguageSheet> createState() => _SelectLanguageSheetState();
}

class _SelectLanguageSheetState extends State<SelectLanguageSheet> {
  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: LocaleKeys.change_lang.tr(),
      children: [
        SizedBox(height: 16.h),
        AppBtn(
          saveArea: false,
          onPressed: () {
            if (context.locale.languageCode == 'en') {
              context.setLocale(const Locale('ar', 'SA'));
              _onChange();
            }
            Navigator.pop(context);
          },
          title: 'اللغة العربية',
        ),
        SizedBox(height: 16.h),
        AppBtn(
          onPressed: () {
            if (context.locale.languageCode == 'ar') {
              context.setLocale(const Locale('en', "USA"));
              _onChange();
            }
            Navigator.pop(context);
          },
          textColor: context.primaryColor,
          backgroundColor: context.scaffoldBackgroundColor,
          title: 'English',
        )
      ],
    );
  }

  _onChange() {
    Timer(1.seconds, () {
      if (UserModel.i.userType.isDriver) {
        sl<DriverHomeCubit>().getTodayShifts();
      } else {
        sl<HomeBloc>()
          ..getHourlyServiceList()
          ..getIndividualServiceList()
          ..getOffers()
          ..getSliders();
      }
    });
  }
}
