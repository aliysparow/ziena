import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/base_shimmer.dart';
import 'package:ziena/features/driver_home/cubit/driver_home_cubit.dart';
import 'package:ziena/features/driver_home/cubit/driver_home_state.dart';

class ShiftsWidget extends StatefulWidget {
  const ShiftsWidget({super.key});

  @override
  State<ShiftsWidget> createState() => _ShiftsWidgetState();
}

class _ShiftsWidgetState extends State<ShiftsWidget> {
  final cubit = sl<DriverHomeCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      buildWhen: (previous, current) => previous.shiftsState != current.shiftsState,
      bloc: cubit,
      builder: (context, state) {
        if (cubit.shifts.isNotEmpty) {
          return SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 12.w,
                children: List.generate(
                  cubit.shifts.length,
                  (i) {
                    return GestureDetector(
                      onTap: () {
                        cubit.selectedShift = cubit.shifts[i];
                        setState(() {});
                        cubit.getOrders(cubit.selectedShift!, cubit.selectedDriverType);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: cubit.shifts[i] == cubit.selectedShift ? context.primaryColor : context.primaryColorLight,
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Text(
                          cubit.shifts[i].name,
                          style: cubit.shifts[i] == cubit.selectedShift
                              ? context.semiboldText.copyWith(fontSize: 16, color: context.primaryColorLight)
                              : context.regularText.copyWith(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state.shiftsState.isLoading) {
          return SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              scrollDirection: Axis.horizontal,
              child: BaseShimmer(
                child: Wrap(
                  spacing: 12.w,
                  children: List.generate(
                    2,
                    (i) {
                      return Container(
                        width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: context.primaryColorLight,
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Text(
                          '',
                          style: context.regularText.copyWith(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter();
        }
      },
    );
  }
}
