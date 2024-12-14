import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ziena/core/widgets/loading.dart';

import '../../../blocs/cities/cities_bloc.dart';
import '../../../core/services/server_gate.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/district_model.dart';
import '../../../models/user_model.dart';
import 'addresses_state.dart';

class AddressesBloc extends Cubit<AddressesState> {
  AddressesBloc() : super(AddressesState());

  final citiesBloc = sl<CitiesBloc>();

  List<AddressModel> addresses = [];

  List<CityModel> cities = [];
  List<DistrictModel> districts = [];

  SelectModel? apartmentType;
  final buildingNumber = TextEditingController();
  final apartmentNumber = TextEditingController();
  final fullAddress = TextEditingController();
  final floorNumber = TextEditingController();
  final name = TextEditingController();
  CityModel? city;
  DistrictModel? district;
  LatLng? latLng = const LatLng(30.0444, 31.2357);

  getAddresses() async {
    emit(state.copyWith(getAddresses: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getAddresses,
      params: {"contactId": UserModel.i.contactId},
    );
    if (result.success) {
      addresses = result.data['data'].map<AddressModel>((e) => AddressModel.fromJson(e)).toList();
      emit(state.copyWith(getAddresses: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(getAddresses: RequestState.error, msg: result.msg));
    }
  }

  createAddress() async {
    emit(state.copyWith(createAddress: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.createAddress,
      body: {
        "ApartmentType": apartmentType?.id?.toString(),
        "BuildingNumber": buildingNumber.text,
        "ApartmentNumber": apartmentNumber.text,
        "City": city?.id,
        "CityName": city?.name,
        "District": district?.id,
        "DistrictName": district?.name,
        "Latitude": latLng?.latitude.toString(),
        "Longitude": latLng?.longitude.toString(),
        "FullAddress": fullAddress.text,
        "FloorNumber": floorNumber.text,
        "Contact": UserModel.i.contactId,
        "Name": name.text,
      },
    );
    if (result.success) {
      emit(state.copyWith(createAddress: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(createAddress: RequestState.error, msg: result.msg));
    }
  }

  getCities() async {
    await citiesBloc.getCities();
    if (citiesBloc.state.requestState.isDone) {
      cities = citiesBloc.cities;
    } else {
      await getCities();
    }
  }

  Future<void> getDistricts() async {
    emit(state.copyWith(getDistricts: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.districts, params: {'cityId': city?.id});
    if (result.success) {
      districts = List<DistrictModel>.from(result.data['data'].map((x) => DistrictModel.fromJson(x)));
      emit(state.copyWith(getDistricts: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(getDistricts: RequestState.error, msg: result.msg));
    }
  }

  Future<void> deleteAddress(AddressModel address) async {
    LoadingDialog.show();
    emit(state.copyWith(deleteAddressState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.deleteAddress, params: {'addressID': address.id});
    LoadingDialog.hide();

    if (result.success) {
      addresses.remove(address);
      emit(state.copyWith(deleteAddressState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(deleteAddressState: RequestState.error, msg: result.msg));
    }
  }
}
