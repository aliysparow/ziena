import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/widgets/flash_helper.dart';

import '../../../core/services/location_service.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/select_item_sheet.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/addresses_bloc.dart';
import '../bloc/addresses_state.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final bloc = sl<AddressesBloc>()..getCities();
  final location = sl<LocationService>();
  final _controller = Completer<GoogleMapController>();
  final form = GlobalKey<FormState>();
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
        child: Form(
          key: form,
          child: SingleChildScrollView(
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
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(target: bloc.latLng!),
                      onTap: (v) {
                        push(NamedRoutes.pickLocation, arg: {'position': bloc.latLng, 'address': bloc.fullAddress.text}).then((v) {
                          if (v != null) {
                            Timer(300.milliseconds, () {
                              bloc.fullAddress.text = v['address'];
                              bloc.latLng = v['position'];
                              _goToTheLake(bloc.latLng!);
                              setState(() {});
                            });
                          }
                        });
                      },
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                  hintText: 'اسم العنوان',
                  controller: bloc.name,
                ).withPadding(vertical: 8.h, horizontal: 20.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppField(
                        keyboardType: TextInputType.name,
                        onTap: () async {
                          if (bloc.cities.isEmpty) {
                            await bloc.getAddresses();
                            return;
                          }
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SelectItemSheet(
                              title: LocaleKeys.select_city.tr(),
                              items: bloc.cities,
                              initItem: bloc.city,
                            ),
                          ).then((v) {
                            if (v != null && bloc.city != v) {
                              bloc.city = v;
                              bloc.districts = [];
                              bloc.district = null;
                              bloc.getDistricts();
                              setState(() {});
                            }
                          });
                        },
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                        hintText: LocaleKeys.city.tr(),
                        controller: TextEditingController(text: bloc.city?.name ?? ''),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: BlocBuilder<AddressesBloc, AddressesState>(
                        bloc: bloc,
                        buildWhen: (previous, current) => previous.getDistricts != current.getDistricts,
                        builder: (context, state) {
                          return AppField(
                            keyboardType: TextInputType.name,
                            onTap: () async {
                              if (bloc.city == null) {
                                return FlashHelper.showToast(
                                  LocaleKeys.please_select_city.tr(),
                                  type: MessageType.warning,
                                );
                              }
                              if (!state.getDistricts.isDone) {
                                await bloc.getDistricts();
                              }
                              showModalBottomSheet(
                                context: navigator.currentContext!,
                                builder: (context) => SelectItemSheet(
                                  title: LocaleKeys.select_district.tr(),
                                  items: bloc.districts,
                                  initItem: bloc.district,
                                ),
                              ).then((v) {
                                if (v != null && bloc.city != v) {
                                  bloc.district = v;
                                  setState(() {});
                                }
                              });
                            },
                            loading: state.getDistricts.isLoading,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                            hintText: LocaleKeys.district.tr(),
                            controller: TextEditingController(text: bloc.district?.name ?? ''),
                          );
                        },
                      ),
                    ),
                  ],
                ).withPadding(vertical: 8.h, horizontal: 20.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppField(
                        keyboardType: TextInputType.name,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                        hintText: 'رقم المبني',
                        controller: bloc.buildingNumber,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AppField(
                        onTap: () {
                          showModalBottomSheet(
                            context: navigator.currentContext!,
                            builder: (context) => SelectItemSheet(
                              title: LocaleKeys.apartment_type.tr(),
                              items: [
                                SelectModel(id: 1, name: LocaleKeys.apartment.tr()),
                                SelectModel(id: 2, name: LocaleKeys.villa.tr()),
                              ],
                              initItem: bloc.apartmentType,
                            ),
                          ).then((v) {
                            if (v != null && bloc.city != v) {
                              bloc.apartmentType = v;
                              setState(() {});
                            }
                          });
                        },
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                        hintText: 'نوع السكن',
                        controller: TextEditingController(text: bloc.apartmentType?.name ?? ''),
                      ),
                    ),
                  ],
                ).withPadding(vertical: 8.h, horizontal: 20.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppField(
                        keyboardType: const TextInputType.numberWithOptions(signed: true),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                        hintText: 'رقم الطابق',
                        controller: bloc.floorNumber,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AppField(
                        keyboardType: TextInputType.number,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                        hintText: 'رقم الشقة',
                        controller: bloc.apartmentNumber,
                        isRequired: false,
                      ),
                    ),
                  ],
                ).withPadding(vertical: 8.h, horizontal: 20.w),
                AppField(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide.none),
                  hintText: 'أقرب معلم لك أو قريب منك',
                  controller: bloc.fullAddress,
                  maxLines: 3,
                ).withPadding(vertical: 8.h, horizontal: 20.w)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddressesBloc, AddressesState>(
        bloc: bloc,
        listenWhen: (previous, current) => previous.createAddress != current.createAddress,
        listener: (context, state) {
          if (state.createAddress.isDone) {
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          return AppBtn(
            loading: state.createAddress.isLoading,
            onPressed: () => form.isValid ? bloc.createAddress() : null,
            title: 'أضف عنوان',
          );
        },
      ).withPadding(horizontal: 56.w),
    );
  }
}
