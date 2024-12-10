import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/features/individual_packages/cubit/individual_packages_cubit.dart';
import 'package:ziena/features/individual_packages/cubit/individual_packages_state.dart';
import 'package:ziena/models/user_model.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/individaul_package_model.dart';

class IndividualRequestView extends StatefulWidget {
  final String title;
  final IndividaulPackageModel package;
  const IndividualRequestView({super.key, required this.title, required this.package});

  @override
  State<IndividualRequestView> createState() => _IndividualRequestViewState();
}

class _IndividualRequestViewState extends State<IndividualRequestView> {
  final cubit = sl<IndividualPackagesCubit>();
  final name = TextEditingController(text: '${UserModel.i.firstName} ${UserModel.i.lastName}');
  final phone = TextEditingController(text: UserModel.i.phone);
  final note = TextEditingController();
  final form = GlobalKey<FormState>();
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
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.package.title,
                          style: context.semiboldText.copyWith(fontSize: 14),
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
                          widget.package.nationality.name,
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
                          '${widget.package.duration} ${LocaleKeys.month.tr()}',
                          style: context.regularText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.total_price.tr(),
                          style: context.semiboldText.copyWith(fontSize: 16, color: '#113342'.color),
                        ),
                        Text(
                          '${widget.package.finalPrice} ${LocaleKeys.sar.tr()}',
                          style: context.semiboldText.copyWith(fontSize: 16, color: '#113342'.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 12.h),
              // Text(
              //   LocaleKeys.hourly_request_msg.tr(),
              //   style: context.lightText.copyWith(
              //     fontSize: 12,
              //     color: '#4D4D4D'.color,
              //   ),
              // ),
              SizedBox(height: 20.h),
              AppField(
                controller: name,
                hintText: LocaleKeys.full_name.tr(),
                title: LocaleKeys.full_name.tr(),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 12.h),
              AppField(
                keyboardType: TextInputType.phone,
                controller: phone,
                hintText: LocaleKeys.phone_number.tr(),
                title: LocaleKeys.phone_number.tr(),
                prefixIcon: SizedBox(
                  width: 70.w,
                  child: Text(
                    '+966',
                    style: context.semiboldText,
                  ).center,
                ),
              ),
              SizedBox(height: 12.h),
              AppField(
                controller: note,
                hintText: LocaleKeys.add_note.tr(),
                title: LocaleKeys.note.tr(),
                maxLines: 4,
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
                            recognizer: TapGestureRecognizer()..onTap = () => push(NamedRoutes.termsConditions),
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
      ),
      bottomNavigationBar: BlocConsumer<IndividualPackagesCubit, IndividualPackagesState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.createIndividualRequest.isDone) {
            push(NamedRoutes.successfullyPage, arg: {
              "image": Assets.images.successfullyRed,
              "title": LocaleKeys.your_order_has_been_sent.tr(),
              "subtitle": LocaleKeys.we_will_review_the_assignment_and_contact_you_on_your_mobile_number.tr(),
              "onTap": () => Navigator.popUntil(context, (route) => route.isFirst),
            });
          }
        },
        builder: (context, state) {
          return AppBtn(
            loading: state.createIndividualRequest.isLoading,
            title: LocaleKeys.confirm_data.tr(),
            onPressed: () {
              if (!form.isValid || !acceptTerms) {
                if (!acceptTerms) FlashHelper.showToast(LocaleKeys.please_agree_to_zeina_s_terms_and_conditions.tr(), type: MessageType.warning);
              } else {
                cubit.createIndividualRequest(widget.package, name.text, phone.text, note.text);
              }
            },
          );
        },
      ).withPadding(horizontal: 50.w, vertical: 10.h),
    );
  }
}
