import 'base.dart';

class WeekNumberModel extends Model {
  late final String name;
  WeekNumberModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
