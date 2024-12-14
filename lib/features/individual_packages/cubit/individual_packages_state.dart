import 'package:ziena/core/utils/enums.dart';

class IndividualPackagesState {
  final RequestState getPackages,getAddresses,getWorkers, createIndividualRequest;
  final String msg;
  final ErrorType errorType;

  IndividualPackagesState({
    this.getPackages = RequestState.initial,
    this.createIndividualRequest = RequestState.initial,
    this.getAddresses = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.getWorkers = RequestState.initial
  });

  IndividualPackagesState copyWith({
    RequestState? getPackages,
    RequestState? createIndividualRequest,
    RequestState? getAddresses,
    String? msg,
    ErrorType? errorType,
    RequestState? getWorkers
  }) =>
      IndividualPackagesState(
        getPackages: getPackages ?? this.getPackages,
        createIndividualRequest: createIndividualRequest ?? this.createIndividualRequest,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
        getAddresses: getAddresses ?? this.getAddresses,
        getWorkers: getWorkers ?? this.getWorkers
      );
}
