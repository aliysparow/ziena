import '../../../core/utils/enums.dart';

class IntroState {
  final RequestState requestState;
  final String msg;
  final ErrorType errorType;

  IntroState({this.requestState = RequestState.initial, this.msg = '', this.errorType = ErrorType.none});

  IntroState copyWith({RequestState? requestState, String? msg, ErrorType? errorType}) => IntroState(
        requestState: requestState ?? this.requestState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
