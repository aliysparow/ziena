import '../../../core/utils/enums.dart';

class ContractsState {
  final RequestState contractState, visitsState, reschduleVisitState;
  final String msg;
  final ErrorType errorType;

  ContractsState({
    this.contractState = RequestState.initial,
    this.visitsState = RequestState.initial,
    this.reschduleVisitState = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  ContractsState copyWith({
    RequestState? contractState,
    RequestState? visitsState,
    RequestState? reschduleVisitState,
    String? msg,
    ErrorType? errorType,
  }) =>
      ContractsState(
        contractState: contractState ?? this.contractState,
        visitsState: visitsState ?? this.visitsState,
        reschduleVisitState: reschduleVisitState ?? this.reschduleVisitState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
