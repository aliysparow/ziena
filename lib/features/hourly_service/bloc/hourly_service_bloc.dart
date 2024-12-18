import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/gen/assets.gen.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../models/address_model.dart';
import '../../../models/book_hourly_input_model.dart';
import '../../../models/hourly_package_model.dart';
import '../../../models/nationality_model.dart';
import '../../../models/user_model.dart';
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
    final result = await ServerGate.i.sendToServer(url: ApiConstants.hourlyPackages, body: {
      "Service": id,
    });
    if (result.success) {
      pacages = result.data['data'].map<HourlyPackageModel>((e) => HourlyPackageModel.fromJson(e)).toList();
      avilableNationalities = pacages.map((e) => e.nationality).toSet().toList();
      if (avilableNationalities.length == 1) {
        inputData.nationality = avilableNationalities.first;
      } else {
        avilableNationalities.insert(0, NationalityModel(name: LocaleKeys.all.tr(), id: ''));
        inputData.nationality = avilableNationalities.first;
      }
      avilableShifts = pacages.map((e) => SelectModel(id: e.shift, name: e.shiftName)).toSet().toList();
      if (avilableShifts.length == 1) {
        inputData.period = avilableShifts.first;
      } else {
        avilableShifts.insert(0, SelectModel(id: '', name: LocaleKeys.all.tr()));
        inputData.period = avilableShifts.first;
      }
      emit(state.copyWith(getPacagesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(getPacagesState: RequestState.error, msg: result.msg));
    }
  }

  getAddresses([bool selectLast = false]) async {
    emit(state.copyWith(addressesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getAddresses,
      params: {"contactId": UserModel.i.contactId},
    );
    if (result.success) {
      addresses = result.data['data'].map<AddressModel>((e) => AddressModel.fromJson(e)).toList();
      if (selectLast) inputData.address = addresses.last;
      emit(state.copyWith(addressesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(addressesState: RequestState.error, msg: result.msg));
    }
  }

  createBooking() async {
    emit(state.copyWith(bookingState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.createHourlyContract,
      body: inputData.toJson(),
    );
    if (result.success) {
      push(
        NamedRoutes.successfullyPage,
        arg: {
          'image': Assets.images.successfully,
          'title': LocaleKeys.operation_successful.tr(),
          'subtitle': LocaleKeys.contract_booked_successfully_val.tr(args: ['${result.data['data']['ContractNumber']}']),
          "btnTitle": LocaleKeys.pay_now.tr(),
          "onTap": () {
            push(
              NamedRoutes.paymentIfream,
              arg: {
                "id": result.data['data']['Id'],
              },
            ).then(
              (value) => Navigator.popUntil(
                navigator.currentContext!,
                (r) => r.isFirst,
              ),
            );
          },
        },
      ).then(
        (value) => Navigator.popUntil(
          navigator.currentContext!,
          (r) => r.isFirst,
        ),
      );
      emit(
        state.copyWith(
          bookingState: RequestState.done,
          msg: result.msg,
        ),
      );
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(bookingState: RequestState.error, msg: result.msg));
    }
  }
}
