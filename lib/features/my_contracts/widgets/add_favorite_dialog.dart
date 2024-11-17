import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/features/my_contracts/bloc/contracts_cubit.dart';
import 'package:ziena/features/my_contracts/bloc/contracts_state.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';

class AddFavoriteDialog extends StatefulWidget {
  final String workId;
  const AddFavoriteDialog({super.key, required this.workId});

  @override
  State<AddFavoriteDialog> createState() => _AddFavoriteDialogState();
}

class _AddFavoriteDialogState extends State<AddFavoriteDialog> {
  final cubit = sl<ContractsCubit>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            Assets.icons.favorite,
            height: 58.h,
            width: 58.h,
          ),
          SizedBox(height: 24.h),
          Text(
            'هل تريد اضافة هذه الخدمة الي المفضلة لديك؟',
            style: context.semiboldText.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            "عندما تقوم بالاجابة ستكون هذه الخدمة متاحة لديك في العقود، لكي نسهل عليك طلبها مرة اخري.",
            style: context.mediumText.copyWith(fontSize: 12, color: '#11334280'.color.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<ContractsCubit, ContractsState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state.setFavoriteLaborState.isDone) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      cubit.setFavoriteLabor(workerId: widget.workId);
                    },
                    child: Container(
                      height: 48.h,
                      width: 140.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: context.primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "أضف للمفضلة",
                        style: context.mediumText.copyWith(fontSize: 16, color: context.primaryColorLight),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 24.w),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: context.hintColor),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "لا",
                    style: context.mediumText.copyWith(fontSize: 16, color: '#BBBBBB'.color),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ).withPadding(horizontal: 20.w, vertical: 24.h),
    );
  }
}
