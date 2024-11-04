import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../models/address_model.dart';
import '../../../models/book_hourly_input_model.dart';
import '../../../models/hourly_package_model.dart';
import '../../../models/nationality_model.dart';
import '../../../models/user.dart';
import 'hourly_service_state.dart';

class HourlyServiceBloc extends Cubit<HourlyServiceState> {
  HourlyServiceBloc() : super(HourlyServiceState());

  List<HourlyPackageModel> pacages = [];
  List<HourlyPackageModel> get filteredPacages => pacages.where((e) => inputData.showPackage(e)).toList();
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

  createBooking() async {
    emit(state.copyWith(bookingState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: AppConstants.createHourlyContract,
      body: inputData.toJson(),
    );
    if (result.success) {
      await push(NamedRoutes.paymentIfream, arg: {'id': result.data['data']['id']});
      emit(state.copyWith(bookingState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(bookingState: RequestState.error, msg: result.msg));
    }
  }
}
