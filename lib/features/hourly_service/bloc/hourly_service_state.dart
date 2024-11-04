import 'package:ziena/core/utils/enums.dart';

class HourlyServiceState {
  final RequestState getPacagesState, addressesState, bookingState;
  final String msg;
  final ErrorType errorType;

  HourlyServiceState({
    this.getPacagesState = RequestState.initial,
    this.bookingState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.addressesState = RequestState.initial,
  });

  HourlyServiceState copyWith({
    RequestState? getPacagesState,
    String? msg,
    ErrorType? errorType,
    RequestState? addressesState,
    RequestState? bookingState,
  }) =>
      HourlyServiceState(
        getPacagesState: getPacagesState ?? this.getPacagesState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        addressesState: addressesState ?? this.addressesState,
        bookingState: bookingState ?? this.bookingState,
      );
}
