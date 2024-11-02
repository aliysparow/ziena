import 'base.dart';

class CityModel extends Model {
  late final String name;
  CityModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
