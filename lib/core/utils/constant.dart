class AppConstants {
  static const String baseUrl = "http://93.112.2.209:8003/api/v3";
  static const String paymentUrl = "https://efadah.azurewebsites.net/Payment/Payment/";

  static const String imagesUrl = "$baseUrl/getImage/";

  static const String login = 'account/LogIn';
  static const String cities = 'Lookup/GetAllCities';
  static const String districts = 'Lookup/GetDistrictsByCityId';
  static const String profile = 'account/GetProfile';

  static const String sendOtp = "account/SendOtp";
  static const String verifyAccount = "account/VerifyOTPAndCreateUser";

  static const String checkPhone = "account/CheckNonExistingMobilAndSendOTP";
  static const String resetPassword = "account/ResetPassword";
  static const String verifyOtp = "account/VerifyOTP";

  static const String hourlyServices = 'Service/GetHourlyServiceList';
  static const String individualServices = 'Service/GetIndividualServiceList';
  static const String getOffers = 'Package/GetOffers';

  static const String hourlyPackages = 'Package/GetHourlyPackages';

  static const String createHourlyContract = 'Contract/CreateHourlyContract';

  static const String getAddresses = 'Address/GetAddressesByContactId';
  static const String createAddress = 'Address/CreateAddress';
  static const String deleteAddress = 'Address/DeleteAddress';

  static const String upcomingHourlyContracts = 'Contract/GetUpcomingHourlyContractsByUser';
  static const String finishedHourlyContracts = 'Contract/GetFinishedHourlyContractsByUser';

  static const String getUpcomingVisits = 'HourlyVisit/GetUpcomingVisits';
  static const String getCompletedVisits = 'HourlyVisit/GetCompletedVisits';
  static const String reschduleVisit = 'HourlyVisit/ReschduleVisit';
  static const String rateVisit = 'HourlyVisit/RateVisit';
  static const String setFavoriteLabor = 'account/SetFavoriteLabor';
  static const String blockLabor = 'account/BlockLabor';
}
