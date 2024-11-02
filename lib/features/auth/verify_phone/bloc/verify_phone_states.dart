import '../../../../core/utils/enums.dart';

class VerifyPhoneState {
  RequestState verifyState, resndState, editPhoneState;
  String msg;
  ErrorType errorType;

  VerifyPhoneState({
    this.verifyState = RequestState.initial,
    this.resndState = RequestState.initial,
    this.editPhoneState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  VerifyPhoneState copyWith({
    RequestState? verifyState,
    RequestState? editPhoneState,
    String? msg,
    ErrorType? errorType,
    RequestState? resndState,
  }) =>
      VerifyPhoneState(
        verifyState: verifyState ?? this.verifyState,
        editPhoneState: editPhoneState ?? this.editPhoneState,
        resndState: resndState ?? this.resndState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
