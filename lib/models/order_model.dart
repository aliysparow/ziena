import 'base.dart';

class OrderModel extends Model {
  late final String name,
      contractNumberStr,
      visitNumber,
      contractNumber02,
      startTime,
      startTimeDate,
      endTime,
      actualStartTime,
      actualEndTime,
      customerName,
      employeeName,
      serviceName,
      shiftName,
      mobile01Text,
      mobile02Text,
      mobile03Text,
      mobile01,
      mobile02,
      mobile03,
      workerImage,
      workerId,
      contactId,
      statusCodeName,
      statusColor,
      buttonText,
      address,
      mapUrl,
      driverMobile,
      laborMobile;

  late final double lat, long;
  late final int duration, statusCode;
  late bool isLaborBlocked, isLaborFavorite, allowReschedule;

  OrderModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
    contractNumberStr = stringFromJson(json, "ContractNumberStr");
    visitNumber = stringFromJson(json, "VisitNumber");
    contractNumber02 = stringFromJson(json, "ContractNumber02");
    startTime = stringFromJson(json, "StartTime");
    startTimeDate = stringFromJson(json, "StartTimeDate");
    endTime = stringFromJson(json, "EndTime");
    actualStartTime = stringFromJson(json, "ActualStartTime");
    actualEndTime = stringFromJson(json, "ActualEndTime");
    customerName = stringFromJson(json, "CustomerName");
    employeeName = stringFromJson(json, "EmployeeName");
    serviceName = stringFromJson(json, "ServiceName");
    shiftName = stringFromJson(json, "ShiftName");
    mobile01Text = stringFromJson(json, "Mobile01Text");
    mobile02Text = stringFromJson(json, "Mobile02Text");
    mobile03Text = stringFromJson(json, "Mobile03Text");
    mobile01 = stringFromJson(json, "Mobile01");
    mobile02 = stringFromJson(json, "Mobile02");
    mobile03 = stringFromJson(json, "Mobile03");
    workerImage = stringFromJson(json, "WorkerImage");
    workerId = stringFromJson(json, "WorkerId");
    contactId = stringFromJson(json, "ContactId");
    statusCodeName = stringFromJson(json, "StatusCodeName");
    statusColor = stringFromJson(json, "StatusColor");
    buttonText = stringFromJson(json, "ButtonText");
    address = stringFromJson(json, "Address");
    mapUrl = stringFromJson(json, "MapURL");
    driverMobile = stringFromJson(json, "DriverMobile");
    laborMobile = stringFromJson(json, "LaborMobile");
    lat = doubleFromJson(json, "Lat");
    long = doubleFromJson(json, "Long");
    duration = intFromJson(json, "Duration");
    statusCode = intFromJson(json, "StatusCode");
    isLaborBlocked = boolFromJson(json, "IsLaborBlocked");
    isLaborFavorite = boolFromJson(json, "IsLaborFavorite");
    allowReschedule = boolFromJson(json, "AllowReschedule");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "ContractNumberStr": contractNumberStr,
        "VisitNumber": visitNumber,
        "ContractNumber02": contractNumber02,
        "StartTime": startTime,
        "StartTimeDate": startTimeDate,
        "EndTime": endTime,
        "ActualStartTime": actualStartTime,
        "ActualEndTime": actualEndTime,
        "CustomerName": customerName,
        "EmployeeName": employeeName,
        "ServiceName": serviceName,
        "ShiftName": shiftName,
        "Mobile01Text": mobile01Text,
        "Mobile02Text": mobile02Text,
        "Mobile03Text": mobile03Text,
        "Mobile01": mobile01,
        "Mobile02": mobile02,
        "Mobile03": mobile03,
        "WorkerImage": workerImage,
        "WorkerId": workerId,
        "ContactId": contactId,
        "StatusCodeName": statusCodeName,
        "StatusColor": statusColor,
        "ButtonText": buttonText,
        "Address": address,
        "MapURL": mapUrl,
        "DriverMobile": driverMobile,
        "LaborMobile": laborMobile,
        "Lat": lat,
        "Long": long,
        "Duration": duration,
        "StatusCode": statusCode,
        "IsLaborBlocked": isLaborBlocked,
        "IsLaborFavorite": isLaborFavorite,
        "AllowReschedule": allowReschedule,
      };
}
