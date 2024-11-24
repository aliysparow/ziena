import 'base.dart';

class ReasonModel extends Model {
  late final String name;
  late final bool requireNotes;
  ReasonModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "Id");
    name = stringFromJson(json, "Name");
    requireNotes = boolFromJson(json, "RequireNotes");
  }

  @override
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "RequireNotes": requireNotes,
      };
}
