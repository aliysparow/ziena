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
  late String nationality;
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
  late String driverId;
  // late dynamic supervisorId;
  // late dynamic msgMobileExist;
  late DateTime tokenExpiry;
  late UserType userType;
  // late dynamic source;
  // late dynamic userImage;
  late bool emailConfirmed;
  late String identity;

  bool get isAuth => token.isNotEmpty;
  String get fulName => "$firstName $lastName";

  fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "UserId");
    userName = stringFromJson(json, "UserName");
    token = stringFromJson(json, "Token");
    city = stringFromJson(json, "City");
    nationality = stringFromJson(json, "Nationality");
    phone = stringFromJson(json, "phone");
    firstName = stringFromJson(json, "FirstName");
    lastName = stringFromJson(json, "LastName");
    email = stringFromJson(json, "Email");
    contactId = stringFromJson(json, "ContactId");
    tokenExpiry = dateFromJson(json, "TokenExpiry", parseingFormat: 'dd/MM/yyyy HH:mm:ss');
    driverId = stringFromJson(json, 'DriverId');
    emailConfirmed = boolFromJson(json, "EmailConfirmed");
    identity = stringFromJson(json, "Identity");
    final userType = intFromJson(json, "UserType");
    if (userType == 1) {
      this.userType = UserType.driver;
    } else {
      this.userType = UserType.client;
    }
  }

  fromEditProfile([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "UserId");
    firstName = stringFromJson(json, "FirstName");
    lastName = stringFromJson(json, "LastName");
    email = stringFromJson(json, "Email");
    city = stringFromJson(json, "CityId");
    nationality = stringFromJson(json, "NationalId");
  }

  save() {
    prefs.setString('user', jsonEncode(toJson()));
  }

  clear() {
    GlobalNotification.clearDeviceToken();
    prefs.remove('user');
    fromJson();
  }

  get() {
    String user = prefs.getString('user') ?? '{}';
    fromJson(jsonDecode(user));
  }

  @override
  Map<String, dynamic> toJson() => {
        "UserId": id,
        "UserName": userName,
        "phone": phone,
        "Token": token,
        "City": city,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "ContactId": contactId,
        "TokenExpiry": DateFormat('dd/MM/yyyy HH:mm:ss', 'en').format(tokenExpiry),
        "UserType": userType.toInt,
        "EmailConfirmed": emailConfirmed,
        "Identity": identity,
        "DriverId": driverId,
        "Nationality": nationality,
      };
}

enum UserType {
  client,
  driver;

  bool get isClient => this == UserType.client;
  bool get isDriver => this == UserType.driver;
  int get toInt => this == UserType.driver ? 1 : 0;
}
