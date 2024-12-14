import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ziena/models/worker_model.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/address_model.dart';
import '../../../models/individaul_package_model.dart';
import '../../../models/user_model.dart';
import 'individual_packages_state.dart';

class IndividualPackagesCubit extends Cubit<IndividualPackagesState> {
  IndividualPackagesCubit() : super(IndividualPackagesState());

  List<IndividaulPackageModel> packages = [];
  final input = CreateIndividualInput();
  String contractId = '';

  Future<void> getPackages(String id) async {
    emit(state.copyWith(getPackages: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getIndividualPackages,
      params: {"serviceId": id},
    );
    if (result.success) {
      packages = List<IndividaulPackageModel>.from((result.data['data'] ?? []).map((x) {
        x['ServiceId'] = id;
        return IndividaulPackageModel.fromJson(x);
      }));
      emit(state.copyWith(getPackages: RequestState.done));
    } else {
      emit(state.copyWith(getPackages: RequestState.error, msg: result.msg));
    }
  }

  Future<void> createIndividualRequest() async {
    emit(state.copyWith(createIndividualRequest: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.createIndvContract,
      body: {
        "ContactId": UserModel.i.contactId,
        "PriceDetails": input.package?.id,
        "AddressId": input.address?.id,
        "Nationality": input.package?.nationality.id,
        "Source": 1,
        "EmpId": input.worker?.id,
      },
    );
    if (result.success) {
      contractId = result.data?['data']?['Id'];
      emit(state.copyWith(createIndividualRequest: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(createIndividualRequest: RequestState.error, msg: result.msg));
    }
  }

  List<AddressModel> addresses = [];
  getAddresses([bool firstTime = false]) async {
    if (!firstTime) emit(state.copyWith(getAddresses: RequestState.loading));
    if (addresses.isNotEmpty) return emit(state.copyWith(getAddresses: RequestState.done));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getAddresses,
      params: {"contactId": UserModel.i.contactId},
    );
    if (result.success) {
      addresses = result.data['data'].map<AddressModel>((e) => AddressModel.fromJson(e)).toList();
      if (firstTime) {
        firstTime = false;
        return;
      }
      emit(state.copyWith(getAddresses: RequestState.done, msg: result.msg));
    } else {
      if (firstTime) {
        firstTime = false;
        return;
      }
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(getAddresses: RequestState.error, msg: result.msg));
    }
  }

  List<WorkerModel> workers = [];

  getWorkers(String id, [bool firstTime = false]) async {
    if (!firstTime) emit(state.copyWith(getWorkers: RequestState.loading));
    if (workers.isNotEmpty) return emit(state.copyWith(getWorkers: RequestState.done));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getWorkers,
      params: {"serviceId": id},
    );
    if (result.success) {
      workers = result.data['data'].map<WorkerModel>((e) => WorkerModel.fromJson(e)).toList();
      if (workers.isEmpty) {
        FlashHelper.showToast(LocaleKeys.there_are_no_workers_for_this_service.tr());
        return emit(state.copyWith(getWorkers: RequestState.error));
      }
      if (firstTime) {
        firstTime = false;
        return;
      }
      emit(state.copyWith(getWorkers: RequestState.done, msg: result.msg));
    } else {
      if (firstTime) {
        firstTime = false;
        return;
      }
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(getWorkers: RequestState.error, msg: result.msg));
    }
  }
}

class CreateIndividualInput {
  IndividaulPackageModel? package;
  AddressModel? address;
  WorkerModel? worker;
}
