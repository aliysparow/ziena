import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/services/server_gate.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/models/city_model.dart';

import 'cities_state.dart';

class CitiesBloc extends Cubit<CitiesState> {
  CitiesBloc() : super(CitiesState());

  List<CityModel> cities = [];

  Future<void> getCities() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: AppConstants.cities);
    if (result.success) {
      cities = List<CityModel>.from(result.data['data'].map((x) => CityModel.fromJson(x)));
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }
}
