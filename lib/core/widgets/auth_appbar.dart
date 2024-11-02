import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/utils/extensions.dart';
import 'package:ziena/core/widgets/custom_circle_icon.dart';
import 'package:ziena/core/widgets/custom_image.dart';
import 'package:ziena/gen/assets.gen.dart';

class AuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool withBack;
  const AuthAppbar({super.key, this.withBack = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomImage(
        Assets.images.logoAuth,
        height: 100.h,
        width: 100.h,
      ),
      centerTitle: true,
      toolbarHeight: kToolbarHeight + 100.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leadingWidth: 56.w,
      leading: (() {
        if (withBack) {
          return CustomRadiusIcon(
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
          ).toTopEnd;
        }
      })(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 100.h);
}
