import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/hourly_service_bloc.dart';
import '../bloc/hourly_service_state.dart';
import '../widgets/package_details_sheet.dart';

class HourlyServiceView extends StatefulWidget {
  final String id;
  final String title;
  const HourlyServiceView({super.key, required this.id, required this.title});

  @override
  State<HourlyServiceView> createState() => _HourlyServiceViewState();
}

class _HourlyServiceViewState extends State<HourlyServiceView> {
  late final HourlyServiceBloc bloc;
  @override
  void initState() {
    sl.resetLazySingleton<HourlyServiceBloc>();
    bloc = sl<HourlyServiceBloc>()..getPacages(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: context.scaffoldBackgroundColor,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.choose_the_nationality_you_want_to_serve_you.tr(),
                style: context.semiboldText.copyWith(
                  fontSize: 14,
                ),
              ).withPadding(horizontal: 20.w),
              SizedBox(height: 18.h),
              BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
                bloc: bloc,
                builder: (context, state) {
                  return DropdownMenu(
                    width: 120.w,
                    trailingIcon: Icon(
                      CupertinoIcons.chevron_down,
                      size: 18.h,
                    ),
                    initialSelection: bloc.inputData.nationality,
                    hintText: LocaleKeys.nationality.tr(),
                    onSelected: (value) {
                      bloc.inputData.nationality = value;
                    },
                    dropdownMenuEntries: List.generate(
                      bloc.avilableNationalities.length,
                      (i) => DropdownMenuEntry(
                        value: bloc.avilableNationalities[i],
                        label: bloc.avilableNationalities[i].name,
                      ),
                    ),
                  );
                },
              ).withPadding(horizontal: 20.h),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20.w),
              //   height: 40.h,
              //   padding: EdgeInsets.symmetric(horizontal: 12.w),
              //   constraints: BoxConstraints(
              //     minWidth: 104.w,
              //   ),
              //   decoration: BoxDecoration(
              //     color: context.primaryContainer,
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         LocaleKeys.nationality.tr(),
              //         style: context.mediumText.copyWith(fontSize: 12),
              //       ),
              //       SizedBox(width: 18.w),
              //       Icon(
              //         CupertinoIcons.chevron_down,
              //         size: 18.h,
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(height: 34.h),
              Text(
                LocaleKeys.choose_the_time_period_you_want_for_your_service.tr(),
                style: context.semiboldText.copyWith(
                  fontSize: 14,
                ),
              ).withPadding(horizontal: 20.w),
              SizedBox(height: 18.h),
              BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
                bloc: bloc,
                builder: (context, state) {
                  return DropdownMenu(
                    width: 140.w,
                    trailingIcon: Icon(
                      CupertinoIcons.chevron_down,
                      size: 18.h,
                    ),
                    initialSelection: bloc.inputData.period,
                    hintText: LocaleKeys.time_period.tr(),
                    onSelected: (value) {
                      bloc.inputData.period = value;
                    },
                    dropdownMenuEntries: List.generate(
                      bloc.avilableShifts.length,
                      (i) => DropdownMenuEntry(
                        value: bloc.avilableShifts[i],
                        label: bloc.avilableShifts[i].name,
                      ),
                    ),
                  );
                },
              ).withPadding(horizontal: 20.h),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20.w),
              //   height: 40.h,
              //   padding: EdgeInsets.symmetric(horizontal: 12.w),
              //   constraints: BoxConstraints(
              //     minWidth: 104.w,
              //   ),
              //   decoration: BoxDecoration(
              //     color: context.primaryContainer,
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         LocaleKeys.time_period.tr(),
              //         style: context.mediumText.copyWith(fontSize: 12),
              //       ),
              //       SizedBox(width: 18.w),
              //       Icon(
              //         CupertinoIcons.chevron_down,
              //         size: 18.h,
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(height: 34.h),
              Text(
                LocaleKeys.choose_the_time_you_want_for_your_service.tr(),
                style: context.semiboldText.copyWith(
                  fontSize: 14,
                ),
              ).withPadding(horizontal: 20.w),
              SizedBox(height: 18.h),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 12.w,
                  children: List.generate(
                    12,
                    (i) {
                      final time = DateTime.now().copyWith(hour: 10, minute: 0, second: 0).add(i.hours);
                      final item = DateFormat('HH:mm a', context.locale.languageCode).format(time);
                      final bool selected =
                          bloc.inputData.time != null && DateFormat('HH:mm a', context.locale.languageCode).format(bloc.inputData.time!) == item;
                      return GestureDetector(
                        onTap: () {
                          bloc.inputData.time = time;
                          setState(() {});
                        },
                        child: Container(
                          height: 40.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          decoration: BoxDecoration(
                            color: selected ? context.indicatorColor : context.primaryContainer,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            item,
                            style: context.mediumText.copyWith(
                              fontSize: 12,
                              color: selected ? context.primaryColorLight : context.primaryColorDark,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              BlocBuilder<HourlyServiceBloc, HourlyServiceState>(
                bloc: bloc,
                builder: (context, state) {
                  return Wrap(
                    spacing: 20.w,
                    children: List.generate(
                      bloc.pacages.length,
                      (i) {
                        final item = bloc.pacages[i];
                        return Container(
                          width: (context.w - 60.w) / 2,
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: context.primaryColorLight,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      maxLines: 2,
                                      style: context.semiboldText.copyWith(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  CustomImage(
                                    Assets.icons.nationality,
                                    height: 18.w,
                                    width: 18.w,
                                  ).withPadding(end: 8.w),
                                  Text(
                                    item.nationality.name,
                                    style: context.regularText.copyWith(fontSize: 12),
                                  ),
                                ],
                              ).withPadding(vertical: 4.h),
                              Row(
                                children: [
                                  CustomImage(
                                    Assets.icons.time,
                                    height: 18.w,
                                    width: 18.w,
                                  ).withPadding(end: 8.w),
                                  Text(
                                    "${item.shiftHours} ${LocaleKeys.hours.tr()}",
                                    style: context.regularText.copyWith(fontSize: 12),
                                  ),
                                ],
                              ).withPadding(vertical: 4.h),
                              Row(
                                children: [
                                  CustomImage(
                                    Assets.icons.duration,
                                    height: 18.w,
                                    width: 18.w,
                                  ).withPadding(end: 8.w),
                                  Text(
                                    item.shiftName,
                                    style: context.regularText.copyWith(fontSize: 12),
                                  ),
                                ],
                              ).withPadding(vertical: 4.h),
                              Row(
                                children: [
                                  CustomImage(
                                    Assets.icons.price,
                                    height: 18.w,
                                    width: 18.w,
                                  ).withPadding(end: 8.w),
                                  Text(
                                    "${item.initialPrice} ${LocaleKeys.sar.tr()}",
                                    style: context.semiboldText.copyWith(fontSize: 12),
                                  ),
                                ],
                              ).withPadding(vertical: 4.h),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        bloc.inputData.packageModel = item;
                                        if (sl<HourlyServiceBloc>().inputData.validate(context)) {
                                          push(NamedRoutes.selectAddress);
                                        }
                                      },
                                      child: Container(
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                          color: context.indicatorColor,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          LocaleKeys.subscribe.tr(),
                                          style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (c) => HourlyPackageDetailsSheet(item: item),
                                        );
                                      },
                                      child: Container(
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                          color: context.primaryContainer,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          LocaleKeys.details.tr(),
                                          style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ).withPadding(horizontal: 20.w);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
