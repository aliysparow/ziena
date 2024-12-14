import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/individual_packages_cubit.dart';
import '../cubit/individual_packages_state.dart';
import '../widget/workers_list_sheet.dart';

class IndividualRequestView extends StatefulWidget {
  final String title;
  final String serviceId;
  const IndividualRequestView({super.key, required this.title, required this.serviceId});

  @override
  State<IndividualRequestView> createState() => _IndividualRequestViewState();
}

class _IndividualRequestViewState extends State<IndividualRequestView> {
  late final cubit = sl<IndividualPackagesCubit>(instanceName: widget.serviceId)
    ..getAddresses(true)
    ..getWorkers(widget.serviceId, true);

  final form = GlobalKey<FormState>();

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
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.total_price.tr(),
                          style: context.semiboldText.copyWith(fontSize: 16, color: '#113342'.color),
                        ),
                        Text(
                          '${cubit.input.package!.finalPrice} ${LocaleKeys.sar.tr()}/${LocaleKeys.month.tr()}',
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
              BlocConsumer<IndividualPackagesCubit, IndividualPackagesState>(
                bloc: cubit,
                listenWhen: (p, c) => p.getAddresses != c.getAddresses,
                buildWhen: (p, c) => p.getAddresses != c.getAddresses,
                listener: (context, state) {
                  if (state.getAddresses.isDone) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (c) => SelectItemSheet(
                        title: LocaleKeys.please_select_address.tr(),
                        items: cubit.addresses,
                        initItem: cubit.input.address,
                      ),
                    ).then((c) {
                      if (c != null) {
                        cubit.input.address = c;
                        setState(() {});
                      }
                    });
                  }
                },
                builder: (context, state) {
                  return AppField(
                    loading: state.getAddresses.isLoading,
                    onTap: cubit.getAddresses,
                    controller: TextEditingController(text: cubit.input.address?.name ?? ''),
                    hintText: LocaleKeys.your_address.tr(),
                    title: LocaleKeys.your_address.tr(),
                    keyboardType: TextInputType.name,
                  );
                },
              ),
              SizedBox(height: 12.h),
              // AppField(
              //   keyboardType: TextInputType.phone,
              //   controller: phone,
              //   hintText: LocaleKeys.phone_number.tr(),
              //   title: LocaleKeys.phone_number.tr(),
              //   prefixIcon: SizedBox(
              //     width: 70.w,
              //     child: Text(
              //       '+966',
              //       style: context.semiboldText,
              //     ).center,
              //   ),
              // ),
              BlocConsumer<IndividualPackagesCubit, IndividualPackagesState>(
                bloc: cubit,
                listenWhen: (p, c) => p.getWorkers != c.getWorkers,
                buildWhen: (p, c) => p.getWorkers != c.getWorkers,
                listener: (context, state) {
                  if (state.getWorkers.isDone) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (c) => WorkersListSheet(
                        workers: cubit.workers,
                        selected: cubit.input.worker,
                      ),
                    ).then((c) {
                      if (c != null) {
                        cubit.input.worker = c;
                        setState(() {});
                      }
                    });
                  }
                },
                builder: (context, state) {
                  return AppField(
                    loading: state.getWorkers.isLoading,
                    onTap: () => cubit.getWorkers(widget.serviceId),
                    controller: TextEditingController(text: cubit.input.worker?.name ?? ''),
                    hintText: LocaleKeys.select_worker.tr(),
                    title: LocaleKeys.choose_from_the_workers.tr(),
                    keyboardType: TextInputType.name,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBtn(
        title: LocaleKeys.confirm_data.tr(),
        onPressed: () {
          if (form.isValid) {
            push(NamedRoutes.summaryIndivadualService, arg: {
              "title": widget.title,
              "serviceId": widget.serviceId,
            });
          }
        },
      ).withPadding(horizontal: 50.w, vertical: 10.h),
    );
  }
}
