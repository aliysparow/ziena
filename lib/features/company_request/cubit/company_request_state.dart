import '../../../core/utils/enums.dart';

class CompanyRequestState {
  final RequestState nationalityState, professionsState, createCorporateReq;
  final String msg;
  final ErrorType errorType;

  CompanyRequestState({
    this.nationalityState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.professionsState = RequestState.initial,
    this.createCorporateReq = RequestState.initial,
  });

  CompanyRequestState copyWith({
    RequestState? nationalityState,
    String? msg,
    ErrorType? errorType,
    RequestState? professionsState,
    RequestState? createCorporateReq,
  }) =>
      CompanyRequestState(
        nationalityState: nationalityState ?? this.nationalityState,
        createCorporateReq: createCorporateReq ?? this.createCorporateReq,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        professionsState: professionsState ?? this.professionsState,
      );
}
