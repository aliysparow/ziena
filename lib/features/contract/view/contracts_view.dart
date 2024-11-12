import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/gen/assets.gen.dart';
import 'package:ziena/gen/locale_keys.g.dart';

class ContractsView extends StatefulWidget {
  const ContractsView({super.key});

  @override
  State<ContractsView> createState() => _ContractsViewState();
}

class _ContractsViewState extends State<ContractsView> {
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
          SizedBox(
            height: 185.h,
            width: context.w,
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (value) {
                selectedBanner = value;
                setState(() {});
              },
              itemBuilder: (context, index) => CustomImage(
                () {
                  switch (index) {
                    case 0:
                      return Assets.images.banner.path;
                    case 1:
                      return Assets.images.monthService;
                    case 2:
                      return Assets.images.bussniessService;
                    default:
                      return '';
                  }
                }(),
                height: 185.h,
                width: context.w - 40.w,
                fit: BoxFit.fill,
                backgroundColor: '#D9D9D9'.color,
                borderRadius: BorderRadius.circular(20.r),
              ).withPadding(horizontal: 20.w),
            ),
          ).withPadding(vertical: 12.h),
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
                Container(
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
                Container(
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
                Container(
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
                Container(
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
          Text(
            LocaleKeys.latest_offers.tr(),
            style: context.semiboldText.copyWith(fontSize: 18),
          ).withPadding(top: 12.h, horizontal: 20.w),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 18.w,
              children: List.generate(3, (i) {
                return SizedBox(
                  width: 192.w,
                  child: Column(
                    children: [
                      CustomImage(
                        'https://media.cdnandroid.com/item_images/490771/imagen-offerup-buy-sell-offer-up-0ori.jpg',
                        base46: true,
                        height: 187.h,
                        width: 192.w,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      SizedBox(height: 14.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'خصم 20%',
                              style: context.semiboldText.copyWith(fontSize: 14, color: context.primaryColor),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: 'على العقود الشهرية لنظافة المنزل',
                              style: context.semiboldText.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
