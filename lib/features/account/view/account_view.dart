import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ziena/core/services/service_locator.dart';
import 'package:ziena/core/widgets/confirm_dialog.dart';
import 'package:ziena/features/account/cubit/account_cubit.dart';
import 'package:ziena/features/account/cubit/account_state.dart';
import 'package:ziena/features/account/widgets/change_lang_sheet.dart';

import '../../../core/routes/app_routes_fun.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_circle_icon.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/locale_keys.g.dart';
import '../../../models/user_model.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final cubit = sl<AccountCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.scaffoldBackgroundColor,
        toolbarHeight: kToolbarHeight + 120.h,
        leading: CustomRadiusIcon(
          onTap: () => Navigator.pop(context),
          size: 40.w,
          backgroundColor: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          borderColor: context.hoverColor,
          child: Icon(
            CupertinoIcons.back,
            size: 24.h,
            color: context.primaryColor,
          ),
        ).toTopEnd,
        title: CustomImage(
          Assets.images.logoAuth,
          height: 115.h,
          width: 115.h,
        ),
      ),
      body: ListView(
        children: [
          // ListTile(
          //   leading: CustomImage(Assets.icons.profile, height: 24.h, width: 24.h),
          //   title: Text(
          //     LocaleKeys.profile_settings.tr(),
          //     style: context.mediumText.copyWith(fontSize: 16),
          //   ),
          // ),
          if (UserModel.i.userType.isClient)
            ListTile(
              onTap: () => push(NamedRoutes.addresses),
              leading: CustomImage(Assets.icons.addresses, height: 24.h, width: 24.h),
              title: Text(
                LocaleKeys.my_addresses.tr(),
                style: context.mediumText.copyWith(fontSize: 16),
              ),
            ),
          // ListTile(
          //   leading: CustomImage(Assets.icons.lock, height: 24.h, width: 24.h),
          //   title: Text(
          //     LocaleKeys.change_password.tr(),
          //     style: context.mediumText.copyWith(fontSize: 16),
          //   ),
          // ),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const SelectLanguageSheet(),
              );
            },
            leading: CustomImage(Assets.icons.lang, height: 24.h, width: 24.h),
            title: Text(
              LocaleKeys.app_language.tr(),
              style: context.mediumText.copyWith(fontSize: 16),
            ),
          ),
          // ListTile(
          //   leading: CustomImage(Assets.icons.support, height: 24.h, width: 24.h),
          //   title: Text(
          //     LocaleKeys.contact_support.tr(),
          //     style: context.mediumText.copyWith(fontSize: 16),
          //   ),
          // ),
          ListTile(
            onTap: () {
              Share.share(AppConstants.shareAppText);
            },
            leading: CustomImage(Assets.icons.share, height: 24.h, width: 24.h),
            title: Text(
              LocaleKeys.share_app.tr(),
              style: context.mediumText.copyWith(fontSize: 16),
            ),
          ),
          ListTile(
            onTap: () {
              UserModel.i.clear();
              pushAndRemoveUntil(NamedRoutes.login);
            },
            leading: CustomImage(Assets.icons.logout, height: 24.h, width: 24.h),
            title: Text(
              LocaleKeys.logout.tr(),
              style: context.mediumText.copyWith(fontSize: 16, color: context.errorColor),
            ),
          ),
          BlocConsumer<AccountCubit, AccountState>(
            bloc: cubit,
            buildWhen: (previous, current) => previous.deleteAccount != current.deleteAccount,
            listenWhen: (previous, current) => previous.deleteAccount != current.deleteAccount,
            listener: (context, state) {
              if (state.deleteAccount.isDone) {
                pushAndRemoveUntil(NamedRoutes.login);
              }
              // 542318760
              // 10203040
            },
            builder: (context, state) {
              return ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (c) => ConfirmDialog(
                      title: LocaleKeys.delete_account.tr(),
                      subTitle: LocaleKeys.are_you_sure_to_delete_account.tr(),
                    ),
                  ).then((v) {
                    if (v == true) {
                      cubit.deleteAccount();
                    }
                  });
                },
                leading: CustomImage(Assets.icons.delete, height: 24.h, width: 24.h),
                title: Text(
                  LocaleKeys.delete_account.tr(),
                  style: context.mediumText.copyWith(fontSize: 16, color: context.errorColor),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
