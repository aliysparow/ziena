import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/widgets/app_field.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_sheet.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../cubit/contracts_cubit.dart';
import '../cubit/contracts_state.dart';

class RateSheet extends StatefulWidget {
  final String visitId;
  const RateSheet({super.key, required this.visitId});

  @override
  State<RateSheet> createState() => _RateSheetState();
}

class _RateSheetState extends State<RateSheet> {
  final note = TextEditingController();
  final cubit = sl<ContractsCubit>();
  final key = GlobalKey<FormState>();
  double rate = 4;
  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      title: LocaleKeys.how_was_our_service_experience.tr(),
      children: [
        SizedBox(height: 32.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: RatingBar.builder(
            initialRating: rate,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 24.h,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
            itemBuilder: (context, _) => CustomImage(
              Assets.icons.star,
              color: Colors.amber,
            ).center,
            onRatingUpdate: (rating) {
              rate = rating;
            },
          ),
        ).center,
        SizedBox(height: 22.h),
        Form(
          key: key,
          child: AppField(
            controller: note,
            hintText: LocaleKeys.note.tr(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
          ),
        ),
        SizedBox(height: 22.h),
        BlocConsumer<ContractsCubit, ContractsState>(
          bloc: cubit,
          listener: (context, state) {
            if (state.visitsState.isDone) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return AppBtn(
              onPressed: () {
                cubit.rateVisit(
                  visitId: widget.visitId,
                  rate: rate,
                  rateNotes: note.text,
                );
              },
              saveArea: false,
              width: 250.w,
              height: 44.h,
              title: LocaleKeys.rate_now.tr(),
            );
          },
        ).center,
        SizedBox(height: 16.h),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            LocaleKeys.no_thanks.tr(),
            style: context.regularText.copyWith(fontSize: 14, color: '#A1A1AA'.color),
          ),
        ).center,
        SizedBox(height: 20.h),
      ],
    );
  }
}
