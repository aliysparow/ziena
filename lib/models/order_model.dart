import 'base.dart';

class OrderModel extends Model {
  late final String contact;
  late final String serviceName;
  late final String reqSource;
  late final String statusCode;
  late final String statusCodeName;
  late final String statusColor;
  late final String fullName;
  late final String mobile;
  late final String notes;
  late final String requestNumber;
  late final String requestDate;
  OrderModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    contact = stringFromJson(json, 'Contact');
    serviceName = stringFromJson(json, 'ServiceName');
    reqSource = stringFromJson(json, 'ReqSource');
    statusCode = stringFromJson(json, 'StatusCode');
    statusCodeName = stringFromJson(json, 'StatusCodeName');
    statusColor = stringFromJson(json, 'StatusColor');
    fullName = stringFromJson(json, 'FullName');
    mobile = stringFromJson(json, 'Mobile');
    notes = stringFromJson(json, 'Notes');
    requestNumber = stringFromJson(json, 'RequestNumber');
    requestDate = stringFromJson(json, 'RequestDate');
  }

  @override
  Map<String, dynamic> toJson() => {
        "Contact": "25eb49b0-7370-ec11-8ba4-20040ff72aa5",
        "ServiceName": "سائق خاص",
        "Id": "cf88955a-f672-ec11-8ba4-20040ff72aa5",
        "ReqSource": 0,
        "StatusCode": 1,
        "StatusCodeName": "نشط",
        "StatusColor": "#008000",
        "FullName": "tamer elsayad",
        "Mobile": "0542318760",
        "Notes": "fgeyeuev",
        "RequestNumber": "IReq00034",
        "RequestDate": "08/06/1443"
      };
}
