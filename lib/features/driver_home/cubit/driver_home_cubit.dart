import 'package:bloc/bloc.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../models/order_model.dart';
import '../../../models/reason_model.dart';
import '../../../models/shift_model.dart';
import '../../../models/user_model.dart';
import 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  DriverHomeCubit() : super(DriverHomeState());

  List<ShiftModel> shifts = [];
  List<OrderModel> orders = [];
  List<ReasonModel> reasons = [];
  ShiftModel? selectedShift;
  SelectModel selectedDriverType = AppConstants.deliverType.first;

  Future<void> getOrders(ShiftModel shift, SelectModel type) async {
    emit(state.copyWith(getOrderState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.todayDeliveringVisits, params: {
      "driverId": UserModel.i.driverId,
      "shiftId": shift.id,
      "deliverType": type.id,
    });
    if (selectedShift != shift) return;
    if (result.success) {
      orders = List<OrderModel>.from((result.data['data'] ?? []).map((x) => OrderModel.fromJson(x)));
      emit(state.copyWith(getOrderState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(getOrderState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getTodayShifts() async {
    emit(state.copyWith(shiftsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getTodayShifts);
    if (result.success) {
      shifts = List<ShiftModel>.from((result.data['data'] ?? []).map((x) => ShiftModel.fromJson(x)));
      selectedShift = shifts.firstOrNull;
      if (selectedShift != null) getOrders(selectedShift!, selectedDriverType);
      emit(state.copyWith(shiftsState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(shiftsState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getReasons() async {
    emit(state.copyWith(getReasonsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getCancelReasons);
    if (result.success) {
      reasons = List<ReasonModel>.from((result.data['data'] ?? []).map((x) => ReasonModel.fromJson(x)));
      emit(state.copyWith(getReasonsState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(getReasonsState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> rejectOrder({required OrderModel item, required String reason, required String note}) async {
    emit(state.copyWith(rejectOrderState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.setVisitStatus, body: {
      'visitId': item.id,
      'status': '176190018',
      'cancelReason': reason,
      'notes': note,
    });
    if (result.success) {
      orders.remove(item);
      getOrders(selectedShift!, selectedDriverType);
      emit(state.copyWith(rejectOrderState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(rejectOrderState: RequestState.error, msg: result.msg));
    }
  }

  OrderModel? selectedOrder;
  Future<void> changeStatus({required OrderModel item}) async {
    selectedOrder = item;
    emit(state.copyWith(changeStatus: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.setVisitNextStatus, params: {
      'visitId': item.id,
      'type': selectedDriverType.id,
    });
    if (result.success) {
      // getOrders(selectedShift!, selectedDriverType);
      getVisit(item);
      emit(state.copyWith(changeStatus: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(changeStatus: RequestState.error, msg: result.msg));
    }
  }

  getVisit(OrderModel item) async {
    emit(state.copyWith(getVisit: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getVisitById, params: {'visitId': item.id});
    if (result.success) {
      final data = OrderModel.fromJson(result.data['data']);
      if ([176190007, 176190008].contains(data.statusCode)) {
        orders.remove(data);
      } else {
        orders = orders.map((e) => e == data ? data : e).toList();
      }
      emit(state.copyWith(getOrderState: RequestState.loading));
      emit(state.copyWith(getVisit: RequestState.done, msg: result.msg, getOrderState: RequestState.done));
    } else {
      emit(state.copyWith(getVisit: RequestState.error, msg: result.msg));
    }
  }
}
