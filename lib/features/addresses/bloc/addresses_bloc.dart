import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ziena/core/services/server_gate.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/core/widgets/select_item_sheet.dart';
import 'package:ziena/features/addresses/bloc/addresses_state.dart';
import 'package:ziena/models/address_model.dart';
import 'package:ziena/models/city_model.dart';
import 'package:ziena/models/district_model.dart';
import 'package:ziena/models/user.dart';

class AddressesBloc extends Cubit<AddressesState> {
  AddressesBloc() : super(AddressesState());

  List<AddressModel> addresses = [];

  SelectModel? apartmentType;
  final buildingNumber = TextEditingController();
  final apartmentNumber = TextEditingController();
  final fullAddress = TextEditingController();
  final floorNumber = TextEditingController();
  final name = TextEditingController();
  CityModel? city;
  DistrictModel? district;
  LatLng? latLng;

  getAddresses() async {
    emit(state.copyWith(getAddresses: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: AppConstants.getAddresses,
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
    emit(state.copyWith(getAddresses: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: AppConstants.createAddress,
      params: {
        "ApartmentType": apartmentType?.id,
        "BuildingNumber": buildingNumber.text,
        "ApartmentNumber": apartmentNumber.text,
        "City": city?.id,
        "CityName": city?.name,
        "District": district?.id,
        "DistrictName": district?.name,
        "Latitude": latLng?.latitude,
        "Longitude": latLng?.longitude,
        "FullAddress": fullAddress,
        "FloorNumber": floorNumber.text,
        "Contact": UserModel.i.contactId,
        "Name": name.text,
      },
    );
    if (result.success) {
      addresses = result.data['data'].map<AddressModel>((e) => AddressModel.fromJson(e)).toList();
      emit(state.copyWith(getAddresses: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(getAddresses: RequestState.error, msg: result.msg));
    }
  }
}
