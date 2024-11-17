import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/utils/enums.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../models/service_model.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState());

  List<ServiceModel> individualServicesList = [];
  List<ServiceModel> hourlyServiceList = [];

  Future<void> getHourlyServiceList() async {
    emit(state.copyWith(hourlyServicesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: AppConstants.hourlyServices);
    if (result.success) {
      hourlyServiceList = result.data['data'].map<ServiceModel>((e) => ServiceModel.fromJson(e)).toList();
      emit(state.copyWith(hourlyServicesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(hourlyServicesState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getIndividualServiceList() async {
    emit(state.copyWith(hourlyServicesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: AppConstants.individualServices);
    if (result.success) {
      individualServicesList = result.data['data'].map<ServiceModel>((e) => ServiceModel.fromJson(e)).toList();
      emit(state.copyWith(hourlyServicesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(hourlyServicesState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getOffers() async {
    emit(state.copyWith(sliderAndOffersState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: AppConstants.getOffers);
    if (result.success) {
      // individualServicesList = result.data['data'].map<ServiceModel>((e) => ServiceModel.fromJson(e)).toList();
      emit(state.copyWith(sliderAndOffersState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(sliderAndOffersState: RequestState.error, msg: result.msg));
    }
  }
}
