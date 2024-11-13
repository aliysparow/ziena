import 'base.dart';

class DistrictModel extends Model {
  late final String name;
  DistrictModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
