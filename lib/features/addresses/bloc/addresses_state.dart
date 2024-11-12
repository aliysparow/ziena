import 'package:ziena/core/utils/enums.dart';

class AddressesState {
  final RequestState getAddresses, getDistricts, createAddress, deleteAddressState;
  final String msg;

  AddressesState({
    this.getAddresses = RequestState.initial,
    this.msg = '',
    this.getDistricts = RequestState.initial,
    this.createAddress = RequestState.initial,
    this.deleteAddressState = RequestState.initial,
  });

  AddressesState copyWith({
    RequestState? getAddresses,
    RequestState? getDistricts,
    RequestState? createAddress,
    RequestState? deleteAddressState,
    String? msg,
  }) =>
      AddressesState(
        getAddresses: getAddresses ?? this.getAddresses,
        createAddress: createAddress ?? this.createAddress,
        getDistricts: getDistricts ?? this.getDistricts,
        deleteAddressState: deleteAddressState ?? this.deleteAddressState,
        msg: msg ?? this.msg,
      );
}
