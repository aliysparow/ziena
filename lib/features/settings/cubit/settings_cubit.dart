import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/enums.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  String termsData = '';
  Future<void> getTerms(String url) async {
    emit(state.copyWith(terms: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: url);
    if (result.success) {
      termsData = result.data['data'];
      emit(state.copyWith(terms: RequestState.done));
    } else {
      emit(state.copyWith(terms: RequestState.error, msg: result.msg));
    }
  }
}
