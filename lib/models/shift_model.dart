import 'base.dart';

class ShiftModel extends Model {
  late final String name, startTime;
  late final int duration, offsetHours;
  ShiftModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
    duration = intFromJson(json, "Duration");
    startTime = stringFromJson(json, "StartTime");
    offsetHours = intFromJson(json, "OffsetHours");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Duration": duration,
        "StartTime": startTime,
        "OffsetHours": offsetHours,
      };
}
