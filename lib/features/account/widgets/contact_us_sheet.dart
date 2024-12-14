import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/features/account/cubit/account_cubit.dart';
import 'package:ziena/features/account/cubit/account_state.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../gen/locale_keys.g.dart';

class ContactUsSheet extends StatelessWidget {
  const ContactUsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<AccountCubit>();
    return CustomAppSheet(
      children: [
        Text(
          LocaleKeys.change_password_settings.tr(),
          style: context.mediumText.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          LocaleKeys.when_you_change_your_password_you_will_be_logged_out_of_all_devices_you_are_logged_in_to.tr(),
          textAlign: TextAlign.center,
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<AccountCubit, AccountState>(
          bloc: cubit,
          builder: (context, state) {
            return AppBtn(
              loading: state.contactUs.isLoading,
              saveArea: false,
              onPressed: () {
                cubit.contactUs();
              },
              title: LocaleKeys.contact.tr(),
            );
          },
        ),
        SizedBox(height: 16.h),
        AppBtn(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: context.primaryColor,
          backgroundColor: context.scaffoldBackgroundColor,
          title: LocaleKeys.close.tr(),
        )
      ],
    );
  }
}
