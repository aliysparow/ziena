import 'base.dart';

class ProfessionModel extends Model {
  late final String name;

  ProfessionModel({
    required this.name,
    required super.id,
  });

  ProfessionModel.fromJson([Map<String, dynamic>? json]) {
    name = stringFromJson(json, 'Name');
    id = stringFromJson(json, 'Id');
  }

  @override
  Map<String, dynamic> toJson() => {
        "Name": name,
        "Id": id,
      };
}
