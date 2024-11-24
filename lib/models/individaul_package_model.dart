import 'package:ziena/models/nationality_model.dart';

import 'base.dart';

class IndividaulPackageModel extends Model {
  late final int duration, monthlyFees, advancedAmount, paymentMethod;
  late final NationalityModel nationality;
  late final double insuranceAmount, finalPrice, initialPrice;
  late final String title;
  late final bool hasInsurance;
  IndividaulPackageModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    paymentMethod = intFromJson(json, "PaymentMethod");
    nationality = NationalityModel.fromJson(json?['Nationality']);
    duration = intFromJson(json, 'Duration');
    monthlyFees = intFromJson(json, 'MonthlyFees');
    advancedAmount = intFromJson(json, 'AdvancedAmount');
    insuranceAmount = doubleFromJson(json, 'InsuranceAmount');
    finalPrice = doubleFromJson(json, 'FinalPrice');
    initialPrice = doubleFromJson(json, 'InitialPrice');
    title = stringFromJson(json, 'Title');
    hasInsurance = boolFromJson(json, 'HasInsurance');
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "PaymentMethod": paymentMethod,
        "Nationality": nationality,
        // "Profession": {"$id": "4", "Name": "سائق خاص", "Id": "f560b8d2-47ed-e911-8b82-20040ff72aa5"},
        "Duration": duration,
        "MonthlyFees": monthlyFees,
        "AdvancedAmount": advancedAmount,
        "HasInsurance": hasInsurance,
        "InsuranceAmount": insuranceAmount,
        "FinalPrice": finalPrice,
        "InitialPrice": initialPrice,
        "Title": title,
      };
}
