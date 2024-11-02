import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/widgets/auth_appbar.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_btn.dart';
import '../../../../core/widgets/app_field.dart';
import '../../../../core/widgets/flash_helper.dart';
import '../../../../core/widgets/successfully_sheet.dart';
import '../../../../gen/locale_keys.g.dart';
import '../bloc/reset_password_bloc.dart';
import '../bloc/reset_password_states.dart';

class ResetPasswordView extends StatefulWidget {
  final String phone;
  const ResetPasswordView({super.key, required this.phone});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final form = GlobalKey<FormState>();
  final bloc = sl<ResetPasswordBloc>();
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
                LocaleKeys.create_password.tr(),
                style: context.boldText.copyWith(fontSize: 32),
              ),
              Text(
                LocaleKeys.the_password_must_have_at_least_8_letters.tr(),
                style: context.lightText.copyWith(fontSize: 18, color: context.hintColor),
              ),
              SizedBox(height: 14.h),
              AppField(
                controller: bloc.password,
                keyboardType: TextInputType.visiblePassword,
                title: LocaleKeys.password.tr(),
              ).withPadding(vertical: 10.h),
              AppField(
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
              BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state.requestState.isDone) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SuccessfullySheet(
                        title: LocaleKeys.password_changed_successfully.tr(),
                        onLottieFinish: () => Navigator.popUntil(context, (route) => route.isFirst),
                      ),
                    );
                  } else if (state.requestState.isError) {
                    FlashHelper.showToast(state.msg);
                  }
                },
                builder: (context, state) {
                  return AppBtn(
                    loading: state.requestState.isLoading,
                    title: LocaleKeys.confirm.tr(),
                    onPressed: () => !state.requestState.isLoading && form.isValid ? bloc.resetPassword(widget.phone) : null,
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
