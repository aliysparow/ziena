import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes_fun.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_btn.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/locale_keys.g.dart';
import '../../../../models/user_model.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final form = GlobalKey<FormState>();

  final bloc = sl<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColorLight,
      // appBar: const AuthAppbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                Assets.images.logo,
                height: 165.h,
                width: 105.w,
              ),
              SizedBox(height: 47.h),
              // Text(
              //   LocaleKeys.welcome_back.tr(),
              //   style: context.boldText.copyWith(fontSize: 32),
              // ),
              // Text(
              //   LocaleKeys.login.tr(),
              //   style: context.mediumText.copyWith(fontSize: 20, color: context.hintColor),
              // ),
              Text(
               LocaleKeys.enter_phone_and_password.tr(),
                style: context.mediumText.copyWith(fontSize: 20, color: context.hintColor),
              ),
              SizedBox(height: 14.h),
              AppField(
                controller: bloc.phone,
                keyboardType: TextInputType.phone,
                title: LocaleKeys.phone_number.tr(),
                prefixIcon: Icon(CupertinoIcons.phone, size: 18.h, color: context.secondaryColor),
              ).withPadding(vertical: 10.h),
              AppField(
                controller: bloc.password,
                keyboardType: TextInputType.visiblePassword,
                title: LocaleKeys.password.tr(),
                prefixIcon: Icon(CupertinoIcons.lock, size: 18.h, color: context.secondaryColor),
              ).withPadding(vertical: 10.h),
              Text.rich(
                TextSpan(
                  text: LocaleKeys.forgot_password.tr(),
                  recognizer: TapGestureRecognizer()..onTap = () => push(NamedRoutes.forgetPassword),
                ),
                style: context.regularText.copyWith(
                  fontSize: 14,
                  color: context.secondaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: context.secondaryColor,
                ),
              ).withPadding(vertical: 10.h),
              SizedBox(height: 14.h),
              BlocConsumer<LoginBloc, LoginState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.requestState.isDone) {
                    pushAndRemoveUntil(UserModel.i.userType.isDriver ? NamedRoutes.driverHome : NamedRoutes.layout);
                  }
                },
                builder: (context, state) {
                  return AppBtn(
                    loading: state.requestState == RequestState.loading,
                    onPressed: () => form.isValid ? bloc.login() : null,
                    title: LocaleKeys.confirm.tr(),
                  );
                },
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.dont_have_account.tr(),
                      style: context.mediumText.copyWith(fontSize: 14, color: context.hintColor),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: LocaleKeys.register_now.tr(),
                      recognizer: TapGestureRecognizer()..onTap = () => push(NamedRoutes.register),
                      style: context.boldText.copyWith(fontSize: 14, color: context.primaryColor),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ).withPadding(vertical: 14.h),
            ],
          ),
        ),
      ).center,
    );
  }
}
