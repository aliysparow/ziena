import 'package:ziena/core/utils/enums.dart';

class SettingsState {
  final RequestState terms;
  final String msg;
  final ErrorType errorType;

  SettingsState({
    this.terms = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  SettingsState copyWith({
    RequestState? terms,
    String? msg,
    ErrorType? errorType,
  }) =>
      SettingsState(
        terms: terms ?? this.terms,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
