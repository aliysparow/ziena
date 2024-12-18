import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/driver_order_model.dart';
import '../cubit/driver_home_cubit.dart';
import '../cubit/driver_home_state.dart';

class OrderDetailsSheet extends StatelessWidget {
  final DriverOrderModel item;
  const OrderDetailsSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverHomeCubit, DriverHomeState>(
      bloc: sl<DriverHomeCubit>(),
      buildWhen: (previous, current) => previous.getVisit != current.getVisit,
      builder: (context, state) {
        return CustomAppSheet(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  Assets.images.monthService,
                  height: 30.h,
                  width: 30.h,
                ),
                Flexible(
                  child: Text(
                    item.serviceName,
                    style: context.regularText.copyWith(fontSize: 16),
                  ).withPadding(start: 8.w),
                )
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.number_of_visits.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                ),
                Flexible(
                  child: Text(
                    item.visitNumber,
                    style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                  ),
                ),
              ],
            ).withPadding(vertical: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.client_name.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                ),
                Flexible(
                  child: Text(
                    item.customerName.split(":").last,
                    style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                  ),
                ),
              ],
            ).withPadding(vertical: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.worker_name.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                ),
                Flexible(
                  child: Text(
                    item.employeeName.split(":").last,
                    style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                  ),
                ),
              ],
            ).withPadding(vertical: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.date_and_time.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                ),
                Flexible(
                  child: Text(
                    item.startTime,
                    style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                  ),
                ),
              ],
            ).withPadding(vertical: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.phone_number_1.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            item.mobile01,
                            style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
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
                          final Uri phoneUri = Uri.parse("https://wa.me/+966${item.mobile01}");

                          launchUrl(phoneUri, mode: LaunchMode.externalApplication);
                        },
                        child: CustomImage(
                          Assets.icons.smsPhone,
                          height: 20.h,
                          width: 28.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).withPadding(vertical: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.phone_number_2.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
                ),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            item.mobile02,
                            style: context.mediumText.copyWith(fontSize: 16, color: '#8E8E8E'.color),
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
                  ),
                ),
              ],
            ).withPadding(vertical: 16.h),
            SizedBox(height: 8.h),
            SizedBox(
              height: 103.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
            SizedBox(height: 50.h),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<DriverHomeCubit, DriverHomeState>(
                    buildWhen: (p, c) => p.changeStatus != c.changeStatus && item == sl<DriverHomeCubit>().selectedOrder,
                    bloc: sl<DriverHomeCubit>(),
                    builder: (context, state) {
                      return AppBtn(
                        loading: state.changeStatus.isLoading,
                        onPressed: () {
                          sl<DriverHomeCubit>().changeStatus(item: item);
                        },
                        title: item.buttonText,
                      );
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: AppBtn(
                    onPressed: () {
                      push(NamedRoutes.rejectOrder, arg: {"item": item});
                    },
                    title: LocaleKeys.reject_trip.tr(),
                    backgroundColor: '#FB3748'.color,
                  ),
                ),
              ],
            ).withPadding(horizontal: 20.w)
          ],
        );
      },
    );
  }
}
