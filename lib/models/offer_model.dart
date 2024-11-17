import 'package:ziena/models/base.dart';

class OfferModel extends Model {
  late final String title;
  late final String icon;
  late final String packageId;

  OfferModel({
    required this.title,
    required this.icon,
    required this.packageId,
  });

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = stringFromJson(json, 'Id');
    title = stringFromJson(json, 'Title');
    icon = stringFromJson(json, 'Icon').replaceAll('data:image/png;base64,', '');
    packageId = stringFromJson(json, 'PackageId');
  }

  @override
  Map<String, dynamic> toJson() => {
        "Title": title,
        "Icon": icon,
        "PackageId": packageId,
        "Id": id,
      };
}
