import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ziena/core/utils/constant.dart';

import '../../../../core/services/server_gate.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/methods_helpers.dart';
import '../../../../core/widgets/flash_helper.dart';
import '../../../../models/user.dart';
import 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginState());

  final phone = TextEditingController(text: kDebugMode ? '561628311' : '');
  final password = TextEditingController(text: kDebugMode ? '123456123' : '');

  Future<void> login() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: AppConstants.login, body: {
      "UserName": MethodsHelpers.formatPhoneNumber(phone.text),
      "Password": password.text,
    });
    if (result.success) {
      result.data['data']['phone'] = MethodsHelpers.formatPhoneNumber(phone.text);
      UserModel.i
        ..fromJson(result.data['data'])
        ..save();
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }
}
