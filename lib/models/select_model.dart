import 'base.dart';

class SelectModel extends Model {
  late String name;
  SelectModel({
    required this.name,
    required super.id,
  });
  SelectModel.fromJson(Map<String, dynamic> json) {
    name = stringFromJson(json, 'name');
    id = stringFromJson(json, 'id');
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
