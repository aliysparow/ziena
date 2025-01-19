import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/routes/app_routes_fun.dart';
import 'package:ziena/core/routes/routes.dart';
import 'package:ziena/features/my_contracts/view/contracts_layout_view.dart';
import 'package:ziena/models/user_model.dart';

import '../../home/view/home_view.dart';
import 'layout_state.dart';

class LayoutBloc extends Cubit<LayoutState> {
  LayoutBloc() : super(LayoutState());
  final phone = TextEditingController();

  int currentIndex = 0;
  Future<void> changeLayout(int index) async {
    if (UserModel.i.isAuth) {
      currentIndex = index;
      emit(LayoutState());
    } else {
      push(NamedRoutes.login, arg: {
        'call_back': () {
          currentIndex = index;
          emit(LayoutState());
        }
      });
    }
  }

  Widget get currentPage => pages[currentIndex];

  List<Widget> pages = [
    const HomeView(),
    const ContractsLayoutView(),
  ];
}
