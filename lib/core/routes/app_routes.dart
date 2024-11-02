import 'package:flutter/material.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/features/auth/forget_password/view/forget_password_view.dart';
import 'package:ziena/features/auth/verify_phone/view/verify_phone_view.dart';
import 'package:ziena/features/hourly_service/view/select_dates_view.dart';
import 'package:ziena/features/intro/onboarding_view.dart';

import '../../features/auth/login/view/login_view.dart';
import '../../features/auth/register/view/register_view.dart';
import '../../features/auth/reset_password/view/reset_password_view.dart';
import '../../features/hourly_service/view/hourly_service_view.dart';
import '../../features/hourly_service/view/select_address_view.dart';
import '../../features/hourly_service/view/summary_hourly_service_view.dart';
import '../../features/intro/splash_view.dart';
import '../../features/layout/view/layout_view.dart';
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
    NamedRoutes.successfullyPage: (c) => SuccessfullyPage(image: c.arg['image'], title: c.arg['title'], subtitle: c.arg['subtitle']),
    NamedRoutes.onboarding: (c) => const OnboardingView(),
    // NamedRoutes.complaints: (c) => ComplaintsScreen(type: c.arg['type']),
    // NamedRoutes.settings: (c) => const SettingsScreen(),
    // NamedRoutes.staticPages: (c) => StaticPagesScreen(title: c.arg["title"], url: c.arg['url']),
    // NamedRoutes.myOrders: (c) => const OrdersScreen(),
    // NamedRoutes.offers: (c) => const OffersScreen(),
    // NamedRoutes.orderDetails: (c) => OrderDetailsView(id: c.arg["id"]),
    // NamedRoutes.productDetails: (c) => ProductDetailsView(id: c.arg['id']),
    // NamedRoutes.formProduct: (c) => FormProductView(id: c.arg['id']),
    // // NamedRoutes.searchResultsScreen: (c) => const SearchResultsView(),
    // // NamedRoutes.providerDetailsScreen: (c) => ProviderDetailsScreen(title: c.arg["title"], id: c.arg["id"]),
    // // NamedRoutes.completePayment: (c) => CompletePaymentScreen(model: c.arg["model"]),
    // // NamedRoutes.trackOrder: (c) => TrackOrder(shippingType: c.arg["shippingType"], status: c.arg["status"]),
    // // NamedRoutes.rateProduct: (c) => RateProductScreen(product: c.arg["product"], orderId: c.arg["orderId"]),
    // // NamedRoutes.cancelOrder: (c) => CancelOrderScreen(orderId: c.arg["orderId"]),
    // NamedRoutes.story: (c) => StoryView(storyModel: c.arg["storyModel"]),
    // NamedRoutes.reports: (c) => const ReportsView(),
    // NamedRoutes.addOffer: (c) => const AddOfferView(),
    // NamedRoutes.coupons: (c) => const CouponsView(),
    // NamedRoutes.couponForm: (c) => CouponFormView(id: c.arg['id'], model: c.arg['model']),
  };
}
