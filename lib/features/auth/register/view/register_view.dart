import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/blocs/cities/cities_bloc.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/features/auth/register/bloc/register_states.dart';
import 'package:ziena/features/auth/register/widgets/select_city.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/auth_appbar.dart';
import '../../../../gen/locale_keys.g.dart';
import '../bloc/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final form = GlobalKey<FormState>();
  final bloc = sl<RegisterBloc>();
  final city = sl<CitiesBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColorLight,
      appBar: const AuthAppbar(withBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 30.h),
              Text(
                LocaleKeys.welcome.tr(),
                style: context.boldText.copyWith(fontSize: 32),
              ),
              Text(
                LocaleKeys.create_new_account.tr(),
                style: context.mediumText.copyWith(fontSize: 20, color: context.hintColor),
              ),
              SizedBox(height: 14.h),
              AppField(
                prefixIcon: Icon(CupertinoIcons.person, size: 18.h, color: context.secondaryColor),
                controller: bloc.firstName,
                hintText: 'أحمد',
                keyboardType: TextInputType.name,
                title: LocaleKeys.user_name.tr(),
              ).withPadding(vertical: 10.h),
              AppField(
                prefixIcon: Icon(CupertinoIcons.person, size: 18.h, color: context.secondaryColor),
                controller: bloc.lastNeme,
                hintText: 'محمد',
                keyboardType: TextInputType.name,
                title: LocaleKeys.user_name.tr(),
              ).withPadding(vertical: 10.h),
              AppField(
                controller: bloc.phone,
                hintText: '5XXXXXXXX',
                keyboardType: TextInputType.phone,
                title: LocaleKeys.phone_number.tr(),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.phone, size: 18.h, color: context.secondaryColor),
                    SizedBox(width: 4.w),
                    Text(
                      '+966',
                      style: context.regularText.copyWith(
                        color: context.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ).withPadding(horizontal: 8.w),
              ).withPadding(vertical: 10.h),
              AppField(
                hintText: 'example@gmail.com',
                controller: bloc.email,
                isRequired: false,
                keyboardType: TextInputType.emailAddress,
                title: LocaleKeys.email.tr(),
                prefixIcon: Icon(Icons.email_outlined, size: 18.h, color: context.secondaryColor),
              ).withPadding(vertical: 10.h),
              SelectCityWidget(onSelected: (value) => bloc.city = value),
              AppField(
                prefixIcon: Icon(CupertinoIcons.lock, size: 18.h, color: context.secondaryColor),
                controller: bloc.password,
                keyboardType: TextInputType.visiblePassword,
                title: LocaleKeys.password.tr(),
              ).withPadding(vertical: 10.h),
              AppField(
                prefixIcon: Icon(CupertinoIcons.lock, size: 18.h, color: context.secondaryColor),
                controller: bloc.confirmPassword,
                validator: (v) {
                  if (v != bloc.password.text) {
                    return LocaleKeys.passwords_do_not_match.tr();
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                title: LocaleKeys.confirm_password.tr(),
              ).withPadding(vertical: 10.h),
              SizedBox(height: 24.h),
              BlocConsumer<RegisterBloc, RegisterState>(
                bloc: bloc,
                listener: (context, state) {
                  // switch (state.requestState) {
                  //   case RequestState.done:
                  //     if (UserModel.i.isAuth) {
                  //       pushAndRemoveUntil(NamedRoutes.layout);
                  //     } else {
                  //       push(NamedRoutes.verifyPhone, arg: {
                  //         'type': VerifyType.register,
                  //         'phone': bloc.phone.text,
                  //         'phone_code': bloc.country?.phoneCode,
                  //       });
                  //     }
                  //   case RequestState.error:
                  //     FlashHelper.showToast(state.msg);
                  //     break;
                  //   default:
                  // }
                },
                builder: (context, state) {
                  return AppBtn(
                    saveArea: false,
                    loading: state.requestState.isLoading,
                    onPressed: () => form.isValid ? bloc.register() : null,
                    title: LocaleKeys.confirm.tr(),
                  );
                },
              ),
              SizedBox(height: 24.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.you_have_account.tr(),
                      style: context.mediumText.copyWith(fontSize: 14, color: context.hintColor),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: LocaleKeys.login.tr(),
                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.popUntil(context, (route) => route.settings.name == NamedRoutes.login),
                      style: context.boldText.copyWith(fontSize: 14, color: context.primaryColor),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ).withPadding(vertical: 14.h),
              SafeArea(child: SizedBox(height: 16.h)),
            ],
          ),
        ),
      ),
    );
  }
}
