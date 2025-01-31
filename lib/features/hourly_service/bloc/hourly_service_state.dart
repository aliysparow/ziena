import 'package:ziena/core/utils/enums.dart';

class HourlyServiceState {
  final RequestState getPacagesState,
      getCountriesForHourlyPricing,
      suggestedDaysState,
      addressesState,
      bookingState,
      getGetWeeksNumber,
      getAlternativeDatesMessage,
      getVisitsPerWeek,
      getAllShiftsForPricing,
      getPricingDetails;

  final String msg;
  final ErrorType errorType;

  HourlyServiceState({
    this.getPacagesState = RequestState.initial,
    this.getGetWeeksNumber = RequestState.initial,
    this.getCountriesForHourlyPricing = RequestState.initial,
    this.getAlternativeDatesMessage = RequestState.initial,
    this.suggestedDaysState = RequestState.initial,
    this.bookingState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.addressesState = RequestState.initial,
    this.getVisitsPerWeek = RequestState.initial,
    this.getAllShiftsForPricing = RequestState.initial,
    this.getPricingDetails = RequestState.initial,
  });

  HourlyServiceState copyWith({
    RequestState? getPacagesState,
    RequestState? getGetWeeksNumber,
    String? msg,
    ErrorType? errorType,
    RequestState? addressesState,
    RequestState? bookingState,
    RequestState? getVisitsPerWeek,
    RequestState? getAllShiftsForPricing,
    RequestState? getPricingDetails,
    RequestState? getCountriesForHourlyPricing,
    RequestState? suggestedDaysState,
    RequestState? getAlternativeDatesMessage,
  }) =>
      HourlyServiceState(
        getVisitsPerWeek: getVisitsPerWeek ?? this.getVisitsPerWeek,
        getCountriesForHourlyPricing: getCountriesForHourlyPricing ?? this.getCountriesForHourlyPricing,
        getPricingDetails: getPricingDetails ?? this.getPricingDetails,
        suggestedDaysState: suggestedDaysState ?? this.suggestedDaysState,
        getAlternativeDatesMessage: getAlternativeDatesMessage ?? this.getAlternativeDatesMessage,
        getGetWeeksNumber: getGetWeeksNumber ?? this.getGetWeeksNumber,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        addressesState: addressesState ?? this.addressesState,
        getAllShiftsForPricing: getAllShiftsForPricing ?? this.getAllShiftsForPricing,
        getPacagesState: getPacagesState ?? this.getPacagesState,
        bookingState: bookingState ?? this.bookingState,
      );
}
