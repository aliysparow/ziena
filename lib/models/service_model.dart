import 'base.dart';

class ServiceModel extends Model {
  late final String name;
  late final String icon;
  late final String description;
  late final String entityImageExtension;
  late final int serviceType;
  ServiceModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
    icon = stringFromJson(json, "Icon").split('base64,').last;
    description = stringFromJson(json, "Description");
    entityImageExtension = stringFromJson(json, "EntityImageExtension");
    serviceType = intFromJson(json, "ServiceType");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Icon": icon,
        "Description": description,
        "ServiceType": serviceType,
        "EntityImageExtension": entityImageExtension,
      };
}
