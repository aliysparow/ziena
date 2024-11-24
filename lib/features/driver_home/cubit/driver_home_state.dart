import 'package:ziena/core/utils/enums.dart';

class DriverHomeState {
  final RequestState getOrderState, shiftsState, getReasonsState, rejectOrderState, changeStatus, getVisit;
  final String msg;
  final ErrorType errorType;

  DriverHomeState({
    this.getOrderState = RequestState.loading,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.shiftsState = RequestState.initial,
    this.getReasonsState = RequestState.initial,
    this.rejectOrderState = RequestState.initial,
    this.changeStatus = RequestState.initial,
    this.getVisit = RequestState.initial,
  });

  DriverHomeState copyWith({
    RequestState? getOrderState,
    String? msg,
    ErrorType? errorType,
    RequestState? shiftsState,
    RequestState? getReasonsState,
    RequestState? rejectOrderState,
    RequestState? changeStatus,
    RequestState? getVisit,
  }) =>
      DriverHomeState(
        getOrderState: getOrderState ?? this.getOrderState,
        shiftsState: shiftsState ?? this.shiftsState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        getReasonsState: getReasonsState ?? this.getReasonsState,
        rejectOrderState: rejectOrderState ?? this.rejectOrderState,
        changeStatus: changeStatus ?? this.changeStatus,
        getVisit: getVisit ?? this.getVisit,
      );
}
