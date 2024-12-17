import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/server_gate.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/enums.dart';
import '../../models/nationality_model.dart';
import 'nationalities_state.dart';

class NationalitiesBloc extends Cubit<NationalitiesState> {
  NationalitiesBloc() : super(NationalitiesState());

  List<NationalityModel> nationalities = [];

  Future<void> getNationalities() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getAllCountries);
    if (result.success) {
      nationalities = List<NationalityModel>.from(result.data['data'].map((x) => NationalityModel.fromJson(x)));
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }
}
