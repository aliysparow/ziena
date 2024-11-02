import 'package:flutter/cupertino.dart';
import 'package:ziena/core/services/server_gate.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/core/widgets/flash_helper.dart';

import 'reset_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBloc extends Cubit<ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState());

  final password = TextEditingController();
  Future<void> resetPassword(String phone) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: AppConstants.resetPassword, body: {
      "Mobile": phone,
      "NewPassword": password.text,
    });
    if (result.success) {
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }
}
