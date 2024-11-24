import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/widgets/base_shimmer.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/core/widgets/error_widget.dart';
import 'package:ziena/features/driver_home/widgets/shifts_widget.dart';
import 'package:ziena/gen/assets.gen.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../cubit/driver_home_cubit.dart';
import '../cubit/driver_home_state.dart';
import '../widgets/driver_order_item.dart';

class DriverHomeView extends StatefulWidget {
  const DriverHomeView({super.key});

  @override
  State<DriverHomeView> createState() => _DriverHomeViewState();
}

class _DriverHomeViewState extends State<DriverHomeView> {
  final cubit = sl<DriverHomeCubit>()..getTodayShifts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        titleSpacing: 20.w,
        title: Text(
          LocaleKeys.welcome_in_zina_for_drivers.tr(),
          style: context.semiboldText.copyWith(fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () => push(NamedRoutes.account),
            icon: CustomImage(
              Assets.icons.drawer,
              height: 32.h,
              width: 32.h,
            ),
          ).withPadding(horizontal: 12.w)
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              LocaleKeys.my_orders.tr(),
              style: context.mediumText.copyWith(fontSize: 18),
            ).withPadding(horizontal: 20.w, top: 20.h),
          ),
          const ShiftsWidget(),
          SliverToBoxAdapter(
            child: Text(
              LocaleKeys.current_orders.tr(),
              style: context.mediumText.copyWith(fontSize: 18),
            ).withPadding(horizontal: 20.w, top: 20.h),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12.w,
                children: List.generate(
                  AppConstants.deliverType.length,
                  (i) {
                    return GestureDetector(
                      onTap: () {
                        cubit.selectedDriverType = AppConstants.deliverType[i];
                        setState(() {});
                        cubit.getOrders(cubit.selectedShift!, cubit.selectedDriverType);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppConstants.deliverType[i] == cubit.selectedDriverType ? context.primaryColor : context.primaryColorLight,
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Text(
                          AppConstants.deliverType[i].name.tr(),
                          style: AppConstants.deliverType[i] == cubit.selectedDriverType
                              ? context.semiboldText.copyWith(fontSize: 16, color: context.primaryColorLight)
                              : context.regularText.copyWith(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<DriverHomeCubit, DriverHomeState>(
            bloc: cubit,
            buildWhen: (previous, current) => previous.getOrderState != current.getOrderState,
            builder: (context, state) {
              if (state.getOrderState.isDone && cubit.orders.isNotEmpty) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  sliver: SliverList.separated(
                    itemCount: cubit.orders.length,
                    separatorBuilder: (context, index) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) => DriverOrderItem(item: cubit.orders[index]),
                  ),
                );
              } else if (state.getOrderState.isLoading) {
                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  sliver: SliverList.separated(
                    itemCount: cubit.orders.length,
                    separatorBuilder: (context, index) => SizedBox(height: 14.h),
                    itemBuilder: (context, index) => BaseShimmer(
                      child: Container(
                        height: 320.h,
                        width: context.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: context.primaryColorLight,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state.getOrderState.isError) {
                return SliverToBoxAdapter(
                  child: CustomErrorWidget(
                    height: 360.h,
                    title: LocaleKeys.current_orders.tr(),
                    subtitle: state.msg,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: CustomErrorWidget(
                    height: 400.h,
                    title: LocaleKeys.current_orders.tr(),
                    subtitle: LocaleKeys.there_are_no_orders.tr(),
                  ),
                );
              }
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }
}
