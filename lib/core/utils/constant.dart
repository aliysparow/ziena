import '../../models/week_day_model.dart';
import '../widgets/select_item_sheet.dart';

class AppConstants {
  static List<WeekDayModel> weekDays = const [
    WeekDayModel(id: 6, name: "saturday"),
    WeekDayModel(id: 7, name: "sunday"),
    WeekDayModel(id: 1, name: "monday"),
    WeekDayModel(id: 2, name: "tuesday"),
    WeekDayModel(id: 3, name: "wednesday"),
    WeekDayModel(id: 4, name: "thursday"),
    WeekDayModel(id: 5, name: "friday"),
  ];
  static List<SelectModel> genders = const [
    SelectModel(id: 'male', name: 'male'),
    SelectModel(id: 'female', name: 'female'),
  ];
  static List<SelectModel> deliverType = const [
    SelectModel(id: 0, name: "delivery"),
    SelectModel(id: 1, name: "back"),
  ];

  static const String shareAppText = '''
🌟 حمّل تطبيق زينة الآن واستمتع بتجربة لا مثيل لها! 🌟

✨ اكتشف المزايا الرائعة وسهولة الاستخدام لتطبيق زينة!
📲 للأندرويد: $googlePlayLink
🍏 للآيفون: $appleStoreLink

شارك المتعة مع أصدقائك، وخليهم يجربوا اللي يناسبهم في أي وقت وأي مكان! ❤️
''';

  static const String googlePlayLink = 'https://play.google.com/store/apps/details?id=com.efada.zienaapp';
  static const String appleStoreLink = 'https://apps.apple.com/eg/app/ziena/id1601674625';
}

class ApiConstants {
  static const String baseUrl = "http://93.112.2.209:8003/api/v3";
  static const String paymentUrl = "https://efadah.azurewebsites.net/Payment/Payment/";

  static const String imagesUrl = "$baseUrl/getImage/";

  static const String cities = 'Lookup/GetAllCities';
  static const String districts = 'Lookup/GetDistrictsByCityId';
  static const String checkAppVersion = 'Lookup/IsLatestVersionpost';

  static const String login = 'account/LogIn';
  static const String profile = 'account/GetProfile';
  static const String deleteAccount = 'account/DeleteUser';
  static const String sendOtp = "account/SendOtp";
  static const String verifyAccount = "account/VerifyOTPAndCreateUser";
  static const String checkPhone = "account/CheckNonExistingMobilAndSendOTP";
  static const String resetPassword = "account/ResetPassword";
  static const String verifyOtp = "account/VerifyOTP";
  static const String setFavoriteLabor = 'account/SetFavoriteLabor';
  static const String blockLabor = 'account/BlockLabor';

  static const String hourlyServices = 'Service/GetHourlyServiceList';
  static const String individualServices = 'Service/GetIndividualServiceList';

  static const String getOffers = 'Package/GetOffers';
  static const String getOffersInBaner = 'Package/GetOffers_InBaner';
  static const String hourlyPackages = 'Package/GetHourlyPackages';

  static const String getAddresses = 'Address/GetAddressesByContactId';
  static const String createAddress = 'Address/CreateAddress';
  static const String deleteAddress = 'Address/DeleteAddress';

  static const String createHourlyContract = 'Contract/CreateHourlyContract';
  static const String upcomingHourlyContracts = 'Contract/GetUpcomingHourlyContractsByUser';
  static const String finishedHourlyContracts = 'Contract/GetFinishedHourlyContractsByUser';
  static const String getIndividualReqsByUserId = 'Request/GetIndividualReqsByUserId';

  static const String getUpcomingVisits = 'HourlyVisit/GetUpcomingVisits';
  static const String getCompletedVisits = 'HourlyVisit/GetCompletedVisits';
  static const String reschduleVisit = 'HourlyVisit/ReschduleVisit';
  static const String rateVisit = 'HourlyVisit/RateVisit';
  static const String todayDeliveringVisits = 'HourlyVisit/GetTodayDeliveringVisitsByShiftId';
  static const String getCancelReasons = 'HourlyVisit/GetVisitCancelReasons';
  static const String setVisitStatus = 'HourlyVisit/SetVisitStatus';
  static const String setVisitNextStatus = 'HourlyVisit/SetVisitNextStatus';
  static const String getVisitById = 'HourlyVisit/GetVisitByID';

  static const String getTodayShifts = 'Shift/GetTodayShifts';

  static const String getIndividualPackages = 'Package/GetIndividualPackages';
  static const String createIndvContract = 'Contract/CreateIndvContract';

  static const String getAllCountries = 'Lookup/GetAllCountries';
  static const String getAllProfessions = 'Lookup/GetAllProfessions';
  static const String createCorporateReq = 'Request/CreateCorporateReq';
  static const String getWorkers = 'Worker/GetIndvWorkerList';
  static const String termsAndConditionsHourly = 'Lookup/TermsAndConditionsHourly';
  static const String termsAndConditionsIndv = 'Lookup/TermsAndConditionsIndv';
  static const String editProfile = 'account/UpdateProfile';
  static const String editPassword = 'account/ChangePassword';
  static const String getContactUsPhone = 'Lookup/GetContactUsPhone';
}
