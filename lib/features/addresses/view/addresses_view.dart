import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/widgets/confirmation_sheet.dart';

import '../../../core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/addresses_bloc.dart';
import '../bloc/addresses_state.dart';

class AddressesView extends StatefulWidget {
  const AddressesView({super.key});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> {
  final bloc = sl<AddressesBloc>()..getAddresses();
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
        actions: [
          BlocBuilder<AddressesBloc, AddressesState>(
            bloc: bloc,
            builder: (context, state) {
              if (bloc.addresses.isNotEmpty) {
                return GestureDetector(
                  onTap: () => push(NamedRoutes.addAddress).then((value) {
                    if (value == true) {
                      bloc.getAddresses();
                    }
                  }),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: context.primaryColorLight,
                          size: 14.h,
                        ).withPadding(end: 4.w),
                        Text(
                          'إضافة عنوان جديد',
                          style: context.semiboldText.copyWith(
                            fontSize: 12,
                            color: context.primaryColorLight,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
      body: BlocBuilder<AddressesBloc, AddressesState>(
        bloc: bloc,
        builder: (context, state) {
          if (bloc.addresses.isNotEmpty) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اعدادات العناوين الخاص بك',
                        style: context.mediumText.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'يمكنك إضافة عنوان جديد او حذف وعند الأضافة الجديدة سيمكنك ان تختار بينهم عندما تكون بطلب خدمة جديدة.',
                        style: context.lightText.copyWith(
                          fontSize: 12,
                          color: '#4D4D4D'.color,
                        ),
                      ),
                    ],
                  ).withPadding(horizontal: 20.w, vertical: 12.h),
                ),
                SliverList.builder(
                  itemCount: bloc.addresses.length,
                  itemBuilder: (context, index) {
                    final address = bloc.addresses[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: context.primaryColorLight,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomImage(
                                Assets.icons.home,
                                color: context.primaryColorDark,
                              ),
                              Expanded(
                                child: Text(
                                  address.name,
                                  style: context.semiboldText.copyWith(fontSize: 16),
                                ).withPadding(horizontal: 4.w),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     // Navigator.popUntil(
                              //     //   context,
                              //     //   (r) => r.settings.name == NamedRoutes.selectAddress,
                              //     // );
                              //   },
                              //   child: CustomImage(
                              //     Assets.icons.edit,
                              //     height: 24.h,
                              //     width: 24.h,
                              //   ),
                              // ),
                              // SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (v) {
                                      return const ConfirmDialog(
                                        title: 'خذف العنوان',
                                        subTitle: 'هل انت متاكد من خذف العنوان؟',
                                      );
                                    },
                                  ).then((v) {
                                    if (v == true) {
                                      bloc.deleteAddress(address);
                                    }
                                  });
                                },
                                child: CustomImage(
                                  Assets.icons.delete,
                                  height: 24.h,
                                  width: 24.h,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            address.districtName,
                            style: context.mediumText.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            address.fullAddress,
                            style: context.regularText.copyWith(fontSize: 14, color: '#A4A4A4'.color),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${LocaleKeys.the_type_of_place.tr()} : ${address.apartmentTypeName}",
                            style: context.regularText.copyWith(
                              fontSize: 14,
                              color: '#A4A4A4'.color,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${LocaleKeys.apartment_number.tr()} : ${address.apartmentNumber}",
                            style: context.regularText.copyWith(
                              fontSize: 14,
                              color: '#A4A4A4'.color,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${LocaleKeys.floor_number.tr()} : ${address.floorNumber}",
                            style: context.regularText.copyWith(
                              fontSize: 14,
                              color: '#A4A4A4'.color,
                            ),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state.getAddresses.isError) {
            return CustomErrorWidget(
              title: LocaleKeys.my_addresses.tr(),
              subtitle: state.msg,
            );
          } else if (state.getAddresses.isDone) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(Assets.images.emptyAddress),
                AppBtn(
                  onPressed: () => push(NamedRoutes.addAddress).then((value) {
                    if (value == true) {
                      bloc.getAddresses();
                    }
                  }),
                  icon: Icon(
                    Icons.add,
                    color: context.primaryColorLight,
                  ),
                  title: 'إضافة عنوان جديد',
                ).withPadding(horizontal: 56.w),
                SizedBox(height: context.padding.bottom + 90.h)
              ],
            );
          } else {
            return const LoadingApp();
          }
        },
      ),
    );
  }
}
