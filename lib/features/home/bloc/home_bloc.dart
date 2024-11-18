import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../models/offer_model.dart';
import '../../../models/service_model.dart';
import '../../../models/slider_model.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState());

  List<ServiceModel> individualServicesList = [];
  List<ServiceModel> hourlyServiceList = [];
  List<OfferModel> offers = [];
  List<SliderModel> sliders = [];

  Future<void> getHourlyServiceList() async {
    emit(state.copyWith(hourlyServicesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.hourlyServices);
    if (result.success) {
      hourlyServiceList = result.data['data'].map<ServiceModel>((e) => ServiceModel.fromJson(e)).toList();
      emit(state.copyWith(hourlyServicesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(hourlyServicesState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getIndividualServiceList() async {
    emit(state.copyWith(hourlyServicesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.individualServices);
    if (result.success) {
      individualServicesList = result.data['data'].map<ServiceModel>((e) => ServiceModel.fromJson(e)).toList();
      emit(state.copyWith(hourlyServicesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(hourlyServicesState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getOffers() async {
    emit(state.copyWith(offersState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getOffers);
    if (result.success) {
      offers = result.data['data'].map<OfferModel>((e) => OfferModel.fromJson(e)).toList();
      emit(state.copyWith(offersState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(offersState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getSliders() async {
    emit(state.copyWith(slidersState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getOffersInBaner);
    if (result.success) {
      sliders = result.data['data'].map<SliderModel>((e) => SliderModel.fromJson(e)).toList();
      emit(state.copyWith(slidersState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(slidersState: RequestState.error, msg: result.msg));
    }
  }
}
