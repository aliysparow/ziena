import 'package:easy_localization/easy_localization.dart';

import '../gen/locale_keys.g.dart';
import 'base.dart';

class AddressModel extends Model {
  late final String name;
  late final String districtName;
  late final String fullAddress;
  late final int apartmentType;
  late final String apartmentTypeName;
  late final String apartmentNumber;
  late final int floorNumber;

  AddressModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, 'Name');
    districtName = stringFromJson(json, 'DistrictName');
    fullAddress = stringFromJson(json, 'FullAddress');
    apartmentType = intFromJson(json, 'ApartmentType');
    apartmentTypeName = apartmentType == 1 ? LocaleKeys.apartment.tr() : LocaleKeys.villa.tr();
    apartmentNumber = stringFromJson(json, 'ApartmentNumber');
    floorNumber = intFromJson(json, 'FloorNumber');
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "DistrictName": districtName,
        "ApartmentType": apartmentType,
      };
}
