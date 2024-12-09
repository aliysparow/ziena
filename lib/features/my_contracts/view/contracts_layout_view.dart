import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../home/widgets/offers_widget.dart';
import '../../home/widgets/sliders_widget.dart';
import '../cubit/contracts_cubit.dart';

class ContractsLayoutView extends StatefulWidget {
  const ContractsLayoutView({super.key});

  @override
  State<ContractsLayoutView> createState() => _ContractsLayoutViewState();
}

class _ContractsLayoutViewState extends State<ContractsLayoutView> {
  int selectedBanner = 0;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leadingWidth: 80.w,
        title: Text(LocaleKeys.welcome_to_the_ziena.tr()),
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
      body: ListView(
        children: [
          const SlidersWidget(),
          Text(
            LocaleKeys.my_contracts.tr(),
            style: context.semiboldText.copyWith(fontSize: 18),
          ).withPadding(horizontal: 20.w),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 18.w,
              children: [
                GestureDetector(
                  onTap: () => push(NamedRoutes.contracts, arg: {'type': ContractType.upcoming}),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.primaryColorLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: context.primaryColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8.h,
                          color: context.primaryColor,
                        ).withPadding(end: 8.w),
                        Text(
                          LocaleKeys.my_active_contracts.tr(),
                          style: context.regularText.copyWith(fontSize: 14, color: context.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => push(NamedRoutes.contracts, arg: {'type': ContractType.finished}),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.primaryColorLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8.h,
                          color: '#11334280'.color.withOpacity(0.5),
                        ).withPadding(end: 8.w),
                        Text(
                          LocaleKeys.my_active_contracts.tr(),
                          style: context.regularText.copyWith(fontSize: 14, color: '#11334280'.color.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            LocaleKeys.my_visits.tr(),
            style: context.semiboldText.copyWith(fontSize: 18),
          ).withPadding(horizontal: 20.w, top: 4.h),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 18.w,
              children: [
                GestureDetector(
                  onTap: () => push(NamedRoutes.visits, arg: {'type': VisitsType.upcoming}),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.primaryColorLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      LocaleKeys.next_visits.tr(),
                      style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => push(NamedRoutes.visits, arg: {'type': VisitsType.finished}),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.primaryColorLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      LocaleKeys.complete_visits.tr(),
                      style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            LocaleKeys.my_orders.tr(),
            style: context.semiboldText.copyWith(fontSize: 18),
          ).withPadding(horizontal: 20.w, top: 4.h),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 18.w,
              children: [
                GestureDetector(
                  onTap: () => push(NamedRoutes.myOrders),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.primaryColorLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      LocaleKeys.all_orders.tr(),
                      style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () => push(NamedRoutes.myOrders, arg: {'type': OrdersType.incompleted}),
                //   child: Container(
                //     padding: EdgeInsets.all(16.w),
                //     decoration: BoxDecoration(
                //       color: context.primaryColorLight,
                //       borderRadius: BorderRadius.circular(12.r),
                //     ),
                //     child: Text(
                //       LocaleKeys.incomplete_orders.tr(),
                //       style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const OffersWidget(),
        ],
      ),
    );
  }
}
