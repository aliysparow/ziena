import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/base_shimmer.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/features/home/bloc/home_bloc.dart';
import 'package:ziena/features/home/bloc/home_state.dart';

class SlidersWidget extends StatefulWidget {
  const SlidersWidget({super.key});

  @override
  State<SlidersWidget> createState() => _SlidersWidgetState();
}

class _SlidersWidgetState extends State<SlidersWidget> {
  final cubit = sl<HomeBloc>();

  int selectedBanner = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: cubit,
      buildWhen: (previous, current) => previous.slidersState != current.slidersState,
      builder: (context, state) {
        if (cubit.sliders.isNotEmpty) {
          return Column(
            children: [
              SizedBox(
                height: 185.h,
                width: context.w,
                child: PageView.builder(
                  itemCount: cubit.sliders.length,
                  onPageChanged: (value) {
                    selectedBanner = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) => CustomImage(
                    cubit.sliders[index].icon,
                    height: 185.h,
                    width: context.w - 40.w,
                    fit: BoxFit.fill,
                    base46: true,
                    backgroundColor: '#D9D9D9'.color,
                    borderRadius: BorderRadius.circular(20.r),
                  ).withPadding(horizontal: 20.w),
                ),
              ).withPadding(vertical: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) {
                    return AnimatedContainer(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.all(4),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: selectedBanner == index ? Colors.orange : Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state.slidersState.isLoading) {
          return BaseShimmer(
            child: Column(
              children: [
                SizedBox(
                  height: 185.h,
                  width: context.w,
                  child: Container(
                    height: 185.h,
                    width: context.w - 40.w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: '#D9D9D9'.color),
                  ).withPadding(horizontal: 20.w),
                ).withPadding(vertical: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) {
                      return AnimatedContainer(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.all(4),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
