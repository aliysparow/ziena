import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/features/company_request/cubit/company_request_state.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../cubit/company_request_cubit.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';

class CompanyRequestView extends StatefulWidget {
  const CompanyRequestView({super.key});

  @override
  State<CompanyRequestView> createState() => _CompanyRequestViewState();
}

class _CompanyRequestViewState extends State<CompanyRequestView> {
  final cubit = sl<CompanyRequestCubit>()
    ..getAllCountries()
    ..getAllProfessions();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: '#EEEEEE'.color,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.request_for_labor_for_companies.tr(),
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
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImage(Assets.images.bussniessService),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      LocaleKeys.request_for_business_services.tr(),
                      style: context.mediumText.copyWith(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              Text(
                LocaleKeys
                    .you_can_contract_with_us_to_carry_out_the_tasks_assigned_to_us_in_the_best_possible_way_write_the_required_data_and_make_sure_it_is_correct_and_we_will_contact_you
                    .tr(),
                style: context.regularText.copyWith(fontSize: 14, color: '#4D4D4D'.color),
              ),
              SizedBox(height: 20.w),
              AppField(
                controller: cubit.name,
                keyboardType: TextInputType.name,
                hintText: LocaleKeys.full_name.tr(),
              ),
              SizedBox(height: 20.w),
              AppField(
                controller: cubit.mobile,
                keyboardType: TextInputType.phone,
                hintText: LocaleKeys.phone_number.tr(),
              ),
              SizedBox(height: 20.w),
              AppField(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (c) => SelectItemSheet(
                      title: LocaleKeys.please_select_nationality.tr(),
                      items: cubit.countries,
                    ),
                  ).then((v) {
                    if (v != null) {
                      cubit.nationality = v;
                      setState(() {});
                    }
                  });
                },
                hintText: LocaleKeys.nationality.tr(),
                controller: TextEditingController(text: cubit.nationality?.name ?? ''),
              ),
              SizedBox(height: 20.w),
              AppField(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (c) => SelectItemSheet(
                      title: LocaleKeys.profession.tr(),
                      items: cubit.professions,
                    ),
                  ).then((v) {
                    if (v != null) {
                      cubit.profession = v;
                      setState(() {});
                    }
                  });
                },
                controller: TextEditingController(text: cubit.profession?.name ?? ''),
                hintText: LocaleKeys.profession.tr(),
              ),
              SizedBox(height: 20.w),
              AppField(
                controller: cubit.notes,
                hintText: LocaleKeys.note.tr(),
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<CompanyRequestCubit, CompanyRequestState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.createCorporateReq.isDone) {
            push(NamedRoutes.successfullyPage, arg: {
              "image": Assets.images.successfully,
              "title": LocaleKeys.your_order_has_been_sent.tr(),
              "subtitle": LocaleKeys.we_will_review_the_assignment_and_contact_you_on_your_mobile_number.tr(),
              "btnTitle": LocaleKeys.close.tr(),
              "onTap": () => Navigator.popUntil(context, (route) => route.isFirst),
            });
          }
        },
        builder: (context, state) {
          return AppBtn(
            backgroundColor: '#00D3AA'.color,
            loading: state.createCorporateReq.isLoading,
            title: LocaleKeys.confirm_data.tr(),
            onPressed: () {
              if (formKey.isValid) cubit.createCorporateReq();
            },
          );
        },
      ).withPadding(horizontal: 50.w, vertical: 10.h),
    );
  }
}
