import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/widgets/app_field.dart';
import '../bloc/addresses_bloc.dart';

import '../../../core/utils/extensions.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final bloc = sl<AddressesBloc>();
  final location = sl<LocationService>();
  final _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _goToTheLake(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          'العناوين الخاصة بك',
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Theme(
        data: context.theme!.copyWith(
          inputDecorationTheme: context.theme?.inputDecorationTheme.copyWith(
            contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              height: 180.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: const CameraPosition(target: LatLng(30.0444, 31.2357)),
                  zoomControlsEnabled: false,
                  markers: {
                    if (bloc.latLng != null)
                      Marker(
                        markerId: const MarkerId('1'),
                        position: bloc.latLng!,
                      ),
                  },
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                    location.getCurrentLocation().then((v) {
                      if (v.success) {
                        bloc.fullAddress.text = v.address ?? '';
                        bloc.latLng = LatLng(v.position!.latitude, v.position!.longitude);
                        _goToTheLake(bloc.latLng!);
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
            ),
            AppField(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
              hintText: 'اسم العنوان',
              controller: bloc.name,
            ).withPadding(vertical: 8.h, horizontal: 20.w),
            Row(
              children: [
                Expanded(
                  child: AppField(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
                    hintText: 'إسم المدينة',
                    controller: bloc.name,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppField(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
                    hintText: 'رقم المبني',
                    controller: bloc.name,
                  ),
                ),
              ],
            ).withPadding(vertical: 8.h, horizontal: 20.w),
            Row(
              children: [
                Expanded(
                  child: AppField(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
                    hintText: 'اسم الولاية',
                    controller: bloc.name,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppField(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
                    hintText: 'رقم الشقة',
                    controller: bloc.name,
                  ),
                ),
              ],
            ).withPadding(vertical: 8.h, horizontal: 20.w),
            Row(
              children: [
                Expanded(
                  child: AppField(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
                    hintText: 'نوع السكن',
                    controller: bloc.name,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppField(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
                    hintText: 'رقم الطابق',
                    controller: bloc.name,
                  ),
                ),
              ],
            ).withPadding(vertical: 8.h, horizontal: 20.w),
            AppField(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide.none),
              hintText: 'أقرب معلم لك أو قريب منك',
              controller: bloc.name,
              maxLines: 3,
            ).withPadding(vertical: 8.h, horizontal: 20.w)
          ],
        ),
      ),
      bottomNavigationBar: AppBtn(
        title: 'أضف عنوان',
      ).withPadding(horizontal: 56.w),
    );
  }
}
