import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/widgets/app_field.dart';
import 'package:ziena/core/widgets/confirm_dialog.dart';
import 'package:ziena/features/hourly_service/bloc/hourly_service_state.dart';

import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/custom_circle_icon.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/user_model.dart';
import '../bloc/hourly_service_bloc.dart';

class SummaryHourlyServiceView extends StatefulWidget {
  const SummaryHourlyServiceView({super.key});

  @override
  State<SummaryHourlyServiceView> createState() => _SummaryHourlyServiceViewState();
}

class _SummaryHourlyServiceViewState extends State<SummaryHourlyServiceView> {
  final bloc = sl<HourlyServiceBloc>();
  final formKey = GlobalKey<FormState>();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.package_details.tr(),
                    style: context.semiboldText.copyWith(fontSize: 16),
                  ),
                  ...List.generate(
                    7,
                    (i) {
                      final item = bloc.inputData.package!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            [
                              LocaleKeys.number_of_visits.tr(),
                              LocaleKeys.number_of_weeks.tr(),
                              LocaleKeys.number_of_work_hours.tr(),
                              LocaleKeys.time_period.tr(),
                              LocaleKeys.price_before_discount.tr(),
                              LocaleKeys.price_after_discount.tr(),
                              LocaleKeys.vat.tr(),
                            ][i],
                            style: context.mediumText.copyWith(fontSize: 15, color: '#8E8E8E'.color),
                          ),
                          Text(
                            [
                              LocaleKeys.visit_number_val.tr(args: ["${item.totalVisits}"]),
                              LocaleKeys.val_weeks.tr(args: ["${item.totalVisits}"]),
                              LocaleKeys.val_hours.tr(args: ["${item.totalVisits}"]),
                              item.shiftName,
                              "${item.initialPrice} ${LocaleKeys.sar.tr()}",
                              "${item.priceAfterDiscountWithoutVat} ${LocaleKeys.sar.tr()}",
                              "${item.vat} ${LocaleKeys.sar.tr()}",
                            ][i],
                            style: context.mediumText.copyWith(fontSize: 15, color: '#8E8E8E'.color),
                          ),
                        ],
                      ).withPadding(vertical: 12.h);
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.phone_number.tr(),
                      style: context.semiboldText.copyWith(fontSize: 16),
                    ),
                    TextSpan(
                      text: ' | ',
                      style: context.semiboldText.copyWith(fontSize: 16),
                    ),
                    TextSpan(
                      text: UserModel.i.phone,
                      style: context.regularText.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AppField(
                      keyboardType: TextInputType.phone,
                      controller: bloc.inputData.phone1,
                      hintText: LocaleKeys.phone_number.tr(),
                      withBorder: false,
                      prefixIcon: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.additional_number.tr(),
                              style: context.semiboldText.copyWith(fontSize: 16),
                            ),
                            TextSpan(
                              text: ' | ',
                              style: context.semiboldText.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ).withPadding(vertical: 12.h),
                    ),
                    AppField(
                      keyboardType: TextInputType.phone,
                      controller: bloc.inputData.phone2,
                      hintText: LocaleKeys.another_number_optional.tr(),
                      withBorder: false,
                      isRequired: false,
                      prefixIcon: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.another_additional_mobile_number.tr(),
                              style: context.semiboldText.copyWith(fontSize: 16),
                            ),
                            TextSpan(
                              text: ' | ',
                              style: context.semiboldText.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ).withPadding(vertical: 12.h),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.your_address.tr(),
                    style: context.semiboldText.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      CustomImage(
                        Assets.icons.home,
                        color: context.primaryColorDark,
                      ).withPadding(end: 4.w),
                      Expanded(
                        child: Text(
                          bloc.inputData.address!.districtName,
                          style: context.mediumText.copyWith(fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.popUntil(
                            context,
                            (r) => r.settings.name == NamedRoutes.selectAddress,
                          );
                        },
                        child: CustomImage(
                          Assets.icons.edit,
                          height: 24.h,
                          width: 24.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    bloc.inputData.address!.name,
                    style: context.regularText.copyWith(fontSize: 14, color: '#A4A4A4'.color),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${LocaleKeys.the_type_of_place.tr()} : ${bloc.inputData.address!.apartmentTypeName}",
                    style: context.regularText.copyWith(fontSize: 14, color: '#A4A4A4'.color),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${LocaleKeys.apartment_number.tr()} : ${bloc.inputData.address!.apartmentNumber}",
                    style: context.regularText.copyWith(fontSize: 14, color: '#A4A4A4'.color),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${LocaleKeys.floor_number.tr()} : ${bloc.inputData.address!.floorNumber}",
                    style: context.regularText.copyWith(fontSize: 14, color: '#A4A4A4'.color),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.choose_days.tr(),
                          style: context.mediumText.copyWith(fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.popUntil(
                            context,
                            (r) => r.settings.name == NamedRoutes.selectDates,
                          );
                        },
                        child: CustomImage(
                          Assets.icons.edit,
                          height: 24.h,
                          width: 24.h,
                        ),
                      ),
                    ],
                  ).withPadding(bottom: 8.h),
                  ...List.generate(bloc.inputData.dates.length, (i) {
                    return Text(
                      '${i + 1}. ${DateFormat('dd/MM/yyyy EEEE', context.locale.languageCode).format(bloc.inputData.dates[i])}',
                      style: context.lightText.copyWith(fontSize: 14),
                    ).withPadding(vertical: 6.h);
                  })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.total_price.tr(),
                    style: context.semiboldText.copyWith(fontSize: 16),
                  ),
                  Text(
                    "${bloc.inputData.package!.finalPrice} ${LocaleKeys.sar.tr()}",
                    style: context.semiboldText.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: Checkbox(
                    value: bloc.inputData.acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        bloc.inputData.acceptTerms = !bloc.inputData.acceptTerms;
                      });
                    },
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: LocaleKeys.agree_to.tr(),
                          style: context.lightText.copyWith(fontSize: 16, color: '#113342'.color),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: LocaleKeys.terms_and_conditions_of_zina.tr(),
                          style: context.lightText.copyWith(
                            fontSize: 16,
                            color: '#113342'.color,
                            decoration: TextDecoration.underline,
                            decorationColor: '#113342'.color,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => push(NamedRoutes.termsConditions, arg: {'url': ApiConstants.termsAndConditionsHourly}),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ).withPadding(horizontal: 16.w, vertical: 12.h)
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: BlocConsumer<HourlyServiceBloc, HourlyServiceState>(
                bloc: bloc,
                buildWhen: (previous, current) => previous.bookingState != current.bookingState,
                listenWhen: (previous, current) => previous.bookingState != current.bookingState,
                listener: (context, state) {
                  if (state.bookingState.isDone) {}
                },
                builder: (context, state) {
                  return AppBtn(
                    loading: state.bookingState.isLoading,
                    onPressed: () {
                      if (formKey.isValid && bloc.inputData.validate(context)) {
                        showDialog(
                          context: context,
                          builder: (context) => ConfirmDialog(
                            title: LocaleKeys.note.tr(),
                            subTitle: LocaleKeys.must_be_family.tr(),
                            trueBtn: LocaleKeys.ok.tr(),
                            falseBtn: LocaleKeys.cancel.tr(),
                          ),
                        ).then((v) {
                          if (v == true) bloc.createBooking();
                        });
                      }
                    },
                    title: LocaleKeys.create_contract.tr(),
                    backgroundColor: context.indicatorColor,
                  );
                },
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
