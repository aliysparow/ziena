import 'base.dart';

class VisitsPerWeekMode extends Model {
  late final String name;
  late final int number;
  VisitsPerWeekMode.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    number = intFromJson(json, "Id");
    name = stringFromJson(json, "Name");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
