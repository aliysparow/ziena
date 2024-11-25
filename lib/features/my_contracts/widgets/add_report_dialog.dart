import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../bloc/contracts_cubit.dart';
import '../bloc/contracts_state.dart';

class AddReportDialog extends StatefulWidget {
  final String workId;
  const AddReportDialog({super.key, required this.workId});

  @override
  State<AddReportDialog> createState() => _AddReportDialogState();
}

class _AddReportDialogState extends State<AddReportDialog> {
  final cubit = sl<ContractsCubit>();
  final note = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            Assets.icons.block,
            height: 58.h,
            width: 58.h,
          ),
          SizedBox(height: 24.h),
          Text(
            LocaleKeys.why_block_worker.tr(),
            style: context.semiboldText.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            LocaleKeys.please_answer_do_not_close.tr(),
            style: context.mediumText.copyWith(fontSize: 12, color: '#11334280'.color.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Form(
            key: key,
            child: AppField(
              controller: note,
              hintText: LocaleKeys.write_your_complaint.tr(),
              maxLines: 2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: context.primaryColorDark,
                  width: 0.5.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<ContractsCubit, ContractsState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state.blockLaborState.isDone) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      cubit.blockLabor(workerId: widget.workId, note: note.text);
                    },
                    child: Container(
                      height: 48.h,
                      width: 75.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: '#D00416'.color,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.block.tr(),
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
                  width: 75.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: context.hintColor),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.back.tr(),
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
