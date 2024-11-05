import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/custom_circle_icon.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/hourly_service_bloc.dart';
import '../bloc/hourly_service_state.dart';

class SelectAddressView extends StatefulWidget {
  const SelectAddressView({super.key});

  @override
  State<SelectAddressView> createState() => _SelectAddressViewState();
}

class _SelectAddressViewState extends State<SelectAddressView> {
  final bloc = sl<HourlyServiceBloc>()..getAddresses();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        titleSpacing: 20.w,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30.h,
              child: Column(
                children: [
                  CustomImage(
                    Assets.images.hourService,
                    height: 24.h,
                    width: 24.h,
                  ),
                  Text(
                    LocaleKeys.hourly_service.tr(),
                    style: context.boldText.copyWith(fontSize: 8),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              bloc.inputData.package?.title ?? '',
              style: context.semiboldText.copyWith(fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, size: 28.h),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: context.primaryColorLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.package_details.tr(),
                    style: context.boldText.copyWith(fontSize: 16),
                  ).withPadding(bottom: 10.h),
                  ...List.generate(
                    7,
                    (i) {
                      final item = bloc.inputData.package!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            [
                              'عدد الزيارات',
                              "عدد الأيام",
                              "عدد ساعات العمل",
                              "الفترة الزمنية",
                              "السعر قبل الخصم",
                              "السعر بعد الخصم",
                              "ضريبة القيمة المصافة",
                            ][i],
                            style: context.boldText
                                .copyWith(fontSize: 15, color: '#8E8E8E'.color),
                          ),
                          Text(
                            [
                              '${item.totalVisits} زيارات',
                              "${item.visitNumberPerWeek} اسبوع",
                              "${item.totalHours} ساعات",
                              item.shiftName,
                              "${item.initialPrice} ${LocaleKeys.sar.tr()}",
                              "${item.priceAfterDiscountWithoutVat} ${LocaleKeys.sar.tr()}",
                              "${item.vat} ${LocaleKeys.sar.tr()}",
                            ][i],
                            style: context.boldText
                                .copyWith(fontSize: 15, color: '#8E8E8E'.color),
                          ),
                        ],
                      ).withPadding(vertical: 10.h);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.choose_your_address.tr(),
                  style: context.mediumText.copyWith(fontSize: 16),
                ),
                if (bloc.inputData.address == null)
                  GestureDetector(
                    onTap: () {
                      // push(NamedRoutes.addAddress);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: context.primaryColorDark),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 14.sp,
                          ).withPadding(end: 4.w),
                          Text(
                            LocaleKeys.add_address.tr(),
                            style: context.regularText.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(height: 14.h),
            BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
              bloc: bloc,
              builder: (context, state) {
                if (bloc.inputData.address != null) {
                  final item = bloc.inputData.address!;
                  return Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: context.primaryColorLight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomImage(
                              Assets.icons.home,
                              color: context.primaryColorDark,
                            ).withPadding(end: 4.w),
                            Expanded(
                              child: Text(
                                item.districtName,
                                style:
                                    context.mediumText.copyWith(fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.inputData.address = null;
                                setState(() {});
                              },
                              child: CustomImage(
                                Assets.icons.delete,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          item.name,
                          style: context.regularText
                              .copyWith(fontSize: 14, color: '#A4A4A4'.color),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${LocaleKeys.the_type_of_place.tr()} : ${item.apartmentTypeName}",
                          style: context.regularText
                              .copyWith(fontSize: 14, color: '#A4A4A4'.color),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${LocaleKeys.apartment_number.tr()} : ${item.apartmentNumber}",
                          style: context.regularText
                              .copyWith(fontSize: 14, color: '#A4A4A4'.color),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${LocaleKeys.floor_number.tr()} : ${item.floorNumber}",
                          style: context.regularText
                              .copyWith(fontSize: 14, color: '#A4A4A4'.color),
                        ),
                      ],
                    ),
                  );
                }
                return ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
                  childrenPadding: EdgeInsets.zero,
                  backgroundColor: context.primaryColorLight,
                  collapsedBackgroundColor: context.primaryColorLight,
                  shape: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(14.r)),
                    borderSide: BorderSide.none,
                  ),
                  collapsedShape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  title: Text(
                    LocaleKeys.your_addresses.tr(),
                    style: context.regularText.copyWith(fontSize: 14),
                  ),
                  children: [
                    Container(
                      height: 6.h,
                      color: context.scaffoldBackgroundColor,
                    ),
                    Container(
                      color: context.scaffoldBackgroundColor,
                      child: ListView.separated(
                        itemCount: bloc.addresses.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (c, i) => Divider(
                          height: 4.h,
                          color: context.scaffoldBackgroundColor,
                        ),
                        itemBuilder: (c, i) => GestureDetector(
                          onTap: () {
                            bloc.inputData.address = bloc.addresses[i];
                            setState(() {});
                          },
                          child: Container(
                            // height: 82.h,
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              color: context.primaryColorLight,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomImage(
                                      Assets.icons.home,
                                    ).withPadding(end: 4.w),
                                    Expanded(
                                      child: Text(
                                        bloc.addresses[i].districtName,
                                        style: context.mediumText.copyWith(
                                            fontSize: 16,
                                            color: '#A4A4A4'.color),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  bloc.addresses[i].name,
                                  style: context.regularText.copyWith(
                                      fontSize: 14, color: '#A4A4A4'.color),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: AppBtn(
                onPressed: () {
                  if (sl<HourlyServiceBloc>().inputData.validate(context)) {
                    push(NamedRoutes.selectDates);
                  }
                },
                title: LocaleKeys.next.tr(),
                backgroundColor: context.indicatorColor,
              ),
            ),
            SizedBox(width: 32.h),
            CustomRadiusIcon(
              onTap: () {
                Navigator.pop(context);
              },
              backgroundColor: '#A4A4A4'.color,
              size: 40.h,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: context.primaryColorLight,
              ),
            )
          ],
        ).withPadding(horizontal: 20.w, vertical: 12.h),
      ),
    );
  }
}
