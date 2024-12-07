import 'package:get_it/get_it.dart';

import '../../blocs/cities/cities_bloc.dart';
import '../../features/account/cubit/account_cubit.dart';
import '../../features/addresses/bloc/addresses_bloc.dart';
import '../../features/auth/forget_password/bloc/forget_password_bloc.dart';
import '../../features/auth/login/bloc/login_bloc.dart';
import '../../features/auth/register/bloc/register_bloc.dart';
import '../../features/auth/reset_password/bloc/reset_password_bloc.dart';
import '../../features/auth/verify_phone/bloc/verify_phone_bloc.dart';
import '../../features/company_request/cubit/company_request_cubit.dart';
import '../../features/driver_home/cubit/driver_home_cubit.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/hourly_service/bloc/hourly_service_bloc.dart';
import '../../features/individual_packages/cubit/individual_packages_cubit.dart';
import '../../features/intro/cubit/intro_cubit.dart';
import '../../features/layout/bloc/layout_bloc.dart';
import '../../features/my_contracts/cubit/contracts_cubit.dart';
import 'location_service.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ////// Bloc
    sl.registerLazySingleton(() => LocationService());
    sl.registerFactory(() => LoginBloc());
    sl.registerFactory(() => RegisterBloc());
    sl.registerLazySingleton(() => CitiesBloc());
    sl.registerFactory(() => ForgetPasswordBloc());
    sl.registerFactory(() => VerifyPhoneBloc());
    sl.registerFactory(() => ResetPasswordBloc());
    sl.registerLazySingleton(() => LayoutBloc());
    sl.registerLazySingleton(() => HomeBloc());
    sl.registerLazySingleton(() => HourlyServiceBloc());
    sl.registerFactory(() => AddressesBloc());
    sl.registerFactory(() => ContractsCubit());
    sl.registerLazySingleton(() => DriverHomeCubit());
    sl.registerLazySingleton(() => IndividualPackagesCubit());
    sl.registerFactory(() => AccountCubit());
    sl.registerFactory(() => IntroCubit());
    sl.registerFactory(() => CompanyRequestCubit());
    // sl.registerFactory(() => AddStoryBloc());
    // sl.registerFactory(() => OffersBloc());
    // sl.registerFactory(() => NotificationsBloc());
    // sl.registerLazySingleton(() => CouponsBloc());
    // sl.registerFactory(() => OrdersBloc());
    // sl.registerFactory(() => ReportsBloc());
  }
}
