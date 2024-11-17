import 'base.dart';

class VisitModel extends Model {
  late final String name;
  late final String startTime;
  late final String endTime;
  late final String actualStartTime;
  late final String actualEndTime;
  late final String contractNumber;
  late final String customerName;
  late final int duration;
  late final String employeeName;
  late final String serviceName;
  late final String shiftName;
  late final String mobile01Text;
  late final String mobile02Text;
  late final String mobile01;
  late final String mobile02;
  late final dynamic workerImage;
  late final int statusCode;
  late final String statusCodeName;
  late final String statusColor;
  late final String buttonText;
  late final String lat;
  late final String long;
  late final dynamic address;
  late final String mapUrl;
  late final String visitNumber;
  late final String contractNumber02;
  late final String workerId;
  late final bool isLaborBlocked;
  late final bool isLaborFavorite;
  late final bool isAllowReschedule;

  VisitModel({
    super.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.actualStartTime,
    required this.actualEndTime,
    required this.contractNumber,
    required this.customerName,
    required this.duration,
    required this.employeeName,
    required this.serviceName,
    required this.shiftName,
    required this.mobile01Text,
    required this.mobile02Text,
    required this.mobile01,
    required this.mobile02,
    required this.workerImage,
    required this.statusCode,
    required this.statusCodeName,
    required this.statusColor,
    required this.buttonText,
    required this.lat,
    required this.long,
    required this.address,
    required this.mapUrl,
    required this.visitNumber,
    required this.contractNumber02,
    required this.workerId,
    required this.isLaborBlocked,
    required this.isLaborFavorite,
    required this.isAllowReschedule,
  });

  VisitModel.fromJson(Map<String, dynamic> json) {
    id = stringFromJson(json, 'Id');
    name = stringFromJson(json, 'Name');
    startTime = stringFromJson(json, 'StartTime');
    endTime = stringFromJson(json, 'EndTime');
    actualStartTime = stringFromJson(json, 'ActualStartTime');
    actualEndTime = stringFromJson(json, 'ActualEndTime');
    contractNumber = stringFromJson(json, 'ContractNumber');
    customerName = stringFromJson(json, 'CustomerName');
    duration = intFromJson(json, 'Duration');
    employeeName = stringFromJson(json, 'EmployeeName');
    serviceName = stringFromJson(json, 'ServiceName');
    shiftName = stringFromJson(json, 'ShiftName');
    mobile01Text = stringFromJson(json, 'Mobile01Text');
    mobile02Text = stringFromJson(json, 'Mobile02Text');
    mobile01 = stringFromJson(json, 'Mobile01');
    mobile02 = stringFromJson(json, 'Mobile02');
    workerImage = stringFromJson(json, 'WorkerImage');
    statusCode = intFromJson(json, 'StatusCode');
    statusCodeName = stringFromJson(json, 'StatusCodeName');
    statusColor = stringFromJson(json, 'StatusColor');
    buttonText = stringFromJson(json, 'ButtonText');
    lat = stringFromJson(json, 'Lat');
    long = stringFromJson(json, 'Long');
    address = stringFromJson(json, 'Address');
    mapUrl = stringFromJson(json, 'MapURL');
    visitNumber = stringFromJson(json, 'VisitNumber');
    workerId = stringFromJson(json, 'WorkerId');
    isLaborFavorite = boolFromJson(json, 'IsLaborFavorite');
    isLaborBlocked = boolFromJson(json, 'IsLaborBlocked');
    isAllowReschedule = boolFromJson(json, 'AllowReschedule');
    contractNumber02 = stringFromJson(json, 'ContractNumber02');
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "StartTime": startTime,
        "EndTime": endTime,
        "ActualStartTime": actualStartTime,
        "ActualEndTime": actualEndTime,
        "ContractNumber": contractNumber,
        "CustomerName": customerName,
        "Duration": duration,
        "EmployeeName": employeeName,
        "ServiceName": serviceName,
        "ShiftName": shiftName,
        "Mobile01Text": mobile01Text,
        "Mobile02Text": mobile02Text,
        "Mobile01": mobile01,
        "Mobile02": mobile02,
        "WorkerImage": workerImage,
        "StatusCode": statusCode,
        "StatusCodeName": statusCodeName,
        "StatusColor": statusColor,
        "ButtonText": buttonText,
        "Lat": lat,
        "Long": long,
        "Address": address,
        "MapURL": mapUrl,
      };
}
