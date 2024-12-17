import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/core/widgets/successfully_sheet.dart';
import 'package:ziena/models/user_model.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../gen/locale_keys.g.dart';
import '../../global_widget/select_city.dart';
import '../../global_widget/select_country.dart';
import '../cubit/account_cubit.dart';
import '../cubit/account_state.dart';

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
                title: LocaleKeys.first_name.tr(),
                keyboardType: TextInputType.name,
                hintText: LocaleKeys.first_name.tr(),
                controller: cubit.firstName,
              ).withPadding(vertical: 8.h),
              AppField(
                title: LocaleKeys.phone_number.tr(),
                keyboardType: TextInputType.phone,
                hintText: LocaleKeys.phone_number.tr(),
                suffixIcon: const SizedBox.shrink(),
                controller: TextEditingController(text: UserModel.i.phone),
                onTap: () {
                  FlashHelper.showToast("that_s_impossible_to_edit_your_phone_number".tr(), type: MessageType.warning);
                },
              ).withPadding(vertical: 8.h),
              AppField(
                keyboardType: TextInputType.name,
                title: LocaleKeys.last_name.tr(),
                controller: cubit.lastName,
              ).withPadding(vertical: 8.h),
              AppField(
                keyboardType: TextInputType.emailAddress,
                title: LocaleKeys.email.tr(),
                controller: cubit.email,
              ).withPadding(vertical: 8.h),
              SelectCityWidget(
                lable: LocaleKeys.city.tr(),
                initId: cubit.cityId,
                validator: (p0) => null,
                onSelected: (v) {
                  cubit.cityId = v.id;
                },
              ),
              SelectCountryWidget(
                lable: LocaleKeys.nationality.tr(),
                initId: cubit.nationalityId,
                validator: (p0) => null,
                onSelected: (v) {
                  cubit.nationalityId = v.id;
                },
              ),
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
        listener: (context, state) {
          if (state.editProfile.isDone) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false,
              builder: (context) => SuccessfullySheet(
                title: LocaleKeys.account_data_has_been_modified_successfully.tr(),
                onLottieFinish: () => Navigator.pop(context),
              ),
            );
          }
        },
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
