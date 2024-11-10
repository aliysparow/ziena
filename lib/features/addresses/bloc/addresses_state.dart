import 'package:ziena/core/utils/enums.dart';

class AddressesState {
  final RequestState getAddresses;
  final String msg;

  AddressesState({this.getAddresses = RequestState.initial, this.msg = ''});

  AddressesState copyWith({
    RequestState? getAddresses,
    String? msg,
  }) =>
      AddressesState(
        getAddresses: getAddresses ?? this.getAddresses,
        msg: msg ?? this.msg,
      );
}
