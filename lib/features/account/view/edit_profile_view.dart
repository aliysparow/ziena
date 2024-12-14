import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/features/account/cubit/account_state.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_field.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/account_cubit.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final cubit = sl<AccountCubit>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.your_profile_settings.tr(),
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
                LocaleKeys.your_profile_settings.tr(),
                style: context.mediumText.copyWith(fontSize: 16),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.edit_profile_screen_msg.tr(),
                style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
              ),
              SizedBox(height: 12.h),
              AppField(
                title: LocaleKeys.full_name.tr(),
                keyboardType: TextInputType.name,
                hintText: LocaleKeys.full_name.tr(),
                controller: cubit.name,
              ).withPadding(vertical: 8.h),
              AppField(
                keyboardType: TextInputType.emailAddress,
                title: LocaleKeys.email.tr(),
                controller: cubit.email,
                validator: (v) => null,
              ).withPadding(vertical: 8.h),
              AppField(
                keyboardType: TextInputType.phone,
                title: LocaleKeys.phone_number.tr(),
                controller: cubit.phone,
              ).withPadding(vertical: 8.h),
              Text(
                LocaleKeys.gender.tr(),
                style: context.mediumText.copyWith(fontSize: 14),
              ).withPadding(vertical: 8.h),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.gender.tr(),
                ),
                items: List.generate(
                  AppConstants.genders.length,
                  (index) => DropdownMenuItem(
                    value: AppConstants.genders[index],
                    child: Text(AppConstants.genders[index].name.tr()),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    cubit.gender = value;
                  }
                },
                value: cubit.gender,
              ).withPadding(bottom: 8.h),
              InkWell(
                onTap: () => push(NamedRoutes.editPassword),
                child: Text(
                  LocaleKeys.change_password.tr(),
                  style: context.mediumText.copyWith(
                    fontSize: 14,
                    color: context.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: context.primaryColor,
                  ),
                ).withPadding(vertical: 8.h),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AccountCubit, AccountState>(
        bloc: cubit,
        buildWhen: (previous, current) => previous.editProfile != current.editProfile,
        listenWhen: (previous, current) => previous.editProfile != current.editProfile,
        listener: (context, state) {},
        builder: (context, state) {
          return AppBtn(
            loading: state.editProfile.isLoading,
            onPressed: () {
              if (formKey.isValid) {
                cubit.editProfile();
              }
            },
            title: LocaleKeys.save_changes.tr(),
          ).withPadding(horizontal: 24.w, vertical: 8.h);
        },
      ),
    );
  }
}
