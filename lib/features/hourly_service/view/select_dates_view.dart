import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/custom_circle_icon.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/hourly_service_bloc.dart';

class SelectDatesView extends StatefulWidget {
  const SelectDatesView({super.key});

  @override
  State<SelectDatesView> createState() => _SelectDatesViewState();
}

class _SelectDatesViewState extends State<SelectDatesView> {
  final bloc = sl<HourlyServiceBloc>();
  @override
  void initState() {
    bloc.inputData
      ..dates.clear()
      ..week.clear();
    super.initState();
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر ${bloc.inputData.package?.totalVisits} أيام مناسبة لك',
              style: context.mediumText.copyWith(fontSize: 16),
            ),
            // Text(
            //   DateFormat('dd-MM-yyyy hh:mm a', 'en').format(bloc.inputData.package!.lastDate).toString(),
            //   style: context.mediumText.copyWith(fontSize: 16),
            //   textDirection: TextDirection.ltr,
            // ),
            Wrap(
              spacing: 6.w,
              runSpacing: 8.w,
              children: List.generate(
                7,
                (i) {
                  final day = AppConstants.weekDays[i];
                  final isAvilable = kDebugMode || (bloc.inputData.package?.days.contains(day.id) ?? false);
                  final bool selected = bloc.inputData.week.any((e) => e == day.id);
                  return Opacity(
                    opacity: isAvilable ? 1 : 0.3,
                    child: GestureDetector(
                      onTap: () {
                        if (isAvilable == false) return;
                        if (selected) {
                          bloc.inputData.week.remove(day.id);
                          bloc.inputData.dates.clear();
                        } else if (bloc.inputData.week.length == bloc.inputData.package?.totalVisits) {
                          // FlashHelper.showToast("لم يعد ايام متاحة لاختيارها", type: MessageType.warning);
                          bloc.inputData.week.removeAt(0);
                          bloc.inputData.week.add(day.id);
                          bloc.inputData.dates.clear();
                        } else {
                          bloc.inputData.week.add(day.id);
                          bloc.inputData.dates.clear();
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 40.h,
                        alignment: Alignment.center,
                        width: (context.w - 3 * 8.w - 40.w) / 4,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: selected ? context.indicatorColor : context.primaryContainer,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          day.name.tr(),
                          style: context.mediumText.copyWith(
                            fontSize: 12,
                            color: selected ? context.primaryColorLight : context.primaryColorDark,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).withPadding(vertical: 20.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: context.primaryColorLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                onHeaderTapped: (focusedDay) {},
                headerVisible: true,
                shouldFillViewport: false,
                daysOfWeekHeight: 30.h,
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(shape: BoxShape.circle),
                  todayTextStyle: TextStyle(color: context.primaryColorDark, fontSize: 16),
                  selectedDecoration: BoxDecoration(color: context.indicatorColor),
                  defaultDecoration: BoxDecoration(border: Border.all(color: context.hintColor, width: 0.5)),
                  holidayDecoration: BoxDecoration(border: Border.all(color: context.hintColor, width: 0.5)),
                  weekendDecoration: BoxDecoration(border: Border.all(color: context.hintColor, width: 0.5)),
                  disabledDecoration: BoxDecoration(border: Border.all(color: context.hintColor, width: 0.5)),
                  rowDecoration: BoxDecoration(border: Border.all(color: context.hintColor, width: 0.5)),
                  cellPadding: EdgeInsets.zero,
                  tablePadding: EdgeInsets.zero,
                  cellMargin: EdgeInsets.zero,
                ),
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                focusedDay: bloc.inputData.dates.firstOrNull ?? DateTime.now().add(1.days),
                lastDay: bloc.inputData.package?.lastDate ?? DateTime.now().add(const Duration(days: 91)),
                selectedDayPredicate: (day) => bloc.inputData.dates.firstOrNull == day,
                enabledDayPredicate: (day) {
                  // if (bloc.inputData.dates.isNotEmpty) {
                  //   return bloc.inputData.dates.first == day;
                  // } else
                  if (bloc.inputData.week.contains(day.weekday)) {
                    return true;
                  } else {
                    return false;
                  }
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // if (bloc.inputData.dates.contains(selectedDay)) {
                  //   bloc.inputData.dates.clear();
                  // } else {
                  //   // bloc.inputData.dates.add(selectedDay);
                  bloc.inputData.dates.clear();
                  for (int i = 0; i < 7; i++) {
                    if (bloc.inputData.week.contains(selectedDay.add(i.days).weekday)) {
                      log('add ${selectedDay.add(i.days).weekday}');
                      bloc.inputData.dates.add(selectedDay.add(i.days));
                    }
                  }
                  // }
                  // if (bloc.inputData.dates.contains(selectedDay)) {
                  //   bloc.inputData.dates.remove(selectedDay);
                  // } else if (bloc.inputData.package!.totalVisits <= bloc.inputData.dates.length) {
                  //   FlashHelper.showToast("لقد تعديت الحد الاقصي من الزيارات", type: MessageType.warning);
                  // } else {
                  //   bloc.inputData.dates.add(selectedDay);
                  // }
                  setState(() {});
                },
              ),
            ),
            if (bloc.inputData.dates.isNotEmpty)
              Container(
                width: context.w,
                margin: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: context.primaryColorLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الأيام المختارة",
                      style: context.mediumText.copyWith(fontSize: 16),
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
                    push(NamedRoutes.summaryHourlyService);
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
