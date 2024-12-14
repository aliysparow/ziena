import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ziena/core/widgets/error_widget.dart';
import 'package:ziena/core/widgets/loading.dart';
import 'package:ziena/features/settings/cubit/settings_state.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../cubit/settings_cubit.dart';

class TermsConditionsView extends StatefulWidget {
  final String url;
  const TermsConditionsView({super.key, required this.url});

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {
  late final cubit = sl<SettingsCubit>()..getTerms(widget.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.terms_and_conditions_of_zina.tr(),
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.terms.isDone) {
            return ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                CustomImage(
                  Assets.images.logoAuth,
                  height: 96.h,
                  width: 96.h,
                ).center,
                SizedBox(height: 28.h),
                HtmlWidget(cubit.termsData),
              ],
            );
          } else if (state.terms.isError) {
            return CustomErrorWidget(
              title: LocaleKeys.terms_and_conditions_of_zina.tr(),
              subtitle: state.msg,
              errorStatus: state.errorType,
            );
          } else {
            return const LoadingApp();
          }
        },
      ),
    );
  }
}
