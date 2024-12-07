import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/features/individual_packages/cubit/individual_packages_cubit.dart';
import 'package:ziena/features/individual_packages/cubit/individual_packages_state.dart';
import 'package:ziena/models/user_model.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/widgets/app_btn.dart';
import '../../../core/widgets/app_field.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/individaul_package_model.dart';

class IndividualRequestView extends StatefulWidget {
  final String title;
  final IndividaulPackageModel package;
  const IndividualRequestView({super.key, required this.title, required this.package});

  @override
  State<IndividualRequestView> createState() => _IndividualRequestViewState();
}

class _IndividualRequestViewState extends State<IndividualRequestView> {
  final cubit = sl<IndividualPackagesCubit>();
  final name = TextEditingController(text: '${UserModel.i.firstName} ${UserModel.i.lastName}');
  final phone = TextEditingController(text: UserModel.i.phone);
  final note = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(
          widget.title,
          style: context.regularText.copyWith(fontSize: 16, color: '#9F9C9C'.color),
        ),
        titleSpacing: 0,
        leading: IconButton(
          color: '#9F9C9C'.color,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImage(
                    Assets.images.hourService,
                    height: 20.h,
                    width: 20.h,
                  ).withPadding(end: 8.w),
                  Text(
                    widget.package.title,
                    style: context.mediumText.copyWith(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.hourly_request_msg.tr(),
                style: context.lightText.copyWith(
                  fontSize: 12,
                  color: '#4D4D4D'.color,
                ),
              ),
              SizedBox(height: 20.h),
              AppField(
                controller: name,
                hintText: LocaleKeys.full_name.tr(),
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 16.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: AppField(
                  keyboardType: TextInputType.phone,
                  controller: phone,
                  hintText: LocaleKeys.full_name.tr(),
                  prefixIcon: SizedBox(
                    width: 70.w,
                    child: Text(
                      '+966',
                      style: context.semiboldText,
                    ).center,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              AppField(
                controller: note,
                hintText: LocaleKeys.add_note.tr(),
                maxLines: 4,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<IndividualPackagesCubit, IndividualPackagesState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.createIndividualRequest.isDone) {
            push(NamedRoutes.successfullyPage, arg: {
              "image": Assets.images.successfully,
              "title": LocaleKeys.your_order_has_been_sent.tr(),
              "subtitle": LocaleKeys.we_will_review_the_assignment_and_contact_you_on_your_mobile_number.tr(),
              "btnTitle": LocaleKeys.close.tr(),
              "onTap": () => Navigator.popUntil(context, (route) => route.isFirst),
            });
          }
        },
        builder: (context, state) {
          return AppBtn(
            loading: state.createIndividualRequest.isLoading,
            title: LocaleKeys.confirm_data.tr(),
            onPressed: () {
              if (form.isValid) cubit.createIndividualRequest(widget.package, name.text, phone.text, note.text);
            },
          );
        },
      ).withPadding(horizontal: 50.w, vertical: 10.h),
    );
  }
}
