import 'package:ziena/core/utils/enums.dart';

class HomeState {
  final RequestState hourlyServicesState, individualServicesState, offersState, getPackageByIdState, slidersState;
  final String msg;
  final ErrorType errorType;

  HomeState({
    this.hourlyServicesState = RequestState.initial,
    this.getPackageByIdState = RequestState.initial,
    this.individualServicesState = RequestState.initial,
    this.offersState = RequestState.initial,
    this.slidersState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  HomeState copyWith({
    RequestState? hourlyServicesState,
    RequestState? getPackageByIdState,
    RequestState? offersState,
    RequestState? individualServicesState,
    RequestState? slidersState,
    String? msg,
    ErrorType? errorType,
  }) =>
      HomeState(
        hourlyServicesState: hourlyServicesState ?? this.hourlyServicesState,
        individualServicesState: individualServicesState ?? this.individualServicesState,
        getPackageByIdState: getPackageByIdState ?? this.getPackageByIdState,
        offersState: offersState ?? this.offersState,
        slidersState: slidersState ?? this.slidersState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
