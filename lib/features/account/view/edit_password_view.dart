import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/widgets/successfully_sheet.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';

class EditPasswordView extends StatefulWidget {
  const EditPasswordView({super.key});

  @override
  State<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<EditPasswordView> {
  final cubit = sl<AccountCubit>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.change_password.tr(),
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.change_password_settings.tr(),
                style: context.mediumText.copyWith(fontSize: 16),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.when_you_change_your_password_you_will_be_logged_out_of_all_devices_you_are_logged_in_to.tr(),
                style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
              ),
              SizedBox(height: 12.h),
              AppField(
                title: LocaleKeys.old_password.tr(),
                keyboardType: TextInputType.visiblePassword,
                hintText: LocaleKeys.old_password.tr(),
                controller: cubit.oldPassword,
              ).withPadding(vertical: 8.h),
              AppField(
                keyboardType: TextInputType.visiblePassword,
                title: LocaleKeys.new_password.tr(),
                controller: cubit.password,
                hintText: LocaleKeys.new_password.tr(),
              ).withPadding(vertical: 8.h),
              AppField(
                keyboardType: TextInputType.visiblePassword,
                title: LocaleKeys.confirm_new_password.tr(),
                controller: cubit.confirmPassword,
                hintText: LocaleKeys.confirm_new_password.tr(),
                validator: (v) {
                  if (v != cubit.password.text) {
                    return LocaleKeys.password_does_not_match.tr();
                  }
                  return null;
                },
              ).withPadding(vertical: 8.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AccountCubit, AccountState>(
        bloc: cubit,
        buildWhen: (previous, current) => previous.editPassword != current.editPassword,
        listenWhen: (previous, current) => previous.editPassword != current.editPassword,
        listener: (context, state) {
          if (state.editPassword.isDone) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false,
              builder: (context) => SuccessfullySheet(
                title: LocaleKeys.password_changed_successfully.tr(),
                onLottieFinish: () => Navigator.pop(context),
              ),
            );
          }
        },
        builder: (context, state) {
          return AppBtn(
            loading: state.editPassword.isLoading,
            onPressed: () {
              if (formKey.isValid) {
                cubit.editPassword();
              }
            },
            title: LocaleKeys.change_password.tr(),
          ).withPadding(horizontal: 24.w, vertical: 8.h);
        },
      ),
    );
  }
}
