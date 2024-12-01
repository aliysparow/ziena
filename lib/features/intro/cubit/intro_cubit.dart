import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit() : super(IntroState());

  bool isValid = false;
  Future<void> checkVertion() async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      final packageInfo = await PackageInfo.fromPlatform();
      final result = await ServerGate.i.sendToServer(url: ApiConstants.checkAppVersion, body: {
        "isIOS": Platform.isIOS,
        "version": packageInfo.version,
      });
      if (result.success) {
        isValid = List<bool>.from(result.data['data']).firstOrNull == true;
        emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
      } else {
        emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
      }
    } catch (e) {
      emit(state.copyWith(requestState: RequestState.done, msg: e.toString()));
    }
  }
}
