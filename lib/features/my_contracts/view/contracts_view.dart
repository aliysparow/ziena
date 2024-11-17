import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/features/my_contracts/widgets/content_item.dart';
import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/error_widget.dart';
import '../bloc/contracts_state.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/contracts_cubit.dart';

class ContractsView extends StatefulWidget {
  final ContractType type;
  const ContractsView({super.key, required this.type});

  @override
  State<ContractsView> createState() => _ContractsViewState();
}

class _ContractsViewState extends State<ContractsView> {
  late final cubit = sl<ContractsCubit>()..getContracts(widget.type);
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
        builder: (contrxt, state) {
          if (cubit.contracts.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: cubit.contracts.length,
              itemBuilder: (context, index) {
                final item = cubit.contracts[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: context.primaryColorLight,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: item.statusColor.color),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 12.h,
                            color: item.statusColor.color,
                          ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ContentItem(
                            icon: Assets.icons.hashtag,
                            title: item.contractNumber,
                          ),
                          ContentItem(
                            icon: Assets.icons.time,
                            title: DateFormat('dd/MM/yyyy').format(item.startDate),
                          ),
                        ],
                      ).withPadding(vertical: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ContentItem(
                            icon: Assets.icons.work,
                            title: LocaleKeys.val_visit_val_week.tr(args: ["${item.totalVisits}", "${item.numberOfWeeks}"]),
                          ),
                          ContentItem(
                            icon: Assets.icons.price,
                            title: "${item.finalPrice} ${LocaleKeys.sar.tr()}",
                          ),
                        ],
                      ).withPadding(vertical: 4.h),
                      ContentItem(
                        icon: Assets.icons.contract,
                        title: item.allowPay ? LocaleKeys.payment_not_made.tr() : LocaleKeys.the_contract_has_been_paid.tr(),
                        color: context.primaryColor,
                      ).withPadding(vertical: 4.h),
                      SizedBox(height: 4.h),
                      if (item.allowPay)
                        GestureDetector(
                          onTap: () {
                            push(
                              NamedRoutes.paymentIfream,
                              arg: {"id": item.id},
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.primaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.pay_now.tr(),
                              style: context.semiboldText.copyWith(fontSize: 12, color: context.primaryColorLight),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else if (state.contractState.isDone) {
            return CustomErrorWidget(
              title: widget.type.name,
              subtitle: LocaleKeys.you_do_not_have_any_contracts_yet.tr(),
            );
          } else if (state.contractState.isError) {
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
