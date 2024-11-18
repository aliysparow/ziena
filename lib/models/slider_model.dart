import 'package:ziena/models/base.dart';

class SliderModel extends Model {
  late final String title;
  late final String icon;
  late final String packageId;

  SliderModel({
    required this.title,
    required this.icon,
    required this.packageId,
  });

  SliderModel.fromJson(Map<String, dynamic> json) {
    title = stringFromJson(json, 'Title');
    icon = stringFromJson(json, 'Icon').split('base64,').last;
    packageId = stringFromJson(json, 'PackageId');
    id = stringFromJson(json, 'Id');
  }

  @override
  Map<String, dynamic> toJson() => {
        "Title": title,
        "Icon": icon,
        "PackageId": packageId,
        "Id": id,
      };
}
