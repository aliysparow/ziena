import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/base_shimmer.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/hourly_service_bloc.dart';
import '../bloc/hourly_service_state.dart';

class CustomPackageView extends StatefulWidget {
  const CustomPackageView({super.key});

  @override
  State<CustomPackageView> createState() => _CustomPackageViewState();
}

class _CustomPackageViewState extends State<CustomPackageView> {
  final cubit = sl<HourlyServiceBloc>()
    ..getWeeksNumber()
    ..getAllShiftsForPricing()
    ..getCountriesForHourlyPricing()
    ..getVisitsPerWeek();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.custom_package.tr()),
        backgroundColor: context.scaffoldBackgroundColor,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.required_nationality.tr(),
              style: context.semiboldText.copyWith(fontSize: 14),
            ).withPadding(horizontal: 20.w),
            SizedBox(height: 18.h),
            BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
              bloc: cubit,
              buildWhen: (previous, current) => previous.getCountriesForHourlyPricing != current.getCountriesForHourlyPricing,
              builder: (context, state) {
                if (state.getCountriesForHourlyPricing.isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: List.generate(
                        3,
                        (index) {
                          return BaseShimmer(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(end: 10),
                              height: 40.h,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12.w,
                    children: List.generate(
                      cubit.countriesForHourly.length,
                      (i) {
                        final item = cubit.countriesForHourly[i];
                        final selected = cubit.inputData.nationality == item;
                        return GestureDetector(
                          onTap: () {
                            cubit.inputData.nationality = item;
                            setState(() {});
                          },
                          child: Container(
                            height: 40.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: selected ? context.indicatorColor : context.primaryContainer,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              item.name,
                              style: context.mediumText.copyWith(
                                fontSize: 12,
                                color: selected ? context.primaryColorLight : context.primaryColorDark,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 18.h),
            Text(
              LocaleKeys.choose_the_contract_period.tr(),
              style: context.semiboldText.copyWith(
                fontSize: 14,
              ),
            ).withPadding(horizontal: 20.w),
            SizedBox(height: 18.h),
            BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
              bloc: cubit,
              buildWhen: (previous, current) => previous.getGetWeeksNumber != current.getGetWeeksNumber,
              builder: (context, state) {
                if (state.getGetWeeksNumber.isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: List.generate(
                        3,
                        (index) {
                          return BaseShimmer(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(end: 10),
                              height: 40.h,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12.w,
                    children: List.generate(
                      cubit.weeksNumber.length,
                      (i) {
                        final item = cubit.weeksNumber[i];
                        final selected = cubit.inputData.selectedWeek == item;
                        return GestureDetector(
                          onTap: () {
                            cubit.inputData.selectedWeek = item;
                            setState(() {});
                          },
                          child: Container(
                            height: 40.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: selected ? context.indicatorColor : context.primaryContainer,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              item.name,
                              style: context.mediumText.copyWith(
                                fontSize: 12,
                                color: selected ? context.primaryColorLight : context.primaryColorDark,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24.h),
            Text(
              LocaleKeys.number_of_weekly_visits.tr(),
              style: context.semiboldText.copyWith(
                fontSize: 14,
              ),
            ).withPadding(horizontal: 20.w),
            SizedBox(height: 18.h),
            BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
              bloc: cubit,
              buildWhen: (previous, current) => previous.getVisitsPerWeek != current.getVisitsPerWeek,
              builder: (context, state) {
                if (state.getVisitsPerWeek.isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: List.generate(
                        3,
                        (index) {
                          return BaseShimmer(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(end: 10),
                              height: 40.h,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12.w,
                    children: List.generate(
                      cubit.visitsPerWeek.length,
                      (i) {
                        final item = cubit.visitsPerWeek[i];
                        final selected = cubit.inputData.selectedVisitPerWeek == item;
                        return GestureDetector(
                          onTap: () {
                            cubit.inputData.selectedVisitPerWeek = item;
                            setState(() {});
                          },
                          child: Container(
                            height: 40.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: selected ? context.indicatorColor : context.primaryContainer,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              item.name,
                              style: context.mediumText.copyWith(
                                fontSize: 12,
                                color: selected ? context.primaryColorLight : context.primaryColorDark,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24.h),
            Text(
              LocaleKeys.choose_the_time_period_you_want_for_your_service.tr(),
              style: context.semiboldText.copyWith(
                fontSize: 14,
              ),
            ).withPadding(horizontal: 20.w),
            SizedBox(height: 18.h),
            BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
              bloc: cubit,
              builder: (context, state) {
                if (state.getAllShiftsForPricing.isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: List.generate(
                        3,
                        (index) {
                          return BaseShimmer(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(end: 10),
                              height: 40.h,
                              width: 100,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 12.w,
                    children: List.generate(
                      cubit.shiftsForPricing.length,
                      (i) {
                        final item = cubit.shiftsForPricing[i];
                        final selected = cubit.inputData.shift == item;
                        return GestureDetector(
                          onTap: () {
                            cubit.inputData.shift = item;
                            setState(() {});
                          },
                          child: Container(
                            height: 40.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            decoration: BoxDecoration(
                              color: selected ? context.indicatorColor : context.primaryContainer,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              item.name,
                              style: context.mediumText.copyWith(
                                fontSize: 12,
                                color: selected ? context.primaryColorLight : context.primaryColorDark,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<HourlyServiceBloc, HourlyServiceState>(
        bloc: cubit,
        listenWhen: (previous, current) => previous.getPricingDetails != current.getPricingDetails,
        buildWhen: (previous, current) => previous.getPricingDetails != current.getPricingDetails,
        listener: (context, state) {
          if (state.getPricingDetails.isDone) {
            push(NamedRoutes.selectAddress);
          }
        },
        builder: (context, state) {
          return AppBtn(
            loading: state.getPricingDetails.isLoading,
            onPressed: () {
              if (sl<HourlyServiceBloc>().inputData.validate(context)) {
                cubit.getPricingDetails();
              }
            },
            title: LocaleKeys.next.tr(),
            backgroundColor: context.indicatorColor,
          );
        },
      ).withPadding(horizontal: 20.w),
    );
  }
}
