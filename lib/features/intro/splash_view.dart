import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/main.dart';
import 'package:ziena/models/user.dart';

import '../../core/utils/extensions.dart';
import '../../core/widgets/custom_image.dart';
import '../../gen/assets.gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    UserModel.i.get();
    Timer(3.seconds, () {
      if (UserModel.i.isAuth) {
        pushAndRemoveUntil(NamedRoutes.layout);
      } else if (prefs.getBool('second') ?? false) {
        pushAndRemoveUntil(NamedRoutes.login);
      } else {
        pushAndRemoveUntil(NamedRoutes.onboarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomImage(
        Assets.images.logo,
        height: 150.h,
        width: 150.h,
      ).center,
    );
  }
}
