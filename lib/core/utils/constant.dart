class AppConstants {
  static const String baseUrl = "http://93.112.2.209:8003/api/v3";
  static const String imagesUrl = "$baseUrl/getImage/";

  static const String login = 'account/LogIn';
  static const String cities = 'Lookup/GetAllCities';
  static const String profile = 'account/GetProfile';

  static const String sendOtp = "account/SendOtp";
  static const String verifyAccount = "account/VerifyOTPAndCreateUser";

  static const String checkPhone = "account/CheckNonExistingMobilAndSendOTP";
  static const String resetPassword = "account/ResetPassword";
  static const String verifyOtp = "account/VerifyOTP";

  static const String hourlyServices = 'Service/GetHourlyServiceList';
  static const String individualServices = 'Service/GetIndividualServiceList';

  static const String hourlyPackages = 'Package/GetHourlyPackages';

  static const String getAddresses = 'Address/GetAddressesByContactId';
}
