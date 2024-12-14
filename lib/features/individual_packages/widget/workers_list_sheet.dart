import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/worker_model.dart';
import 'worker_details_sheet.dart';

class WorkersListSheet extends StatefulWidget {
  final List<WorkerModel> workers;
  final WorkerModel? selected;
  const WorkersListSheet({super.key, required this.workers, this.selected});

  @override
  State<WorkersListSheet> createState() => _WorkersListSheetState();
}

class _WorkersListSheetState extends State<WorkersListSheet> {
  late WorkerModel? selected = widget.selected;
  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: LocaleKeys.choose_the_right_worker_for_you.tr(),
      children: [
        ...List.generate(
          widget.workers.length,
          (index) {
            final item = widget.workers[index];
            return Row(
              children: [
                CustomImage(
                  item.icon,
                  height: 50.h,
                  width: 50.h,
                  borderRadius: BorderRadius.circular(100),
                ),
                Expanded(
                  child: Text(
                    item.name,
                    style: context.semiboldText.copyWith(
                      fontSize: 16,
                      fontWeight: item == selected ? null : FontWeight.w300,
                    ),
                  ).withPadding(horizontal: 8.w),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      barrierColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => WorkerDetailsSheet(item: item),
                    );
                  },
                  child: Text(
                    LocaleKeys.details.tr(),
                    style: context.lightText.copyWith(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: context.primaryColorDark,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  height: 18.h,
                  width: 18.h,
                  child: Radio(
                    value: item,
                    groupValue: selected,
                    onChanged: (value) {
                      Navigator.pop(context, value);
                    },
                  ),
                ),
              ],
            ).withPadding(vertical: 12.h);
          },
        ),
        const SafeArea(child: SizedBox())
      ],
    );
  }
}
