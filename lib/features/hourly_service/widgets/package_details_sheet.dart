import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/app_btn.dart';
import 'package:ziena/core/widgets/app_sheet.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/gen/assets.gen.dart';
import 'package:ziena/gen/locale_keys.g.dart';
import 'package:ziena/models/hourly_package_model.dart';

class HourlyPackageDetailsSheet extends StatelessWidget {
  final HourlyPackageModel item;
  final Function()? onTap;
  const HourlyPackageDetailsSheet({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppSheet(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.h,
              child: Column(
                children: [
                  CustomImage(
                    Assets.images.hourService,
                    height: 24.h,
                    width: 24.h,
                  ),
                  Text(
                    LocaleKeys.hourly_service.tr(),
                    style: context.boldText.copyWith(fontSize: 8),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              item.title,
              style: context.semiboldText.copyWith(fontSize: 15),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...List.generate(
          6,
          (i) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                [
                  'عدد الزيارات',
                  "عدد الأسابيع",
                  "عدد ساعات العمل",
                  "الفترة الزمنية",
                  // "السعر قبل الخصم",
                  // "السعر بعد الخصم",
                  "سعر الباقة",
                  "ضريبة القيمة المضافة",
                ][i],
                style: context.boldText
                    .copyWith(fontSize: 15, color: '#8E8E8E'.color),
              ),
              Text(
                [
                  '${item.totalVisits} زيارات',
                  "${item.visitNumberPerWeek} اسبوع",
                  "${item.totalHours} ساعات",
                  item.shiftName,
                  // "${item.initialPrice} ${LocaleKeys.sar.tr()}",
                  "${item.priceAfterDiscountWithoutVat} ${LocaleKeys.sar.tr()}",
                  "${item.vat} ${LocaleKeys.sar.tr()}",
                ][i],
                style: context.boldText
                    .copyWith(fontSize: 15, color: '#8E8E8E'.color),
              ),
            ],
          ).withPadding(vertical: 12.h, horizontal: 32.w),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'السعر الإجمالي',
              style: context.boldText.copyWith(fontSize: 18),
            ),
            Text(
              "${item.finalPrice} ${LocaleKeys.sar.tr()}",
              style: context.boldText.copyWith(fontSize: 18),
            ),
          ],
        ).withPadding(vertical: 22.h, horizontal: 32.w),
        AppBtn(
          onPressed: onTap,
          title: LocaleKeys.subscribe.tr(),
          backgroundColor: context.indicatorColor,
        ).withPadding(vertical: 20.h, horizontal: 20.w),
      ],
    );
  }
}
