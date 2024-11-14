import 'base.dart';
import 'nationality_model.dart';

class HourlyPackageModel extends Model {
  late final String title;
  late final String description;
  late final String durationStr;
  late final DateTime lastDate;
  late final String durationDetailsStr;
  late final String shiftDuratioLabel;
  late final NationalityModel nationality;
  late final dynamic endDate;
  late final dynamic startDate;
  late final int totalVisits;
  late final int visitNumberPerWeek;
  late final int weekNumber;
  late final int shiftHours;
  late final int totalHours;
  late final String shift;
  late final String shiftName;
  late final String pricing;
  late final String service;
  late final String offer;
  late final dynamic isPromoted;
  late final dynamic freeVisits;
  late final double hourPrice;
  late final double initialPrice;
  late final dynamic offerDiscountAmount;
  late final double discountPerc;
  late final double finalPrice;
  late final double packageDiscountAmount;
  late final double priceAfterDiscountWithoutVat;
  late final double vat;
  late final bool vatIncluded;
  late final int calendarDays;
  late final List<int> days;

  HourlyPackageModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'Id');
    title = stringFromJson(json, "Title");
    description = stringFromJson(json, "Description");

    durationStr = stringFromJson(json, "DurationStr");
    durationDetailsStr = stringFromJson(json, "DurationDetailsStr");
    shiftDuratioLabel = stringFromJson(json, "ShiftDuratioLabel");
    nationality = NationalityModel.fromJson(json?["Nationality"]);
    endDate = json?['EndDate'];
    startDate = json?['StartDate'];
    totalVisits = intFromJson(json, "TotalVisits");
    visitNumberPerWeek = intFromJson(json, "VisitNumberPerWeek");
    weekNumber = intFromJson(json, "WeekNumber");
    shiftHours = intFromJson(json, "ShiftHours");
    totalHours = intFromJson(json, "TotalHours");
    shift = stringFromJson(json, "Shift");
    shiftName = stringFromJson(json, "ShiftName");
    pricing = stringFromJson(json, "Pricing");
    service = stringFromJson(json, "Service");
    offer = stringFromJson(json, "Offer");
    isPromoted = json?['IsPromoted'];
    freeVisits = json?['FreeVisits'];
    hourPrice = doubleFromJson(json, "HourPrice");
    initialPrice = doubleFromJson(json, "InitialPrice");
    offerDiscountAmount = json?['OfferDiscountAmount'];
    discountPerc = doubleFromJson(json, "DiscountPerc");
    finalPrice = doubleFromJson(json, "FinalPrice");
    packageDiscountAmount = doubleFromJson(json, "PackageDiscountAmount");
    priceAfterDiscountWithoutVat = doubleFromJson(json, "PriceAfterDiscountWithoutVAT");
    vat = doubleFromJson(json, "Vat");
    vatIncluded = boolFromJson(json, "VatIncluded");
    calendarDays = intFromJson(json, "CalendarDays");
    lastDate = dateFromJson(json, "lastDate")..copyWith(hour: 23, minute: 59, second: 59);
    days = List<int>.from((json?["days"] ?? []).map((x) => x));
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
        "DurationStr": durationStr,
        "DurationDetailsStr": durationDetailsStr,
        "ShiftDuratioLabel": shiftDuratioLabel,
        "Nationality": nationality,
        "EndDate": endDate,
        "StartDate": startDate,
        "TotalVisits": totalVisits,
        "VisitNumberPerWeek": visitNumberPerWeek,
        "WeekNumber": weekNumber,
        "ShiftHours": shiftHours,
        "TotalHours": totalHours,
        "Shift": shift,
        "ShiftName": shiftName,
        "Pricing": pricing,
        "Service": service,
        "Offer": offer,
        "IsPromoted": isPromoted,
        "FreeVisits": freeVisits,
        "HourPrice": hourPrice,
        "InitialPrice": initialPrice,
        "OfferDiscountAmount": offerDiscountAmount,
        "DiscountPerc": discountPerc,
        "FinalPrice": finalPrice,
        "PackageDiscountAmount": packageDiscountAmount,
        "PriceAfterDiscountWithoutVAT": priceAfterDiscountWithoutVat,
        "Vat": vat,
        "VatIncluded": vatIncluded,
        "CalendarDays": calendarDays,
        "LastDate": lastDate.toString(),
      };
}
