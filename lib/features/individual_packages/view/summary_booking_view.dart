import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/widgets/confirm_dialog.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/individual_packages_cubit.dart';
import '../cubit/individual_packages_state.dart';

class SummaryIndivadualServiceView extends StatefulWidget {
  final String title;
  final String serviceId;
  const SummaryIndivadualServiceView({super.key, required this.title, required this.serviceId});

  @override
  State<SummaryIndivadualServiceView> createState() => _SummaryIndivadualServiceViewState();
}

class _SummaryIndivadualServiceViewState extends State<SummaryIndivadualServiceView> {
  late final cubit = sl<IndividualPackagesCubit>(instanceName: widget.serviceId);
  bool acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          widget.title,
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.monthly_package_details.tr(),
                    style: context.semiboldText.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      CustomImage(
                        Assets.images.hourService,
                        height: 32.h,
                        width: 32.h,
                      ).withPadding(end: 8.w),
                      Text(
                        cubit.input.package!.title,
                        style: context.semiboldText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.the_order_area.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        "${cubit.input.address!.cityName}/${cubit.input.address!.districtName}",
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.working_nationality.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        cubit.input.package!.nationality.name,
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.duration_of_service.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        '${cubit.input.package!.duration} ${LocaleKeys.month.tr()}',
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.details_of_the_payment_plan.tr(),
                    style: context.semiboldText.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.security_amount.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        "${cubit.input.package?.insuranceAmount} ${LocaleKeys.sar.tr()}",
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.advance_amount.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        "${cubit.input.package?.advancedAmount} ${LocaleKeys.sar.tr()}",
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.monthly_fees.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        '${cubit.input.package!.monthlyFees} ${LocaleKeys.sar.tr()}/${LocaleKeys.month.tr()}',
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.final_price.tr(),
                        style: context.semiboldText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                      Text(
                        '${cubit.input.package!.finalPrice} ${LocaleKeys.sar.tr()}',
                        style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: Checkbox(
                    value: acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        acceptTerms = !acceptTerms;
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
                            ..onTap = () => push(NamedRoutes.termsConditions, arg: {'url': ApiConstants.termsAndConditionsIndv}),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<IndividualPackagesCubit, IndividualPackagesState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.createIndividualRequest.isDone) {
            showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                title: LocaleKeys.note.tr(),
                subTitle: LocaleKeys.must_be_family.tr(),
                trueBtn: LocaleKeys.ok.tr(),
                falseBtn: LocaleKeys.cancel.tr(),
              ),
            ).then((v) {
              push(
                NamedRoutes.successfullyPage,
                arg: {
                  "image": Assets.images.successfullyRed,
                  "title": LocaleKeys.your_order_has_been_sent.tr(),
                  "subtitle": LocaleKeys.we_will_review_the_assignment_and_contact_you_on_your_mobile_number.tr(),
                  "btnTitle": LocaleKeys.pay_now.tr(),
                  "onTap": () {
                    push(NamedRoutes.paymentIfream, arg: {
                      "id": cubit.contractId,
                      "type": 1,
                    }).then(
                      (value) {
                        Navigator.popUntil(
                          navigator.currentContext!,
                          (r) => r.isFirst,
                        );
                      },
                    );
                  }
                },
              );
            });
          }
        },
        builder: (context, state) {
          return AppBtn(
            loading: state.createIndividualRequest.isLoading,
            title: LocaleKeys.create_contract.tr(),
            onPressed: () {
              if (!acceptTerms) {
                FlashHelper.showToast(LocaleKeys.please_agree_to_zeina_s_terms_and_conditions.tr(), type: MessageType.warning);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: LocaleKeys.note.tr(),
                    subTitle: LocaleKeys.must_be_family.tr(),
                    trueBtn: LocaleKeys.ok.tr(),
                    falseBtn: LocaleKeys.cancel.tr(),
                  ),
                ).then((v) {
                  if (v == true) cubit.createIndividualRequest();
                });
              }
            },
          );
        },
      ).withPadding(horizontal: 50.w, vertical: 10.h),
    );
  }
}
