import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/core/widgets/custom_grid.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/core/widgets/loading.dart';
import 'package:ziena/features/my_contracts/widgets/content_item.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/contracts_cubit.dart';
import '../cubit/contracts_state.dart';

class MyOrdersView extends StatefulWidget {
  final OrdersType type;

  const MyOrdersView({super.key, required this.type});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  late final cubit = sl<ContractsCubit>()..getOrders(widget.type);
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
        builder: (context, state) {
          if (cubit.orders.isNotEmpty) {
            return CustomGrid(
              itemCount: cubit.orders.length,
              crossCount: 2,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              itemPadding: EdgeInsets.all(6.w),
              itemBuilder: (context, index) {
                final item = cubit.orders[index];
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
                        title: item.requestNumber,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.phone,
                        title: item.mobile,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.time,
                        title: item.requestDate,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.status,
                        title: item.statusCodeName,
                        color: item.statusColor.color,
                      ),
                      ContentItem(
                        padding: EdgeInsets.all(6.w),
                        mainAxisAlignment: MainAxisAlignment.start,
                        icon: Assets.icons.note,
                        title: item.notes,
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state.ordersState.isError) {
            return CustomErrorWidget(
              title: widget.type.name,
              subtitle: state.msg,
              errorStatus: state.errorType,
            );
          } else if (state.ordersState.isDone) {
            return CustomErrorWidget(
              title: widget.type.name,
              subtitle: LocaleKeys.there_are_no_orders.tr(),
              errorStatus: ErrorType.empty,
            );
          } else {
            return const LoadingApp();
          }
        },
      ).center,
    );
  }
}
