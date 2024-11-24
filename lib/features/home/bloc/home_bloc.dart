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
      hourlyServiceList = List<ServiceModel>.from((result.data['data'] ?? []).map((x) => ServiceModel.fromJson(x)));
      emit(state.copyWith(hourlyServicesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(hourlyServicesState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getIndividualServiceList() async {
    emit(state.copyWith(hourlyServicesState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.individualServices);
    if (result.success) {
      individualServicesList = List<ServiceModel>.from((result.data['data'] ?? []).map((x) => ServiceModel.fromJson(x)));
      emit(state.copyWith(hourlyServicesState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(hourlyServicesState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getOffers() async {
    emit(state.copyWith(offersState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getOffers);
    if (result.success) {
      offers = List<OfferModel>.from((result.data['data'] ?? []).map((x) => OfferModel.fromJson(x)));
      emit(state.copyWith(offersState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(offersState: RequestState.error, msg: result.msg));
    }
  }

  Future<void> getSliders() async {
    emit(state.copyWith(slidersState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getOffersInBaner);
    if (result.success) {
      sliders = List<SliderModel>.from((result.data['data'] ?? []).map((x) => SliderModel.fromJson(x)));
      emit(state.copyWith(slidersState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(slidersState: RequestState.error, msg: result.msg));
    }
  }
}
