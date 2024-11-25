import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/loading.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/order_model.dart';
import '../../../models/reason_model.dart';
import '../cubit/driver_home_cubit.dart';
import '../cubit/driver_home_state.dart';

class RejectOrderView extends StatefulWidget {
  final OrderModel item;
  const RejectOrderView({super.key, required this.item});

  @override
  State<RejectOrderView> createState() => _RejectOrderViewState();
}

class _RejectOrderViewState extends State<RejectOrderView> {
  final cubit = sl<DriverHomeCubit>()..getReasons();
  ReasonModel? reason;
  final note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.reject_order.tr(),
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomImage(
                  Assets.images.monthService,
                  height: 20.h,
                  width: 20.h,
                ),
                SizedBox(width: 4.w),
                Text(
                  LocaleKeys.trip_rejection_reason.tr(),
                  style: context.mediumText.copyWith(fontSize: 14),
                ),
              ],
            ),
            Text(
              LocaleKeys.trip_rejection_description.tr(),
              style: context.lightText.copyWith(fontSize: 12, color: "#4D4D4D".color),
            ),
            BlocBuilder<DriverHomeCubit, DriverHomeState>(
              bloc: cubit,
              buildWhen: (previous, current) => previous.getReasonsState != current.getReasonsState,
              builder: (context, state) {
                if (cubit.reasons.isNotEmpty) {
                  return Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          cubit.reasons.length,
                          (index) {
                            return RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: cubit.reasons[index],
                              groupValue: reason,
                              onChanged: (v) {
                                setState(() {
                                  reason = v;
                                });
                              },
                              title: Text(
                                cubit.reasons[index].name,
                                style: context.regularText.copyWith(
                                  fontSize: 14,
                                  color: cubit.reasons[index] == reason ? context.primaryColor : '#113342'.color,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else if (state.getReasonsState.isLoading) {
                  return CustomProgress(size: 15.h).withPadding(vertical: 32.h).center;
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(height: 16.h),
            AppField(
              maxLines: 4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              hintText: LocaleKeys.add_rejection_notes.tr(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocConsumer<DriverHomeCubit, DriverHomeState>(
        bloc: cubit,
        listenWhen: (previous, current) => previous.rejectOrderState != current.rejectOrderState,
        buildWhen: (previous, current) => previous.rejectOrderState != current.rejectOrderState,
        listener: (context, state) {
          if (state.rejectOrderState.isDone) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return AppBtn(
            title: LocaleKeys.confirm_trip_rejection.tr(),
            onPressed: () {
              if (reason == null) {
                FlashHelper.showToast(LocaleKeys.select_rejection_reason.tr(), type: MessageType.warning);
              } else if (note.text.isEmpty && reason!.requireNotes) {
                FlashHelper.showToast(LocaleKeys.add_rejection_notes.tr(), type: MessageType.warning);
              } else {
                cubit.rejectOrder(
                  item: widget.item,
                  reason: reason!.id,
                  note: note.text,
                );
              }
            },
            loading: state.rejectOrderState.isLoading,
            backgroundColor: '#FB3748'.color,
          );
        },
      ).withPadding(horizontal: 40.w),
    );
  }
}
