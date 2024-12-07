import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/features/driver_home/cubit/driver_home_cubit.dart';
import 'package:ziena/features/driver_home/cubit/driver_home_state.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/driver_order_model.dart';
import 'order_details_sheet.dart';

class DriverOrderItem extends StatelessWidget {
  final DriverOrderModel item;
  const DriverOrderItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: context.primaryColorLight,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImage(
                Assets.images.monthService,
                height: 30.h,
                width: 30.h,
              ),
              Expanded(
                child: Text(
                  item.serviceName,
                  style: context.regularText.copyWith(fontSize: 16),
                ).withPadding(start: 8.w),
              )
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              CustomImage(
                Assets.icons.hashtag,
                height: 18.h,
                width: 18.h,
              ),
              Flexible(
                child: Text(
                  item.visitNumber,
                  style: context.semiboldText.copyWith(fontSize: 12),
                ).withPadding(start: 8.w),
              )
            ],
          ).withPadding(vertical: 7.h),
          Row(
            children: [
              CustomImage(
                Assets.icons.user,
                height: 18.h,
                width: 18.h,
              ),
              Flexible(
                child: Text(
                  "${LocaleKeys.client.tr()}:${item.customerName.split(":").last}",
                  style: context.semiboldText.copyWith(fontSize: 12),
                ).withPadding(start: 8.w),
              )
            ],
          ).withPadding(vertical: 7.h),
          Row(
            children: [
              CustomImage(
                Assets.icons.bag,
                height: 18.h,
                width: 18.h,
              ),
              Flexible(
                child: Text(
                  item.employeeName,
                  style: context.semiboldText.copyWith(fontSize: 12),
                ).withPadding(start: 8.w),
              )
            ],
          ).withPadding(vertical: 7.h),
          Row(
            children: [
              CustomImage(
                Assets.icons.time,
                height: 18.h,
                width: 18.h,
              ),
              Expanded(
                child: Text(
                  item.startTime,
                  style: context.regularText.copyWith(fontSize: 12),
                ).withPadding(start: 8.w),
              )
            ],
          ).withPadding(vertical: 7.h),
          Row(
            children: [
              CustomImage(
                Assets.icons.phone,
                height: 18.h,
                width: 18.h,
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    item.mobile01,
                    style: context.semiboldText.copyWith(fontSize: 12),
                    textDirection: TextDirection.ltr,
                  ).withPadding(horizontal: 8.w),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final Uri phoneUri = Uri(scheme: 'tel', path: item.mobile01);
                  launchUrl(phoneUri);
                },
                child: CustomImage(
                  Assets.icons.callPhone,
                  height: 20.h,
                  width: 28.w,
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () {
                  final Uri phoneUri = Uri(path: "https://wa.me/+966${item.mobile01}");
                  launchUrl(phoneUri);
                },
                child: CustomImage(
                  Assets.icons.smsPhone,
                  height: 20.h,
                  width: 28.w,
                ),
              ),
            ],
          ).withPadding(vertical: 7.h),
          Row(
            children: [
              CustomImage(
                Assets.icons.phone,
                height: 18.h,
                width: 18.h,
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    item.mobile02,
                    style: context.semiboldText.copyWith(fontSize: 12),
                    textDirection: TextDirection.ltr,
                  ).withPadding(horizontal: 8.w),
                ),
              ),
              GestureDetector(
                onTap: () {
                  final Uri phoneUri = Uri(scheme: 'tel', path: item.mobile02);
                  launchUrl(phoneUri);
                },
                child: CustomImage(
                  Assets.icons.callPhone,
                  height: 20.h,
                  width: 28.w,
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () {
                  final Uri phoneUri = Uri(scheme: 'sms', path: item.mobile02);
                  launchUrl(phoneUri);
                },
                child: CustomImage(
                  Assets.icons.smsPhone,
                  height: 20.h,
                  width: 28.w,
                ),
              ),
            ],
          ).withPadding(vertical: 7.h),
          SizedBox(
            height: 103.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(item.mapUrl));
                },
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(item.lat, item.long),
                    zoom: 17,
                  ),
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  onTap: (v) {
                    launchUrl(Uri.parse(item.mapUrl));
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('value'),
                      position: LatLng(item.lat, item.long),
                    ),
                  },
                  mapType: MapType.normal,
                ),
              ),
            ),
          ).withPadding(vertical: 7.h),
          Row(
            children: [
              Expanded(
                child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
                  buildWhen: (p, c) => p.changeStatus != c.changeStatus && item == sl<DriverHomeCubit>().selectedOrder,
                  bloc: sl<DriverHomeCubit>(),
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        if (!state.changeStatus.isLoading) {
                          sl<DriverHomeCubit>().changeStatus(item: item);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: context.primaryColor.withOpacity(state.changeStatus.isLoading ? 0.2 : 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          item.buttonText,
                          style: context.semiboldText.copyWith(
                            fontSize: 12,
                            color: context.primaryColorLight,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (c) => OrderDetailsSheet(item: item),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: '#BBBBBB'.color,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.trip_details.tr(),
                      style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
                    ),
                  ),
                ),
              ),
            ],
          ).withPadding(vertical: 7.h),
        ],
      ),
    );
  }
}
