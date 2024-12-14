import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/core/widgets/loading.dart';
import 'package:ziena/gen/locale_keys.g.dart';
import 'package:ziena/models/order_model.dart';
import 'package:ziena/models/visit_model.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../models/contract_model.dart';
import '../../../models/user_model.dart';
import 'contracts_state.dart';

class ContractsCubit extends Cubit<ContractsState> {
  ContractsCubit() : super(ContractsState());

  List<ContractModel> contracts = [];
  List<OrderModel> orders = [];
  List<VisitModel> visits = [];

  getContracts(ContractType type) async {
    emit(state.copyWith(contractState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: type.url,
      params: {"userId": UserModel.i.id},
    );
    if (result.success) {
      contracts = List<ContractModel>.from((result.data['data'] ?? []).map((x) => ContractModel.fromJson(x)));
      emit(state.copyWith(contractState: RequestState.done));
    } else {
      emit(state.copyWith(contractState: RequestState.error, msg: result.msg));
    }
  }

  getVisits(VisitsType type) async {
    emit(state.copyWith(visitsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: type.url,
      params: {
        "contactID": UserModel.i.id,
        "userId": UserModel.i.id,
      },
    );
    if (result.success) {
      visits = List<VisitModel>.from((result.data['data'] ?? []).map((x) => VisitModel.fromJson(x)));
      // visits.add(VisitModel.fromJson({}));
      emit(state.copyWith(visitsState: RequestState.done));
    } else {
      emit(state.copyWith(visitsState: RequestState.error, msg: result.msg));
    }
  }

  reschduleVisit(String id, DateTime date) async {
    LoadingDialog.show();
    emit(state.copyWith(reschduleVisitState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.reschduleVisit,
      params: {"VisitId": id, "Date": date.toString()},
    );
    LoadingDialog.hide();
    if (result.success) {
      // visits = List<VisitModel>.from((result.data['data'] ?? []).map((x) => VisitModel.fromJson(x)));
      // visits.add(VisitModel.fromJson({}));
      emit(state.copyWith(reschduleVisitState: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(reschduleVisitState: RequestState.error, msg: result.msg));
    }
  }

  rateVisit({required String visitId, required double rate, required String rateNotes}) async {
    LoadingDialog.show();
    emit(state.copyWith(reschduleVisitState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.rateVisit,
      params: {
        "VisitId": visitId,
        "Rate": rate,
        "RateNotes": rateNotes,
      },
    );
    LoadingDialog.hide();
    if (result.success) {
      FlashHelper.showToast(result.msg, type: MessageType.success);
      emit(state.copyWith(reschduleVisitState: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(reschduleVisitState: RequestState.error, msg: result.msg));
    }
  }

  setFavoriteLabor({required String workerId}) async {
    LoadingDialog.show();
    emit(state.copyWith(setFavoriteLaborState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.setFavoriteLabor,
      params: {
        "userId": UserModel.i.id,
        "laborId": workerId,
      },
    );
    LoadingDialog.hide();
    if (result.success) {
      FlashHelper.showToast(result.msg, type: MessageType.success);
      emit(state.copyWith(setFavoriteLaborState: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(setFavoriteLaborState: RequestState.error, msg: result.msg));
    }
  }

  blockLabor({required String workerId, required String note}) async {
    LoadingDialog.show();
    emit(state.copyWith(blockLaborState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.blockLabor,
      params: {
        "userId": UserModel.i.id,
        "laborId": workerId,
        "Notes": note,
      },
    );
    LoadingDialog.hide();

    if (result.success) {
      FlashHelper.showToast(result.msg, type: MessageType.success);
      emit(state.copyWith(blockLaborState: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(blockLaborState: RequestState.error, msg: result.msg));
    }
  }

  getOrders() async {
    emit(state.copyWith(contractState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getIndividualReqsByUserId,
      params: {"userId": UserModel.i.id},
    );
    if (result.success) {
      orders = List<OrderModel>.from((result.data['data'] ?? []).map((x) => OrderModel.fromJson(x)));
      emit(state.copyWith(contractState: RequestState.done));
    } else {
      emit(state.copyWith(contractState: RequestState.error, msg: result.msg));
    }
  }
}

enum ContractType {
  upcoming,
  finished;

  String get url => this == ContractType.finished ? ApiConstants.finishedHourlyContracts : ApiConstants.upcomingHourlyContracts;
  String get name => this == ContractType.upcoming ? LocaleKeys.my_active_contracts.tr() : LocaleKeys.my_inactive_contracts.tr();
}

enum VisitsType {
  upcoming,
  finished;

  String get url => this == VisitsType.upcoming ? ApiConstants.getUpcomingVisits : ApiConstants.getCompletedVisits;
  String get name => this == VisitsType.upcoming ? LocaleKeys.next_visits.tr() : LocaleKeys.complete_visits.tr();
}
