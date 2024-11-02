import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/services/server_gate.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/core/widgets/select_item_sheet.dart';
import 'package:ziena/models/address_model.dart';
import 'package:ziena/models/book_hourly_input_model.dart';
import 'package:ziena/models/nationality_model.dart';
import 'package:ziena/models/user.dart';

import '../../../models/hourly_package_model.dart';
import 'hourly_service_state.dart';

class HourlyServiceBloc extends Cubit<HourlyServiceState> {
  HourlyServiceBloc() : super(HourlyServiceState());

  List<HourlyPackageModel> pacages = [];
  List<AddressModel> addresses = [];
  List<NationalityModel> avilableNationalities = [];
  List<SelectModel> avilableShifts = [];
  BookHourlyInputModel inputData = BookHourlyInputModel();

  getPacages(String id) async {
    if (pacages.isNotEmpty) {
      inputData = BookHourlyInputModel();
      return;
    }
    emit(state.copyWith(getPacagesState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: AppConstants.hourlyPackages, body: {
      "Service": id,
    });
    if (result.success) {
      pacages = result.data['data'].map<HourlyPackageModel>((e) => HourlyPackageModel.fromJson(e)).toList();
      avilableNationalities = pacages.map((e) => e.nationality).toSet().toList();
      if (avilableNationalities.length == 1) inputData.nationality = avilableNationalities.first;
      avilableShifts = pacages.map((e) => SelectModel(id: e.shift, name: e.shiftName)).toSet().toList();
      if (avilableShifts.length == 1) inputData.period = avilableShifts.first;
      emit(state.copyWith(getPacagesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(getPacagesState: RequestState.error, msg: result.msg));
    }
  }

  getAddresses() async {
    emit(state.copyWith(addressesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: AppConstants.getAddresses,
      params: {"contactId": UserModel.i.contactId},
    );
    if (result.success) {
      addresses = result.data['data'].map<AddressModel>((e) => AddressModel.fromJson(e)).toList();
      emit(state.copyWith(addressesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(addressesState: RequestState.error, msg: result.msg));
    }
  }
}
