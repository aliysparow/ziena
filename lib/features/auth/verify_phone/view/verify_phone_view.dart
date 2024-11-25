import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes_fun.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/app_btn.dart';
import '../../../../core/widgets/auth_appbar.dart';
import '../../../../core/widgets/custom_timer.dart';
import '../../../../core/widgets/flash_helper.dart';
import '../../../../core/widgets/pin_code.dart';
import '../../../../core/widgets/resend_timer_widget.dart';
import '../../../../core/widgets/successfully_sheet.dart';
import '../../../../gen/locale_keys.g.dart';
import '../bloc/verify_phone_bloc.dart';
import '../bloc/verify_phone_states.dart';

enum VerifyType { resetPassword, register }

class VerifyPhoneView extends StatefulWidget {
  final VerifyType type;
  final Map<String, dynamic> data;
  const VerifyPhoneView({super.key, required this.type, required this.data});

  @override
  State<VerifyPhoneView> createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
  final timerController = CustomTimerController(2.minutes);
  final bloc = sl<VerifyPhoneBloc>();
  final form = GlobalKey<FormState>();
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
                LocaleKeys.activation_code.tr(),
                style: context.boldText.copyWith(fontSize: 24),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.we_have_just_sent_a_verification_code_consisting_of_4_digits_to_val_enter_the_code_in_the_box_below_to_continue
                    .tr(args: ['${widget.data['UserName'] ?? widget.data['Mobile']}']),
                style: context.lightText.copyWith(fontSize: 18, color: context.hintColor),
              ),
              SizedBox(height: 30.h),
              CustomPinCode(controller: bloc.otp).withPadding(vertical: 16.h),
              BlocConsumer<VerifyPhoneBloc, VerifyPhoneState>(
                bloc: bloc,
                buildWhen: (previous, current) => previous.resndState != current.resndState,
                listenWhen: (previous, current) => previous.resndState != current.resndState,
                listener: (context, state) {
                  if (state.resndState.isDone) {
                    timerController.setDuration(2.minutes);
                  }
                },
                builder: (context, state) {
                  return ResendTimerWidget(
                    timer: timerController,
                    onTap: () {
                      if (!state.resndState.isLoading) {
                        bloc.resend(widget.data['UserName']);
                      }
                    },
                    loading: state.resndState.isLoading,
                  );
                },
              ),
              SizedBox(height: 32.h),
              BlocConsumer<VerifyPhoneBloc, VerifyPhoneState>(
                bloc: bloc,
                buildWhen: (previous, current) => previous.verifyState != current.verifyState,
                listenWhen: (previous, current) => previous.verifyState != current.verifyState,
                listener: (context, state) {
                  if (state.verifyState.isDone) {
                    if (widget.type == VerifyType.register) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SuccessfullySheet(
                          title: LocaleKeys.account_created_successfully.tr(),
                          onLottieFinish: () => pushAndRemoveUntil(NamedRoutes.layout),
                        ),
                      );
                    } else {
                      replacement(NamedRoutes.resetPassword, arg: {"phone": widget.data['Mobile']});
                    }
                  } else if (state.verifyState.isError) {
                    FlashHelper.showToast(state.msg);
                  }
                },
                builder: (context, state) {
                  return AppBtn(
                    title: LocaleKeys.confirm.tr(),
                    loading: state.verifyState.isLoading,
                    onPressed: () => form.isValid ? bloc.verify(widget.type, widget.data) : null,
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

                   
                   
                   
                   
                   
                   






