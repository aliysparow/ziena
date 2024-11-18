import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/services/server_gate.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/core/utils/methods_helpers.dart';
import 'package:ziena/features/auth/verify_phone/view/verify_phone_view.dart';

import 'forget_password_states.dart';

class ForgetPasswordBloc extends Cubit<ForgetPasswordState> {
  ForgetPasswordBloc() : super(const ForgetPasswordState());
  final phone = TextEditingController();
  Future<void> forgetPassword() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.sendOtp, params: {'mobile': phone.text});
    if (result.success) {
      push(NamedRoutes.verifyPhone, arg: {
        'type': VerifyType.resetPassword,
        'data': {'Mobile': MethodsHelpers.formatPhoneNumber(phone.text)}
      });
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }
}
