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

final json = {
  "\$id": "1",
  "data": [
    {
      "\$id": "2",
      "Id": "53c3d829-72a3-ef11-8bcd-20040ff72aa5",
      "Name": "رقم الزيارة: H442-01",
      "ContractNumberStr": "رقم العقد: H442",
      "VisitNumber": "H442-01",
      "ContractNumber02": "H442",
      "StartTime": "19/05/1446 08:00 ص",
      "StartTimeDate": "2024-11-21T08:00:00",
      "EndTime": "19/05/1446 12:00 م",
      "ActualStartTime": "",
      "ActualEndTime": "",
      "CustomerName": "اسم العميل: tamer elsayad",
      "Duration": 4,
      "EmployeeName": "اسم العامل: ايانيس بنت امبينغ صاعيب",
      "ServiceName": null,
      "ShiftName": "الفترة الصباحية",
      "Mobile01Text": "جوال 1: 0542318760",
      "Mobile02Text": "جوال 2: 0543442233",
      "Mobile03Text": "جوال 3: ",
      "Mobile01": "0542318760",
      "Mobile02": "0543442233",
      "Mobile03": "",
      "WorkerImage":
          "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",
      "WorkerId": "d884be6b-011f-ea11-8b86-20040ff72aa5",
      "ContactId": "25eb49b0-7370-ec11-8ba4-20040ff72aa5",
      "IsLaborBlocked": false,
      "IsLaborFavorite": false,
      "StatusCode": 1,
      "StatusCodeName": "نشط",
      "StatusColor": "#FFFF00",
      "ButtonText": "ابدأ الرحلة",
      "Lat": "24.652258468446355",
      "Long": "46.72552714473063",
      "Address": "f1d86531-c5a2-ef11-8bcd-20040ff72aa5",
      "MapURL": "http://maps.google.com/maps?q=24.652258468446355,46.72552714473063",
      "AllowReschedule": true,
      "DriverMobile": "",
      "LaborMobile": "0550075985"
    },
    {
      "\$id": "3",
      "Id": "ab5bbcba-b9a4-ef11-8bcd-20040ff72aa5",
      "Name": "رقم الزيارة: H443-01",
      "ContractNumberStr": "رقم العقد: H443",
      "VisitNumber": "H443-01",
      "ContractNumber02": "H443",
      "StartTime": "19/05/1446 08:00 ص",
      "StartTimeDate": "2024-11-21T08:00:00",
      "EndTime": "19/05/1446 12:00 م",
      "ActualStartTime": "",
      "ActualEndTime": "",
      "CustomerName": "اسم العميل: tamer elsayad",
      "Duration": 4,
      "EmployeeName": "اسم العامل: ايانيس بنت امبينغ صاعيب",
      "ServiceName": null,
      "ShiftName": "الفترة الصباحية",
      "Mobile01Text": "جوال 1: 0542318760",
      "Mobile02Text": "جوال 2: 0561628311",
      "Mobile03Text": "جوال 3: ",
      "Mobile01": "0542318760",
      "Mobile02": "0561628311",
      "Mobile03": "",
      "WorkerImage":
          "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",
      "WorkerId": "d884be6b-011f-ea11-8b86-20040ff72aa5",
      "ContactId": "25eb49b0-7370-ec11-8ba4-20040ff72aa5",
      "IsLaborBlocked": false,
      "IsLaborFavorite": false,
      "StatusCode": 1,
      "StatusCodeName": "نشط",
      "StatusColor": "#FFFF00",
      "ButtonText": "ابدأ الرحلة",
      "Lat": "24.652258468446355",
      "Long": "46.72552714473063",
      "Address": "f1d86531-c5a2-ef11-8bcd-20040ff72aa5",
      "MapURL": "http://maps.google.com/maps?q=24.652258468446355,46.72552714473063",
      "AllowReschedule": true,
      "DriverMobile": "",
      "LaborMobile": "0550075985"
    },
    {
      "\$id": "4",
      "Id": "49620882-baa4-ef11-8bcd-20040ff72aa5",
      "Name": "رقم الزيارة: H443-01-Res",
      "ContractNumberStr": "رقم العقد: H443",
      "VisitNumber": "H443-01-Res",
      "ContractNumber02": "H443",
      "StartTime": "19/05/1446 08:00 ص",
      "StartTimeDate": "2024-11-21T08:00:00",
      "EndTime": "19/05/1446 12:00 م",
      "ActualStartTime": "",
      "ActualEndTime": "",
      "CustomerName": "اسم العميل: tamer elsayad",
      "Duration": 4,
      "EmployeeName": "اسم العامل: ايانيس بنت امبينغ صاعيب",
      "ServiceName": null,
      "ShiftName": "الفترة الصباحية",
      "Mobile01Text": "جوال 1: 0542318760",
      "Mobile02Text": "جوال 2: 0561628311",
      "Mobile03Text": "جوال 3: ",
      "Mobile01": "0542318760",
      "Mobile02": "0561628311",
      "Mobile03": "",
      "WorkerImage":
          "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",
      "WorkerId": "d884be6b-011f-ea11-8b86-20040ff72aa5",
      "ContactId": "25eb49b0-7370-ec11-8ba4-20040ff72aa5",
      "IsLaborBlocked": false,
      "IsLaborFavorite": false,
      "StatusCode": 1,
      "StatusCodeName": "نشط",
      "StatusColor": "#FFFF00",
      "ButtonText": "ابدأ الرحلة",
      "Lat": "24.652258468446355",
      "Long": "46.72552714473063",
      "Address": "f1d86531-c5a2-ef11-8bcd-20040ff72aa5",
      "MapURL": "http://maps.google.com/maps?q=24.652258468446355,46.72552714473063",
      "AllowReschedule": true,
      "DriverMobile": "",
      "LaborMobile": "0550075985"
    }
  ],
  "totalItems": 3
};
