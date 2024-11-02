import 'base.dart';

class NationalityModel extends Model {
  late final String name;

  NationalityModel({
    required this.name,
    required super.id,
  });

  NationalityModel.fromJson(Map<String, dynamic> json) {
    name = stringFromJson(json, 'Name');
    id = json["Id"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "Name": name,
        "Id": id,
      };
}
