import 'package:flutter/material.dart';
import 'package:ziena/features/account/view/edit_password_view.dart';
import 'package:ziena/features/company_request/view/company_request_view.dart';
import 'package:ziena/features/driver_home/view/reject_order_view.dart';
import 'package:ziena/features/individual_packages/view/summary_booking_view.dart';
import 'package:ziena/features/my_contracts/view/my_orders_view.dart';
import 'package:ziena/features/settings/view/terms_conditions_view.dart';

import '../../features/account/view/account_view.dart';
import '../../features/account/view/edit_profile_view.dart';
import '../../features/addresses/view/add_address_view.dart';
import '../../features/addresses/view/addresses_view.dart';
import '../../features/addresses/view/pick_location_view.dart';
import '../../features/auth/forget_password/view/forget_password_view.dart';
import '../../features/auth/login/view/login_view.dart';
import '../../features/auth/register/view/register_view.dart';
import '../../features/auth/reset_password/view/reset_password_view.dart';
import '../../features/auth/verify_phone/view/verify_phone_view.dart';
import '../../features/driver_home/view/driver_home_view.dart';
import '../../features/hourly_service/view/hourly_service_view.dart';
import '../../features/hourly_service/view/select_address_view.dart';
import '../../features/hourly_service/view/select_dates_view.dart';
import '../../features/hourly_service/view/summary_hourly_service_view.dart';
import '../../features/individual_packages/view/individual_packages_view.dart';
import '../../features/individual_packages/view/individual_request_view.dart';
import '../../features/intro/view/onboarding_view.dart';
import '../../features/intro/view/splash_view.dart';
import '../../features/layout/view/layout_view.dart';
import '../../features/my_contracts/view/contracts_view.dart';
import '../../features/my_contracts/view/visits_view.dart';
import '../../features/payment_ifream/payment_ifream.dart';
import '../utils/extensions.dart';
import '../widgets/successfully_page.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.splash;

  AppRoutes._internal();

  Map<String, Widget Function(BuildContext)> appRoutes = {
    NamedRoutes.splash: (c) => const SplashView(),
    NamedRoutes.login: (c) => const LoginView(),
    NamedRoutes.forgetPassword: (c) => const ForgetPaswwordView(),
    NamedRoutes.resetPassword: (c) => ResetPasswordView(phone: c.arg['phone']),
    NamedRoutes.register: (c) => const RegisterView(),
    NamedRoutes.verifyPhone: (c) => VerifyPhoneView(type: c.arg['type'], data: c.arg['data']),
    NamedRoutes.layout: (c) => const LayoutView(),
    NamedRoutes.hourlyService: (c) => HourlyServiceView(id: c.arg['id'], title: c.arg['title']),
    NamedRoutes.selectAddress: (c) => const SelectAddressView(),
    NamedRoutes.selectDates: (c) => const SelectDatesView(),
    NamedRoutes.summaryHourlyService: (c) => const SummaryHourlyServiceView(),
    NamedRoutes.successfullyPage: (c) =>
        SuccessfullyPage(image: c.arg['image'], title: c.arg['title'], subtitle: c.arg['subtitle'], btnTitle: c.arg['btnTitle'], onTap: c.arg['onTap']),
    NamedRoutes.onboarding: (c) => const OnboardingView(),
    NamedRoutes.account: (c) => const AccountView(),
    NamedRoutes.paymentIfream: (c) => PaymentIfream(id: c.arg['id'], type: c.arg['type']?.toString()),
    NamedRoutes.addresses: (c) => const AddressesView(),
    NamedRoutes.addAddress: (c) => const AddAddressView(),
    NamedRoutes.pickLocation: (c) => PickLocationView(position: c.arg['position'], address: c.arg['address']),
    NamedRoutes.contracts: (c) => ContractsView(type: c.arg["type"]),
    NamedRoutes.visits: (c) => VisitsView(type: c.arg["type"]),
    NamedRoutes.driverHome: (c) => const DriverHomeView(),
    NamedRoutes.rejectOrder: (c) => RejectOrderView(item: c.arg['item']),
    NamedRoutes.individualPackages: (c) => IndividualPackagesView(id: c.arg["id"], name: c.arg["name"]),
    NamedRoutes.individualRequest: (c) => IndividualRequestView(title: c.arg['title'], serviceId: c.arg['serviceId']),
    NamedRoutes.myOrders: (c) => const MyOrdersView(),
    NamedRoutes.companyRequest: (c) => const CompanyRequestView(),
    NamedRoutes.termsConditions: (c) => TermsConditionsView(url: c.arg['url']),
    NamedRoutes.summaryIndivadualService: (c) => SummaryIndivadualServiceView(title: c.arg['title'], serviceId: c.arg['serviceId']),
    NamedRoutes.editProfile: (c) => const EditProfileView(),
    NamedRoutes.editPassword: (c) => const EditPasswordView(),
    // NamedRoutes.coupons: (c) => const CouponsView(),
    // NamedRoutes.couponForm: (c) => CouponFormView(id: c.arg['id'], model: c.arg['model']),
  };
}
