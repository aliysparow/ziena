import '../../../core/utils/enums.dart';

class ContractsState {
  final RequestState contractState, visitsState, reschduleVisitState, rateState, setFavoriteLaborState, blockLaborState, ordersState, getBlocReasons;
  final String msg;
  final ErrorType errorType;

  ContractsState(
      {this.contractState = RequestState.initial,
      this.getBlocReasons = RequestState.initial,
      this.visitsState = RequestState.initial,
      this.reschduleVisitState = RequestState.initial,
      this.rateState = RequestState.initial,
      this.setFavoriteLaborState = RequestState.initial,
      this.blockLaborState = RequestState.initial,
      this.msg = '',
      this.errorType = ErrorType.none,
      this.ordersState = RequestState.initial});

  ContractsState copyWith({
    RequestState? getBlocReasons,
    RequestState? contractState,
    RequestState? visitsState,
    RequestState? reschduleVisitState,
    RequestState? rateState,
    RequestState? setFavoriteLaborState,
    RequestState? blockLaborState,
    String? msg,
    ErrorType? errorType,
    RequestState? ordersState,
  }) =>
      ContractsState(
        getBlocReasons: getBlocReasons ?? this.getBlocReasons,
        contractState: contractState ?? this.contractState,
        ordersState: ordersState ?? this.ordersState,
        visitsState: visitsState ?? this.visitsState,
        reschduleVisitState: reschduleVisitState ?? this.reschduleVisitState,
        rateState: rateState ?? this.rateState,
        setFavoriteLaborState: setFavoriteLaborState ?? this.setFavoriteLaborState,
        blockLaborState: blockLaborState ?? this.blockLaborState,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
