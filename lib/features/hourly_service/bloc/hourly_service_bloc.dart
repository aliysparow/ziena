import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/address_model.dart';
import '../../../models/book_hourly_input_model.dart';
import '../../../models/hourly_package_model.dart';
import '../../../models/nationality_model.dart';
import '../../../models/shift_model.dart';
import '../../../models/user_model.dart';
import '../../../models/visits_per_week_mode.dart';
import '../../../models/week_number_model.dart';
import 'hourly_service_state.dart';

class HourlyServiceBloc extends Cubit<HourlyServiceState> {
  HourlyServiceBloc() : super(HourlyServiceState());

  List<HourlyPackageModel> pacages = [];
  List<HourlyPackageModel> get filteredPacages =>
      pacages.where((e) => inputData.showPackage(e)).toList();
  List<AddressModel> addresses = [];
  List<NationalityModel> countriesForHourly = [];
  List<NationalityModel> avilableNationalities = [];
  List<SelectModel> avilableShifts = [];
  List<WeekNumberModel> weeksNumber = [];
  List<VisitsPerWeekMode> visitsPerWeek = [];
  List<ShiftModel> shiftsForPricing = [];
  BookHourlyInputModel inputData = BookHourlyInputModel();

  getPacages(String id) async {
    if (pacages.isNotEmpty) {
      inputData = BookHourlyInputModel();
      return;
    }
    emit(state.copyWith(getPacagesState: RequestState.loading));
    final result = await ServerGate.i
        .sendToServer(url: ApiConstants.hourlyPackages, body: {
      "Service": id,
    });
    if (result.success) {
      pacages = result.data['data']
          .map<HourlyPackageModel>((e) => HourlyPackageModel.fromJson(e))
          .toList();
      avilableNationalities =
          pacages.map((e) => e.nationality).toSet().toList();
      if (avilableNationalities.length == 1) {
        inputData.nationalityFilter = avilableNationalities.first;
      } else {
        avilableNationalities.insert(
            0, NationalityModel(name: LocaleKeys.all.tr(), id: ''));
        inputData.nationalityFilter = avilableNationalities.first;
      }
      avilableShifts = pacages
          .map((e) => SelectModel(id: e.shift, name: e.shiftName))
          .toSet()
          .toList();
      if (avilableShifts.length == 1) {
        inputData.period = avilableShifts.first;
      } else {
        avilableShifts.insert(
            0, SelectModel(id: '', name: LocaleKeys.all.tr()));
        inputData.period = avilableShifts.first;
      }
      emit(state.copyWith(getPacagesState: RequestState.done, msg: result.msg));
    } else {
      emit(
          state.copyWith(getPacagesState: RequestState.error, msg: result.msg));
    }
  }

  getAddresses([bool selectLast = false]) async {
    emit(state.copyWith(addressesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getAddresses,
      params: {"contactId": UserModel.i.contactId},
    );
    if (result.success) {
      addresses = result.data['data']
          .map<AddressModel>((e) => AddressModel.fromJson(e))
          .toList();
      if (selectLast) inputData.address = addresses.last;
      emit(state.copyWith(addressesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(addressesState: RequestState.error, msg: result.msg));
    }
  }

  createBooking() async {
    emit(state.copyWith(bookingState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
        url: ApiConstants.createHourlyContract, body: inputData.toJson(false));
    if (result.success) {
      push(
        NamedRoutes.successfullyPage,
        arg: {
          'image': Assets.images.successfully,
          'title': LocaleKeys.operation_successful.tr(),
          'subtitle': LocaleKeys.contract_booked_successfully_val
              .tr(args: ['${result.data['data']['ContractNumber']}']),
          "btnTitle": LocaleKeys.pay_now.tr(),
          "onTap": () {
            push(NamedRoutes.paymentIfream,
                arg: {"id": result.data['data']['Id']}).then(
              (value) => Navigator.popUntil(
                  navigator.currentContext!, (r) => r.isFirst),
            );
          },
        },
      ).then(
        (value) =>
            Navigator.popUntil(navigator.currentContext!, (r) => r.isFirst),
      );
      emit(state.copyWith(bookingState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(bookingState: RequestState.error, msg: result.msg));
    }
  }

  suggestedDays() async {
    alternativeMessage = null;
    emit(state.copyWith(
        suggestedDaysState: RequestState.loading,
        getAlternativeDatesMessage: RequestState.initial));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.getAvailableDates,
      body: inputData.toJson(true),
    );
    if (result.success) {
      inputData.actDates = List<DateTime>.from((result.data['data'] ?? [])
          .map((e) => DateTime.tryParse(e)?.toLocal() ?? DateTime.now()));
      if (inputData.actDates.firstOrNull
              ?.sameDay(inputData.dates.firstOrNull) ==
          false) {
        alternativeDatesMessage();
      }
      emit(state.copyWith(suggestedDaysState: RequestState.done));
      Future.delayed(1.seconds);
      emit(state.copyWith(suggestedDaysState: RequestState.initial));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(
          suggestedDaysState: RequestState.error, msg: result.msg));
    }
  }

  String? alternativeMessage;
  alternativeDatesMessage() async {
    emit(state.copyWith(getAlternativeDatesMessage: RequestState.loading));
    final result = await ServerGate.i
        .getFromServer(url: ApiConstants.getAlternativeDatesMessage);
    if (result.success) {
      alternativeMessage = result.data['data'];
      emit(state.copyWith(getAlternativeDatesMessage: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(
          getAlternativeDatesMessage: RequestState.error, msg: result.msg));
    }
  }

  getWeeksNumber() async {
    emit(state.copyWith(getGetWeeksNumber: RequestState.loading));
    final result =
        await ServerGate.i.getFromServer(url: ApiConstants.getWeeksNumber);
    if (result.success) {
      final List list = result.data['data'] ?? [];
      weeksNumber = List<WeekNumberModel>.from(
          list.map((e) => WeekNumberModel.fromJson(e)));
      emit(state.copyWith(
          getGetWeeksNumber: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(
          getGetWeeksNumber: RequestState.error, msg: result.msg));
    }
  }

  getVisitsPerWeek() async {
    emit(state.copyWith(getVisitsPerWeek: RequestState.loading));
    final result =
        await ServerGate.i.getFromServer(url: ApiConstants.getVisitsPerWeek);
    if (result.success) {
      final List list = result.data['data'] ?? [];
      visitsPerWeek = List<VisitsPerWeekMode>.from(
          list.map((e) => VisitsPerWeekMode.fromJson(e)));
      emit(
          state.copyWith(getVisitsPerWeek: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(
          getVisitsPerWeek: RequestState.error, msg: result.msg));
    }
  }

  getAllShiftsForPricing() async {
    emit(state.copyWith(getAllShiftsForPricing: RequestState.loading));
    final result = await ServerGate.i
        .getFromServer(url: ApiConstants.getAllShiftsForPricing);
    if (result.success) {
      final List list = result.data['data'] ?? [];
      shiftsForPricing =
          List<ShiftModel>.from(list.map((e) => ShiftModel.fromJson(e)));
      emit(state.copyWith(
          getAllShiftsForPricing: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(
          getAllShiftsForPricing: RequestState.error, msg: result.msg));
    }
  }

  getCountriesForHourlyPricing() async {
    emit(state.copyWith(getCountriesForHourlyPricing: RequestState.loading));
    final result = await ServerGate.i
        .getFromServer(url: ApiConstants.getCountriesForHourlyPricing);
    if (result.success) {
      final List list = result.data['data'] ?? [];
      countriesForHourly = List<NationalityModel>.from(
          list.map((e) => NationalityModel.fromJson(e)));
      emit(state.copyWith(
          getCountriesForHourlyPricing: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(
          getCountriesForHourlyPricing: RequestState.error, msg: result.msg));
    }
  }

  getPricingDetails() async {
    emit(state.copyWith(getPricingDetails: RequestState.loading));
    final result = await ServerGate.i
        .sendToServer(url: ApiConstants.getPricingDetails, body: {
      "Nationality": inputData.nationality?.id,
      "VisitNumberPerWeek": inputData.selectedVisitPerWeek?.id,
      "WeekNumber": inputData.selectedWeek?.id,
      "Shift": inputData.shift?.id,
    });
    if (result.success) {
      // inputData.initialPrice =
      //     result.data?['data']?['InitialPrice']?.toString() ?? '';
      inputData.initialPrice =
          result.data?['data']?['FinalPrice']?.toString() ?? '';
      emit(state.copyWith(
          getPricingDetails: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(
          getPricingDetails: RequestState.error, msg: result.msg));
    }
  }

  refresh() async {
    emit(state.copyWith(getPacagesState: RequestState.loading));
    emit(state.copyWith(getPacagesState: RequestState.done));
  }
}
