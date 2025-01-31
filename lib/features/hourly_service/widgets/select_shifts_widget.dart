import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/base_shimmer.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/hourly_service_bloc.dart';
import '../bloc/hourly_service_state.dart';

class SelectShiftsWidget extends StatefulWidget {
  const SelectShiftsWidget({super.key});

  @override
  State<SelectShiftsWidget> createState() => _SelectShiftsWidgetState();
}

class _SelectShiftsWidgetState extends State<SelectShiftsWidget> {
  final bloc = sl<HourlyServiceBloc>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            if (state.getPacagesState.isLoading) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: List.generate(
                    3,
                    (index) {
                      return BaseShimmer(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(end: 10),
                          height: 40.h,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12.w,
                children: List.generate(
                  bloc.avilableShifts.length,
                  (i) {
                    final item = bloc.avilableShifts[i];
                    final selected = bloc.inputData.period == item;
                    return GestureDetector(
                      onTap: () {
                        bloc.inputData.period = item;
                        if (bloc.inputData.package != null && bloc.inputData.package!.shift != bloc.inputData.period?.id) {
                          bloc.inputData.package = null;
                        }
                        bloc.refresh();
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
                          item.name,
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
            );
          },
        ),
      ],
    );
  }
}
