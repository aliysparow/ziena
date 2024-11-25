import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/utils/methods_helpers.dart';

import '../../../../core/services/server_gate.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/flash_helper.dart';
import '../../../../models/user_model.dart';
import '../view/verify_phone_view.dart';
import 'verify_phone_states.dart';

class VerifyPhoneBloc extends Cubit<VerifyPhoneState> {
  VerifyPhoneBloc() : super(VerifyPhoneState());

  final otp = TextEditingController();
  Future<void> verify(VerifyType type, Map<String, dynamic> body) async {
    emit(state.copyWith(verifyState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: type == VerifyType.register ? ApiConstants.verifyAccount : ApiConstants.verifyOtp,
      body: {...body, "OTP": otp.text},
    );
    if (result.success) {
      if (type == VerifyType.register) {
        UserModel.i
          ..fromJson(result.data['data'])
          ..save();
      }
      emit(state.copyWith(verifyState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(verifyState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> resend(String phone) async {
    emit(state.copyWith(resndState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.sendOtp, params: {
      "mobile": MethodsHelpers.formatPhoneNumber(phone),
    });
    if (result.success) {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(resndState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(resndState: RequestState.error, msg: result.msg));
    }
  }
}
