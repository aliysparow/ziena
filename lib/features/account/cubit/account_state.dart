import 'package:ziena/core/utils/enums.dart';

class AccountState {
  final RequestState deleteAccount, contactUs, nationalitiesState, citiesState, editPassword, editProfile;
  final String msg;
  final ErrorType errorType;

  AccountState({
    this.deleteAccount = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.editPassword = RequestState.initial,
    this.editProfile = RequestState.initial,
    this.nationalitiesState = RequestState.initial,
    this.contactUs = RequestState.initial,
    this.citiesState = RequestState.initial,
  });

  AccountState copyWith({
    RequestState? deleteAccount,
    String? msg,
    ErrorType? errorType,
    RequestState? editProfile,
    RequestState? editPassword,
    RequestState? contactUs,
    RequestState? nationalitiesState,
    RequestState? citiesState,
  }) =>
      AccountState(
        contactUs: contactUs ?? this.contactUs,
        deleteAccount: deleteAccount ?? this.deleteAccount,
        msg: msg ?? this.msg,
        editProfile: editProfile ?? this.editProfile,
        errorType: errorType ?? this.errorType,
        editPassword: editPassword ?? this.editPassword,
        nationalitiesState: nationalitiesState ?? this.nationalitiesState,
        citiesState: citiesState ?? this.citiesState,
      );
}
