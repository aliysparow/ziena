import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/base_shimmer.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/features/home/bloc/home_bloc.dart';
import 'package:ziena/features/home/bloc/home_state.dart';
import 'package:ziena/gen/locale_keys.g.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({super.key});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  final cubit = sl<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: cubit,
      buildWhen: (previous, current) => previous.offersState != current.offersState,
      builder: (context, state) {
        if (cubit.offers.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.latest_offers.tr(),
                style: context.semiboldText.copyWith(fontSize: 18),
              ).withPadding(top: 12.h, horizontal: 20.w),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 18.w,
                  children: List.generate(cubit.offers.length, (i) {
                    final item = cubit.offers[i];
                    return SizedBox(
                      width: 192.w,
                      child: Column(
                        children: [
                          CustomImage(
                            item.icon,
                            base46: true,
                            height: 187.h,
                            width: 192.w,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            item.title,
                            style: context.semiboldText.copyWith(fontSize: 14),
                          ),
                       
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        } else if (state.offersState.isLoading) {
          return BaseShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18.h,
                  width: 100.w,
                  color: context.primaryColorLight,
                ).withPadding(top: 12.h, horizontal: 20.w),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 18.w,
                    children: List.generate(3, (i) {
                      return SizedBox(
                        width: 192.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 187.h,
                              width: 185.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: context.primaryColorLight,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Container(
                              height: 14.h,
                              width: 192.w,
                              color: context.primaryColorLight,
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              height: 14.h,
                              width: 192.w / 1.5,
                              color: context.primaryColorLight,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
