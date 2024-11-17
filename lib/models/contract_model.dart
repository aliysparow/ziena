import 'base.dart';

class ContractModel extends Model {
  late final String contractNumber;
  late final String serviceName;
  late final dynamic packageName;
  late final String statusName;
  late final String statusColor;
  late final String daysPerWeek;
  late final String latitude;
  late final String longitude;
  late final int statusCode;
  late final DateTime contractDate;
  late final DateTime startDate;
  late final bool fixedWorker;
  late final bool vatIncluded;
  late final int freeVisits;
  late final int totalHours;
  late final int numberOfWeeks;
  late final int visitsPerWeek;
  late final String weeksWithVisitsStr;
  late final int totalVisits;
  late final String serviceId;
  late final String nationality;
  late final String packageId;
  late final dynamic customPackage;
  late final String contactId;
  late final String contactName;
  late final String addressId;
  late final String shiftId;
  late final String districtId;
  late final double pricePerHour;
  late final double initialPrice;
  late final dynamic discountAmount;
  late final int discountPerc;
  late final double priceAfterDiscountWithoutVat;
  late final double vat;
  late final String finalPrice;
  late final double paidAmount;
  late final bool allowPay;

  ContractModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    contractNumber = stringFromJson(json, "ContractNumber");
    serviceName = stringFromJson(json, "ServiceName");
    packageName = stringFromJson(json, "PackageName");
    statusName = stringFromJson(json, "StatusName");
    statusColor = stringFromJson(json, "StatusColor");
    daysPerWeek = stringFromJson(json, "DaysPerWeek");
    latitude = stringFromJson(json, "Latitude");
    longitude = stringFromJson(json, "Longitude");
    statusCode = intFromJson(json, "StatusCode");
    contractDate = dateFromJson(json, "ContractDate");
    startDate = dateFromJson(json, "StartDate");
    fixedWorker = boolFromJson(json, "FixedWorker");
    vatIncluded = boolFromJson(json, "VatIncluded");
    freeVisits = intFromJson(json, "FreeVisits");
    totalHours = intFromJson(json, "TotalHours");
    numberOfWeeks = intFromJson(json, "NumberOfWeeks");
    visitsPerWeek = intFromJson(json, "VisitsPerWeek");
    weeksWithVisitsStr = stringFromJson(json, "WeeksWithVisitsStr");
    totalVisits = intFromJson(json, "TotalVisits");
    serviceId = stringFromJson(json, "ServiceID");
    nationality = stringFromJson(json, "Nationality");
    packageId = stringFromJson(json, "PackageId");
    customPackage = stringFromJson(json, "CustomPackage");
    contactId = stringFromJson(json, "ContactId");
    contactName = stringFromJson(json, "ContactName");
    addressId = stringFromJson(json, "AddressId");
    shiftId = stringFromJson(json, "ShiftId");
    districtId = stringFromJson(json, "DistrictId");
    pricePerHour = doubleFromJson(json, "PricePerHour");
    initialPrice = doubleFromJson(json, "InitialPrice");
    discountAmount = stringFromJson(json, "DiscountAmount");
    discountPerc = intFromJson(json, "DiscountPerc");
    priceAfterDiscountWithoutVat = doubleFromJson(json, "PriceAfterDiscountWithoutVAT");
    vat = doubleFromJson(json, "Vat");
    finalPrice = stringFromJson(json, "FinalPrice");
    paidAmount = doubleFromJson(json, "PaidAmount");
    allowPay = boolFromJson(json, "AllowPay");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "ContractNumber": contractNumber,
        "ServiceName": serviceName,
        "PackageName": packageName,
        "StatusName": statusName,
        "StatusColor": statusColor,
        "DaysPerWeek": daysPerWeek,
        "Latitude": latitude,
        "Longitude": longitude,
        "StatusCode": statusCode,
        "ContractDate": contractDate.toIso8601String(),
        "StartDate": startDate.toIso8601String(),
        "FixedWorker": fixedWorker,
        "VatIncluded": vatIncluded,
        "FreeVisits": freeVisits,
        "TotalHours": totalHours,
        "NumberOfWeeks": numberOfWeeks,
        "VisitsPerWeek": visitsPerWeek,
        "WeeksWithVisitsStr": weeksWithVisitsStr,
        "TotalVisits": totalVisits,
        "ServiceID": serviceId,
        "Nationality": nationality,
        "PackageId": packageId,
        "CustomPackage": customPackage,
        "ContactId": contactId,
        "ContactName": contactName,
        "AddressId": addressId,
        "ShiftId": shiftId,
        "DistrictId": districtId,
        "PricePerHour": pricePerHour,
        "InitialPrice": initialPrice,
        "DiscountAmount": discountAmount,
        "DiscountPerc": discountPerc,
        "PriceAfterDiscountWithoutVAT": priceAfterDiscountWithoutVat,
        "Vat": vat,
        "FinalPrice": finalPrice,
        "PaidAmount": paidAmount,
        "AllowPay": allowPay,
      };
}
