import 'package:ziena/core/utils/enums.dart';

class HomeState {
  final RequestState hourlyServicesState, individualServicesState, sliderAndOffersState;
  final String msg;
  final ErrorType errorType;

  HomeState({
    this.hourlyServicesState = RequestState.initial,
    this.individualServicesState = RequestState.initial,
    this.sliderAndOffersState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  HomeState copyWith({
    RequestState? hourlyServicesState,
    RequestState? sliderAndOffersState,
    RequestState? individualServicesState,
    String? msg,
    ErrorType? errorType,
  }) =>
      HomeState(
        hourlyServicesState: hourlyServicesState ?? this.hourlyServicesState,
        individualServicesState: individualServicesState ?? this.individualServicesState,
        sliderAndOffersState: sliderAndOffersState ?? this.sliderAndOffersState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
