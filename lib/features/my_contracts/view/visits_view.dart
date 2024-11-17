import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/features/my_contracts/widgets/add_favorite_dialog.dart';
import 'package:ziena/features/my_contracts/widgets/add_report_dialog.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_grid.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/contracts_cubit.dart';
import '../bloc/contracts_state.dart';
import '../widgets/content_item.dart';
import '../widgets/rate_sheet.dart';

class VisitsView extends StatefulWidget {
  final VisitsType type;
  const VisitsView({super.key, required this.type});

  @override
  State<VisitsView> createState() => _VisitsViewState();
}

class _VisitsViewState extends State<VisitsView> {
  late final cubit = sl<ContractsCubit>()..getVisits(widget.type);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          widget.type.name,
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ContractsCubit, ContractsState>(
        bloc: cubit,
        buildWhen: (previous, current) => previous.visitsState != current.visitsState,
        builder: (contrxt, state) {
          if (cubit.visits.isNotEmpty) {
            return CustomGrid(
              itemCount: cubit.visits.length,
              crossCount: 2,
              itemPadding: EdgeInsets.symmetric(horizontal: 12.w),
              itemBuilder: (context, index) {
                final item = cubit.visits[index];
                return Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: context.primaryColorLight,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(
                            Assets.images.hourService,
                            height: 35.h,
                            width: 35.h,
                          ).withPadding(horizontal: 8.w),
                          Flexible(
                            child: Text(
                              item.serviceName,
                              style: context.semiboldText.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.hashtag,
                        title: item.name,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.phone,
                        title: item.mobile01Text,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.phone,
                        title: item.mobile02Text,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.time,
                        title: item.startTime,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.status,
                        title: item.statusCodeName,
                        color: item.statusColor.color,
                      ),
                      if (widget.type == VisitsType.upcoming)
                        BlocBuilder<ContractsCubit, ContractsState>(
                          bloc: cubit,
                          buildWhen: (previous, current) => previous.reschduleVisitState != current.reschduleVisitState,
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                if (state.reschduleVisitState.isLoading) return;
                                showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                ).then((v) {
                                  if (v != null) {
                                    cubit.reschduleVisit(item.id, v);
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.primaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.change_schedule.tr(),
                                  style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AddFavoriteDialog(workId: item.workerId),
                                );
                              },
                              child: CustomImage(
                                Assets.icons.heart,
                                height: 16.h,
                                width: 16.h,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => RateSheet(visitId: item.id),
                                );
                              },
                              child: CustomImage(
                                Assets.icons.star,
                                height: 16.h,
                                width: 16.h,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AddReportDialog(workId: item.workerId),
                                );
                              },
                              child: CustomImage(
                                Assets.icons.block,
                                height: 16.h,
                                width: 16.h,
                              ),
                            ),
                          ],
                        ).withPadding(top: 6.h)
                    ],
                  ),
                );
              },
            );
            // return ListView.builder(
            //   padding: EdgeInsets.all(20.w),
            //   itemCount: cubit.contracts.length,
            //   itemBuilder: (context, index) {
            //     final item = cubit.contracts[index];
            //     return Container(
            //       margin: EdgeInsets.symmetric(vertical: 4.h),
            //       padding: EdgeInsets.all(12.w),
            //       decoration: BoxDecoration(
            //         color: context.primaryColorLight,
            //         borderRadius: BorderRadius.circular(16.r),
            //         border: Border.all(color: item.statusColor.color),
            //       ),
            //       child: Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Icon(
            //                 Icons.circle,
            //                 size: 12.h,
            //                 color: item.statusColor.color,
            //               ),
            //               CustomImage(
            //                 Assets.images.hourService,
            //                 height: 35.h,
            //                 width: 35.h,
            //               ).withPadding(horizontal: 8.w),
            //               Flexible(
            //                 child: Text(
            //                   item.serviceName,
            //                   style: context.semiboldText.copyWith(fontSize: 14),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               _item(
            //                 Assets.icons.hashtag,
            //                 item.contractNumber,
            //               ),
            //               _item(
            //                 Assets.icons.time,
            //                 DateFormat('dd/MM/yyyy').format(item.startDate),
            //               ),
            //             ],
            //           ).withPadding(vertical: 4.h),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               _item(
            //                 Assets.icons.work,
            //                 LocaleKeys.val_visit_val_week.tr(args: ["${item.totalVisits}", "${item.numberOfWeeks}"]),
            //               ),
            //               _item(
            //                 Assets.icons.price,
            //                 "${item.finalPrice} ${LocaleKeys.sar.tr()}",
            //               ),
            //             ],
            //           ).withPadding(vertical: 4.h),
            //           _item(
            //             Assets.icons.contract,
            //             item.allowPay ? LocaleKeys.payment_not_made.tr() : LocaleKeys.the_contract_has_been_paid.tr(),
            //             color: context.primaryColor,
            //           ).withPadding(vertical: 4.h),
            //           SizedBox(height: 4.h),
            //           if (item.allowPay)
            //             GestureDetector(
            //               onTap: () {
            //                 push(
            //                   NamedRoutes.paymentIfream,
            //                   arg: {"id": item.id},
            //                 );
            //               },
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: context.primaryColor,
            //                   borderRadius: BorderRadius.circular(50),
            //                 ),
            //                 padding: EdgeInsets.symmetric(vertical: 4.h),
            //                 alignment: Alignment.center,
            //                 child: Text(
            //                   LocaleKeys.pay_now.tr(),
            //                   style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ),
            //             ),
            //         ],
            //       ),
            //     );
            //   },
            // );
          } else if (state.visitsState.isDone) {
            return CustomErrorWidget(
              title: widget.type.name,
              subtitle: LocaleKeys.you_do_not_have_any_contracts_yet.tr(),
            );
          } else if (state.visitsState.isError) {
            return CustomErrorWidget(
              title: widget.type.name,
              subtitle: state.msg,
            );
          }
          return const LoadingApp();
        },
      ),
    );
  }
}
