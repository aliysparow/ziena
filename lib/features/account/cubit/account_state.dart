import 'package:ziena/core/utils/enums.dart';

class AccountState {
  final RequestState deleteAccount;
  final String msg;
  final ErrorType errorType;

  AccountState({this.deleteAccount = RequestState.initial, this.msg = '', this.errorType = ErrorType.none});

  AccountState copyWith({RequestState? deleteAccount, String? msg, ErrorType? errorType}) => AccountState(
        deleteAccount: deleteAccount ?? this.deleteAccount,
        msg: msg ?? this.msg,
        errorType: errorType ?? this.errorType,
      );
}
