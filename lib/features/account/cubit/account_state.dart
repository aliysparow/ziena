import 'package:ziena/core/utils/enums.dart';

class AccountState {
  final RequestState deleteAccount, contactUs, editProfile;
  final String msg;
  final ErrorType errorType;

  AccountState(
      {this.deleteAccount = RequestState.initial,
      this.msg = '',
      this.errorType = ErrorType.none,
      this.editProfile = RequestState.initial,
      this.contactUs = RequestState.initial});

  AccountState copyWith({RequestState? deleteAccount, String? msg, ErrorType? errorType, RequestState? editProfile, RequestState? contactUs}) => AccountState(
        contactUs: contactUs ?? this.contactUs,
        deleteAccount: deleteAccount ?? this.deleteAccount,
        msg: msg ?? this.msg,
        editProfile: editProfile ?? this.editProfile,
        errorType: errorType ?? this.errorType,
      );
}
