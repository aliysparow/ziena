import 'package:bloc/bloc.dart';
import 'package:ziena/models/individaul_package_model.dart';
import 'package:ziena/models/user_model.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import 'individual_packages_state.dart';

class IndividualPackagesCubit extends Cubit<IndividualPackagesState> {
  IndividualPackagesCubit() : super(IndividualPackagesState());

  List<IndividaulPackageModel> packages = [];
  Future<void> getPackages(String id) async {
    emit(state.copyWith(getPackages: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.getIndividualPackages,
      params: {"serviceId": id},
    );
    if (result.success) {
      packages = List<IndividaulPackageModel>.from((result.data['data'] ?? []).map((x) => IndividaulPackageModel.fromJson(x)));
      emit(state.copyWith(getPackages: RequestState.done));
    } else {
      emit(state.copyWith(getPackages: RequestState.error, msg: result.msg));
    }
  }

  Future<void> createIndividualRequest(IndividaulPackageModel package) async {
    emit(state.copyWith(createIndividualRequest: RequestState.loading));
    final result = await ServerGate.i.getFromServer(
      url: ApiConstants.createIndividualRequest,
      params: {
        "Contact": UserModel.i.id,
        "PriceDetails": package,
        "Id": "981bda21-9294-ef11-8bcd-20040ff72aa5",
        "ReqSource": "2",
        "FullName": "",
        "Mobile": "0505050502",
        "Notes": "qwewqe qewqeweqw qewewqqew"
      },
    );
    if (result.success) {
      // packages = List<IndividaulPackageModel>.from((result.data['data'] ?? []).map((x) => IndividaulPackageModel.fromJson(x)));
      emit(state.copyWith(createIndividualRequest: RequestState.done));
    } else {
      emit(state.copyWith(createIndividualRequest: RequestState.error, msg: result.msg));
    }
  }
}
