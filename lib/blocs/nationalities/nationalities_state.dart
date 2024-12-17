import 'package:ziena/core/utils/enums.dart';

class NationalitiesState {
  final RequestState requestState;
  final String msg;
  final ErrorType errorType;

  NationalitiesState({this.requestState = RequestState.initial, this.msg = '', this.errorType = ErrorType.none});

  NationalitiesState copyWith({RequestState? requestState, String? msg, ErrorType? errorType}) => NationalitiesState(
        requestState: requestState ?? this.requestState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
