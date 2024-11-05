import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bloc = sl<HomeBloc>()
    ..getHourlyServiceList()
    ..getIndividualServiceList();

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leadingWidth: 80.w,
        title: Text(LocaleKeys.welcome_to_the_ziena.tr()),
        actions: [
          IconButton(
            onPressed: () => push(NamedRoutes.account),
            icon: CustomImage(
              Assets.icons.drawer,
              height: 32.h,
              width: 32.h,
            ),
          ).withPadding(horizontal: 12.w)
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 185.h,
            width: context.w,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => CustomImage(
                '',
                height: 185.h,
                width: context.w - 40.w,
                fit: BoxFit.cover,
                backgroundColor: '#D9D9D9'.color,
                borderRadius: BorderRadius.circular(20.r),
              ).withPadding(horizontal: 20.w),
            ),
          ).withPadding(vertical: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (i) => Expanded(
                child: Opacity(
                  opacity: selected != i ? .5 : 1,
                  child: GestureDetector(
                    onTap: () {
                      if (i == 2) return;
                      if (i == 1) return;
                      selected = i;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: context.primaryColorLight,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          if (selected == i) ...[
                            BoxShadow(
                              color: context.primaryColorDark.withOpacity(.1),
                              spreadRadius: -3.r,
                              blurRadius: 15.r,
                              offset: Offset(0, 10.h),
                            ),
                            BoxShadow(
                              color: context.primaryColorDark.withOpacity(.1),
                              spreadRadius: -4.r,
                              blurRadius: 6.r,
                              offset: Offset(0, 4.h),
                            ),
                          ]
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomImage(
                            [
                              Assets.images.hourService,
                              Assets.images.monthService,
                              Assets.images.bussniessService
                            ][i],
                            height: 40.h,
                            width: 40.w,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            [
                              LocaleKeys.hourly_service.tr(),
                              LocaleKeys.monthly_service.tr(),
                              LocaleKeys.bussniess_service.tr(),
                            ][i],
                            style: context.boldText.copyWith(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ).withPadding(vertical: 12.h),
          BlocBuilder<HomeBloc, HomeState>(
            bloc: bloc,
            builder: (context, state) {
              if (selected == 0) {
                if (bloc.hourlyServiceList.isNotEmpty) {
                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 18.w,
                      children:
                          List.generate(bloc.hourlyServiceList.length, (i) {
                        return GestureDetector(
                          onTap: () => push(NamedRoutes.hourlyService, arg: {
                            'id': bloc.hourlyServiceList[i].id,
                            'title': bloc.hourlyServiceList[i].name,
                          }),
                          child: SizedBox(
                            width: 142.w,
                            child: Column(
                              children: [
                                CustomImage(
                                  bloc.hourlyServiceList[i].icon,
                                  base46: true,
                                  height: 187.h,
                                  width: 142.w,
                                  fit: BoxFit.contain,
                                  backgroundColor: context.primaryColorLight,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                SizedBox(height: 14.h),
                                Text(
                                  bloc.hourlyServiceList[i].name,
                                  style:
                                      context.mediumText.copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                } else if (state.hourlyServicesState.isError) {
                  return CustomErrorWidget(
                    title: LocaleKeys.hourly_service.tr(),
                    subtitle: state.msg,
                  );
                } else if (state.hourlyServicesState.isLoading) {
                  return const LoadingApp().withPadding(vertical: 30.h);
                } else {
                  return const SizedBox.shrink();
                }
              } else {
                if (bloc.individualServicesList.isNotEmpty) {
                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 18.w,
                      children: List.generate(
                          bloc.individualServicesList.length, (i) {
                        return SizedBox(
                          width: 142.w,
                          child: Column(
                            children: [
                              CustomImage(
                                bloc.individualServicesList[i].icon,
                                base46: true,
                                height: 187.h,
                                width: 142.w,
                                fit: BoxFit.contain,
                                backgroundColor: context.primaryColorLight,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                bloc.individualServicesList[i].name,
                                style:
                                    context.mediumText.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                } else if (state.individualServicesState.isError) {
                  return CustomErrorWidget(
                    title: LocaleKeys.hourly_service.tr(),
                    subtitle: state.msg,
                  );
                } else if (state.individualServicesState.isLoading) {
                  return const LoadingApp().withPadding(vertical: 30.h);
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          ),
          Text(
            LocaleKeys.latest_offers.tr(),
            style: context.semiboldText.copyWith(fontSize: 18),
          ).withPadding(top: 12.h, horizontal: 20.w),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 18.w,
              children: List.generate(3, (i) {
                return SizedBox(
                  width: 192.w,
                  child: Column(
                    children: [
                      CustomImage(
                        'https://media.cdnandroid.com/item_images/490771/imagen-offerup-buy-sell-offer-up-0ori.jpg',
                        base46: true,
                        height: 187.h,
                        width: 192.w,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      SizedBox(height: 14.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'خصم 20%',
                              style: context.semiboldText.copyWith(
                                  fontSize: 14, color: context.primaryColor),
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: 'على العقود الشهرية لنظافة المنزل',
                              style:
                                  context.semiboldText.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
