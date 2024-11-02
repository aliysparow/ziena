import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_btn.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/auth_appbar.dart';
import '../../../../gen/locale_keys.g.dart';
import '../bloc/forget_password_bloc.dart';
import '../bloc/forget_password_states.dart';

class ForgetPaswwordView extends StatefulWidget {
  const ForgetPaswwordView({super.key});

  @override
  State<ForgetPaswwordView> createState() => _ForgetPaswwordViewState();
}

class _ForgetPaswwordViewState extends State<ForgetPaswwordView> {
  final form = GlobalKey<FormState>();
  final bloc = sl<ForgetPasswordBloc>();

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
              // SafeArea(child: SizedBox(height: 30.h)),
              Text(
                LocaleKeys.reset_password.tr(),
                style: context.boldText.copyWith(fontSize: 24),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.please_enter_your_phone_number_to_recover_your_password.tr(),
                style: context.lightText.copyWith(fontSize: 18, color: context.hintColor),
              ),
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
              SizedBox(height: 32.h),
              BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                bloc: bloc,
                builder: (context, state) {
                  return AppBtn(
                    loading: state.requestState.isLoading,
                    onPressed: () {
                      form.isValid ? bloc.forgetPassword() : null;
                    },
                    title: LocaleKeys.send.tr(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
