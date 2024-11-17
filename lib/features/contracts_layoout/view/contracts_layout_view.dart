import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/features/home/widgets/offers_widget.dart';
import 'package:ziena/features/home/widgets/sliders_widget.dart';
import 'package:ziena/features/my_contracts/bloc/contracts_cubit.dart';
import 'package:ziena/gen/assets.gen.dart';
import 'package:ziena/gen/locale_keys.g.dart';

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
            'عقودي',
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
                          'عقودي الفعالة',
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
                          'عقودي الفعالة',
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
            'زياراتي',
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
                      'الزيارات القادمة',
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
                      'الزيارات المكتملة',
                      style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'طلباتي',
            style: context.semiboldText.copyWith(fontSize: 18),
          ).withPadding(horizontal: 20.w, top: 4.h),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 18.w,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: context.primaryColorLight,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'طلباتي المكتملة',
                    style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: context.primaryColorLight,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'طلباتي الغير مكتملة',
                    style: context.regularText.copyWith(fontSize: 14, color: '#113342'.color),
                  ),
                ),
              ],
            ),
          ),
          const OffersWidget(),
        ],
      ),
    );
  }
}
