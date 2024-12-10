import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/individual_packages_cubit.dart';
import '../cubit/individual_packages_state.dart';

class IndividualPackagesView extends StatefulWidget {
  final String id, name;
  const IndividualPackagesView({super.key, required this.id, required this.name});

  @override
  State<IndividualPackagesView> createState() => _IndividualPackagesViewState();
}

class _IndividualPackagesViewState extends State<IndividualPackagesView> {
  late final IndividualPackagesCubit cubit;
  @override
  void initState() {
    if (!sl.isRegistered<IndividualPackagesCubit>(instanceName: widget.id)) {
      sl.registerSingleton<IndividualPackagesCubit>(IndividualPackagesCubit(), instanceName: widget.id);
    }
    cubit = sl<IndividualPackagesCubit>(instanceName: widget.id)..getPackages(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          widget.name,
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<IndividualPackagesCubit, IndividualPackagesState>(
        bloc: cubit,
        builder: (context, state) {
          if (cubit.packages.isNotEmpty) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    LocaleKeys.suggested_packages.tr(),
                    style: context.mediumText.copyWith(fontSize: 16),
                  ).withPadding(horizontal: 20.w, vertical: 10.h),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                  sliver: SliverList.separated(
                    itemCount: cubit.packages.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final item = cubit.packages[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: context.primaryColorLight,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomImage(
                                  Assets.images.hourService,
                                  height: 32.h,
                                  width: 32.h,
                                ).withPadding(end: 4.w),
                                Flexible(
                                  child: Text(
                                    item.title,
                                    style: context.semiboldText.copyWith(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Wrap(
                              spacing: 8.w,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomImage(
                                      Assets.icons.nationality,
                                      height: 18.h,
                                      width: 18.h,
                                    ).withPadding(end: 4.w),
                                    Text(
                                      item.nationality.name,
                                      style: context.semiboldText.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomImage(
                                      Assets.icons.time,
                                      height: 18.h,
                                      width: 18.h,
                                    ).withPadding(end: 4.w),
                                    Flexible(
                                      child: Text(
                                        '${item.duration} ${LocaleKeys.days.tr()}',
                                        style: context.semiboldText.copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomImage(
                                      Assets.icons.price,
                                      height: 18.h,
                                      width: 18.h,
                                    ).withPadding(end: 4.w),
                                    Flexible(
                                      child: Text(
                                        '${item.initialPrice} ${LocaleKeys.sar.tr()}/${LocaleKeys.month.tr()}',
                                        style: context.semiboldText.copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            GestureDetector(
                              onTap: () {
                                push(NamedRoutes.individualRequest, arg: {'package': item, 'title': widget.name});
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: context.primaryColor,
                                ),
                                child: Text(
                                  LocaleKeys.subscribe_now.tr(),
                                  style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: SafeArea(child: SizedBox.shrink())),
              ],
            );
            // return CustomGrid(
            //   padding: EdgeInsets.symmetric(horizontal: 10.w),
            //   itemCount: cubit.packages.length,
            //   crossCount: 2,
            //   itemPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            //   itemBuilder: (context, index) {
            //     final item = cubit.packages[index];
            //     return Container(
            //       padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(14.r),
            //         color: context.primaryColorLight,
            //       ),
            //       child: Column(
            //         children: [
            //           Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               CustomImage(
            //                 Assets.images.hourService,
            //                 height: 32.h,
            //                 width: 32.h,
            //               ).withPadding(end: 4.w),
            //               Flexible(
            //                 child: Text(
            //                   item.title,
            //                   style: context.semiboldText.copyWith(fontSize: 14),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(height: 15.h),
            //           Row(
            //             children: [
            //               CustomImage(
            //                 Assets.icons.deposit,
            //                 height: 18.h,
            //                 width: 18.h,
            //               ).withPadding(end: 4.w),
            //               Flexible(
            //                 child: Text(
            //                   LocaleKeys.deposit_val_sar.tr(args: [item.insuranceAmount.toString()]),
            //                   style: context.semiboldText.copyWith(fontSize: 12),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 15.h),
            //           Row(
            //             children: [
            //               CustomImage(
            //                 Assets.icons.price,
            //                 height: 18.h,
            //                 width: 18.h,
            //               ).withPadding(end: 4.w),
            //               Flexible(
            //                 child: Text(
            //                   '${item.finalPrice} ${LocaleKeys.sar.tr()}',
            //                   style: context.semiboldText.copyWith(fontSize: 12),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 19.h),
            //           GestureDetector(
            //             onTap: () {
            //               push(NamedRoutes.individualRequest, arg: {'package': item, 'title': widget.name});
            //             },
            //             child: Container(
            //               padding: EdgeInsets.all(4.h),
            //               alignment: Alignment.center,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(24),
            //                 color: context.primaryColor,
            //               ),
            //               child: Text(
            //                 LocaleKeys.subscribe_now.tr(),
            //                 style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // );
          } else if (state.getPackages.isError) {
            return CustomErrorWidget(
              title: widget.name,
              subtitle: state.msg,
              errorStatus: state.errorType,
            );
          } else {
            return const LoadingApp();
          }
        },
      ),
    );
  }
}
