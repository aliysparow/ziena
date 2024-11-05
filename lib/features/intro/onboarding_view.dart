import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/main.dart';

import '../../core/utils/extensions.dart';
import '../../core/widgets/app_btn.dart';
import '../../core/widgets/custom_image.dart';
import '../../gen/locale_keys.g.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentIndex = 0;
  final colors = ['#FFBC0F', '#113342', '#00A585'];

  final controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView.builder(
        controller: controller,
        itemCount: 3,
        onPageChanged: (value) => setState(() => currentIndex = value),
        itemBuilder: (context, index) {
          return CustomImage(
            'assets/images/onboarding${index + 1}.png',
            height: context.h,
            width: context.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                CustomImage(
                  'assets/images/onboardinglogo${index + 1}.png',
                  height: 175.h,
                  width: 175.h,
                ),
                SizedBox(height: 50.h),
                Text(
                  ['خدمات الساعة', 'الخدمات الشهرية', 'خدمات الأعمال'][index],
                  style: context.boldText.copyWith(
                    fontSize: 24,
                    color: colors[index].color,
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  [
                    'نوفر لك خدمة ممتازة بالساعة اذا كنت تحتاج الي عامل لوقت معين من اليوم',
                    'نوفر لك خدمة ممتازة بالشهر اذا كنت تحتاج الي عامل لوقت معين من اليوم',
                    'نوفر لك خدمة ممتازة بالشهر اذا كنت تحتاج الي عامل لوقت معين من اليوم'
                  ][index],
                  textAlign: TextAlign.center,
                  style: context.regularText
                      .copyWith(fontSize: 16, color: '#666666'.color),
                )
              ],
            ).withPadding(horizontal: 35.w),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              children: List.generate(
                3,
                (i) => Icon(
                  Icons.circle,
                  size: 10.h,
                  color: colors[currentIndex]
                      .color
                      .withOpacity(i == currentIndex ? 1 : 0.5),
                ).withPadding(horizontal: 3.w),
              ),
            ),
            AppBtn(
              onPressed: () {
                if (currentIndex == 2) {
                  prefs.setBool('second', true);
                  pushAndRemoveUntil(NamedRoutes.login);
                } else {
                  controller.animateToPage(
                    currentIndex + 1,
                    duration: 200.milliseconds,
                    curve: Curves.ease,
                  );
                }
              },
              saveArea: false,
              backgroundColor: colors[currentIndex].color,
              title: currentIndex == 2
                  ? LocaleKeys.home.tr()
                  : LocaleKeys.next.tr(),
            ).withPadding(top: 16.h, bottom: 12.h),
            Opacity(
              opacity: currentIndex == 2 ? 0 : 1,
              child: TextButton(
                onPressed: () {
                  if (currentIndex != 2) {
                    prefs.setBool('second', true);
                    pushAndRemoveUntil(NamedRoutes.login);
                  }
                },
                child: Text(
                  'تخطي',
                  style: context.mediumText.copyWith(fontSize: 14),
                ),
              ),
            ),
          ],
        ).withPadding(horizontal: 20.w),
      ),
    );
  }
}
