import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/core/widgets/custom_circle_icon.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/hourly_service_bloc.dart';

class SelectDatesView extends StatefulWidget {
  const SelectDatesView({super.key});

  @override
  State<SelectDatesView> createState() => _SelectDatesViewState();
}

class _SelectDatesViewState extends State<SelectDatesView> {
  final bloc = sl<HourlyServiceBloc>();
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
              bloc.inputData.packageModel?.title ?? '',
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
              'اختر ${bloc.inputData.packageModel?.totalVisits} أيام مناسبة لك',
              style: context.mediumText.copyWith(fontSize: 16),
            ),
            SizedBox(height: 12.h),
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
                focusedDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 91)),
                selectedDayPredicate: (day) => bloc.inputData.dates.contains(day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (bloc.inputData.dates.contains(selectedDay)) {
                    bloc.inputData.dates.remove(selectedDay);
                  } else if (bloc.inputData.packageModel!.totalVisits <= bloc.inputData.dates.length) {
                    FlashHelper.showToast("لقد تعديت الحد الاقصي من الزيارات", type: MessageType.warning);
                  } else {
                    bloc.inputData.dates.add(selectedDay);
                  }
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
