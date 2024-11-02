import 'package:ziena/core/utils/enums.dart';

class HomeState {
  final RequestState hourlyServicesState;
  final RequestState individualServicesState;
  final String msg;
  final ErrorType errorType;

  HomeState({
    this.hourlyServicesState = RequestState.initial,
    this.individualServicesState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  HomeState copyWith({
    RequestState? hourlyServicesState,
    RequestState? individualServicesState,
    String? msg,
    ErrorType? errorType,
  }) =>
      HomeState(
        hourlyServicesState: hourlyServicesState ?? this.hourlyServicesState,
        individualServicesState: individualServicesState ?? this.individualServicesState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
