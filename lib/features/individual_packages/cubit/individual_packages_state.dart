import 'package:ziena/core/utils/enums.dart';

class IndividualPackagesState {
  final RequestState getPackages, createIndividualRequest;
  final String msg;
  final ErrorType errorType;

  IndividualPackagesState({
    this.getPackages = RequestState.initial,
    this.createIndividualRequest = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  IndividualPackagesState copyWith({
    RequestState? getPackages,
    RequestState? createIndividualRequest,
    String? msg,
    ErrorType? errorType,
  }) =>
      IndividualPackagesState(
        getPackages: getPackages ?? this.getPackages,
        createIndividualRequest: createIndividualRequest ?? this.createIndividualRequest,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
