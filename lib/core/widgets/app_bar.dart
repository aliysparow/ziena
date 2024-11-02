import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool withBack;
  final Widget? suffixIcon;

  const CustomAppBar({super.key, this.title = '', this.withBack = true, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.secondaryColor,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Container(
          height: 50.h,
          color: context.primaryContainer,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (withBack)
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Icon(
                        CupertinoIcons.back,
                        size: 24.r,
                        color: context.primaryColorDark,
                      ),
                    ),
                  ).toStart,
                ),
              Text(
                title,
                style: context.theme?.appBarTheme.titleTextStyle,
              ),
              if (withBack && suffixIcon == null)
                Expanded(
                  child: SizedBox(
                    height: 24.r,
                    width: 24.r,
                  ),
                ),
              if (suffixIcon != null) Expanded(child: suffixIcon!.toEnd)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 30.h);
}
