import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/services/location_service.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/gen/locale_keys.g.dart';

class PickLocationView extends StatefulWidget {
  final LatLng? position;
  final String? address;
  const PickLocationView({super.key, this.position, this.address});

  @override
  State<PickLocationView> createState() => _PickLocationViewState();
}

class _PickLocationViewState extends State<PickLocationView> {
  LatLng? _position = LatLng(30.0444, 31.2357);
  String? _address;
  final location = sl<LocationService>();
  final _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    _position = widget.position;
    _address = widget.address;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(LocaleKeys.pick_location.tr()),
      ),
      bottomNavigationBar: AppBtn(
        title: LocaleKeys.confirm.tr(),
        onPressed: () async {
          _address = await location.getAddressFromLatLng(latLng: _position);
          Navigator.pop(navigator.currentContext!, {"position": _position, "address": _address});
        },
      ).withPadding(horizontal: 16.w),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(target: _position!, zoom: 12),
            onCameraMove: (position) => _position = position.target,
            onMapCreated: (controller) {
              _controller.complete(controller);
              if ([widget.position, widget.address].contains(null)) {
                location.getCurrentLocation().then((value) {
                  if (value.success) {
                    _position = LatLng(value.position!.latitude, value.position!.longitude);
                    _goToTheLake(_position!);
                    _address = value.address;
                    setState(() {});
                  }
                });
              }
            },
          ),
          Icon(Icons.location_on, size: 40.h, color: context.primaryColor).center,
        ],
      ),
    );
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
}
