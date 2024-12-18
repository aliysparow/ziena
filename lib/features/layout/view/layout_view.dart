import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/gen/assets.gen.dart';
import 'package:ziena/gen/locale_keys.g.dart';

import '../../../core/services/service_locator.dart';
import '../bloc/layout_bloc.dart';
import '../bloc/layout_state.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  final bloc = sl<LayoutBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     push(NamedRoutes.paymentIfream, arg: {
      //       'id': 'bbbceb9d-bd65-4e92-8872-9146d8d53932',
      //     });
      //   },
      //   child: CustomImage(
      //     Assets.icons.homeActive,
      //     height: 24.h,
      //     width: 24.h,
      //     color: context.primaryColor,
      //   ),
      // ),
      body: BlocBuilder<LayoutBloc, LayoutState>(
        bloc: bloc,
        builder: (context, state) => bloc.currentPage,
      ),
      bottomNavigationBar: BlocBuilder<LayoutBloc, LayoutState>(
        bloc: bloc,
        builder: (context, state) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: context.primaryColorLight,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      2,
                      (i) => GestureDetector(
                        onTap: () => bloc.changeLayout(i),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: const BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImage(
                                [Assets.icons.homeActive, Assets.icons.orders][i],
                                height: 24.h,
                                width: 24.h,
                                color: bloc.currentIndex == i ? context.primaryColor : context.hintColor,
                              ),
                              if (bloc.currentIndex == i) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  [LocaleKeys.home.tr(), LocaleKeys.orders.tr()][i],
                                  style: context.semiboldText.copyWith(
                                    fontSize: 10,
                                    color: bloc.currentIndex == i ? context.primaryColor : context.hintColor,
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).withPadding(vertical: 12.h),
          );
        },
      ),
    );
  }
}
