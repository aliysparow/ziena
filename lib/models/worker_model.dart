import 'package:ziena/gen/assets.gen.dart';

import 'base.dart';

class WorkerModel extends Model {
  late final String name;
  late final String icon;
  late final int experienceYears;
  late final int age;
  late final String? skills;
  late final String nationalityStr;
  late final int serviceType;
  late final String entityImageExtension;

  WorkerModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    final name = stringFromJson(json, "Name");
    this.name = "${name.split(' ').first} ${name.split(' ').last}";
    icon = stringFromJson(json, "Icon", defaultValue: Assets.images.user);
    experienceYears = intFromJson(json, "ExperienceYears");
    age = intFromJson(json, "Age");
    skills = stringFromJson(json, "Skills", defaultValue: '-');
    nationalityStr = stringFromJson(json, "NationalityStr");
    serviceType = intFromJson(json, "ServiceType");
    entityImageExtension = stringFromJson(json, "EntityImageExtension");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Icon": icon,
        "ExperienceYears": experienceYears,
        "Age": age,
        "Skills": skills,
        "NationalityStr": nationalityStr,
        "ServiceType": serviceType,
        "EntityImageExtension": entityImageExtension,
      };
}
