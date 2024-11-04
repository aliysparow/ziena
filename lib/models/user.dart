import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ziena/core/services/local_notifications_service.dart';

import '../main.dart';
import 'base.dart';

class UserModel extends Model {
  UserModel._();
  static UserModel i = UserModel._();

  late String token;
  late String userName;
  // late dynamic idNumber;
  // late dynamic nationality;
  late String city;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  // late dynamic password;
  // late dynamic confirmPassword;
  late bool rememberMe;
  // late dynamic defaultLanguage;
  late String contactId;
  // late dynamic driverId;
  // late dynamic supervisorId;
  // late dynamic msgMobileExist;
  late DateTime tokenExpiry;
  late int userType;
  // late dynamic source;
  // late dynamic userImage;
  late bool emailConfirmed;
  late String identity;

  bool get isAuth => token.isNotEmpty;

  fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "UserId");
    userName = stringFromJson(json, "UserName");
    token = stringFromJson(json, "Token");
    city = stringFromJson(json, "City");
    phone = stringFromJson(json, "phone");
    firstName = stringFromJson(json, "FirstName");
    lastName = stringFromJson(json, "LastName");
    email = stringFromJson(json, "Email");
    contactId = stringFromJson(json, "ContactId");
    tokenExpiry = dateFromJson(json, "TokenExpiry", parseingFormat: 'dd/MM/yyyy HH:mm:ss');
    userType = intFromJson(json, "UserType");
    emailConfirmed = boolFromJson(json, "EmailConfirmed");
    identity = stringFromJson(json, "Identity");
  }

  save() {
    Prefs.setString('user', jsonEncode(toJson()));
  }

  clear() {
    GlobalNotification.clearDeviceToken();
    Prefs.remove('user');
    fromJson();
  }

  get() {
    String user = Prefs.getString('user') ?? '{}';
    fromJson(jsonDecode(user));
  }

  @override
  Map<String, dynamic> toJson() => {
        "UserId": id,
        "UserName": userName,
        "Token": token,
        "City": city,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "ContactId": contactId,
        "TokenExpiry": DateFormat('dd/MM/yyyy HH:mm:ss', 'en').format(tokenExpiry),
        "UserType": userType,
        "EmailConfirmed": emailConfirmed,
        "Identity": identity,
      };
}
