import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/features/contracts_layoout/view/contracts_layout_view.dart';

import '../../home/view/home_view.dart';
import 'layout_state.dart';

class LayoutBloc extends Cubit<LayoutState> {
  LayoutBloc() : super(LayoutState());
  final phone = TextEditingController();

  int currentIndex = 0;
  Future<void> changeLayout(int index) async {
    currentIndex = index;
    emit(LayoutState());
  }

  Widget get currentPage => pages[currentIndex];

  List<Widget> pages = [
    const HomeView(),
    const ContractsLayoutView(),
  ];
}
