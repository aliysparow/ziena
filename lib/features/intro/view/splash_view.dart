import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/features/intro/widget/update_app_dialog.dart';
import 'package:ziena/main.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/user_model.dart';
import '../cubit/intro_cubit.dart';
import '../cubit/intro_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final completer = Completer();
  @override
  void initState() {
    UserModel.i.get();
    Timer(3.seconds, () {
      completer.complete();
    });
    super.initState();
  }

  final cubit = sl<IntroCubit>()..checkVertion();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IntroCubit, IntroState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.requestState.isDone) {
            completer.future.then((v) {
              if (!cubit.isValid) {
                showDialog(
                  barrierDismissible: false,
                  context: navigator.currentContext!,
                  builder: (context) => const UpdateAppDialog(),
                );
              } else if (UserModel.i.isAuth) {
                pushAndRemoveUntil(UserModel.i.userType.isDriver ? NamedRoutes.driverHome : NamedRoutes.layout);
              } else if (prefs.getBool('second') ?? false) {
                pushAndRemoveUntil(NamedRoutes.login);
              } else {
                pushAndRemoveUntil(NamedRoutes.onboarding);
              }
            });
          }
        },
        child: CustomImage(
          Assets.images.logo,
          height: 150.h,
          width: 150.h,
        ),
      ).center,
    );
  }
}
