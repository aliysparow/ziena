import 'package:bloc/bloc.dart';
import 'package:ziena/core/widgets/flash_helper.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../models/individaul_package_model.dart';
import '../../../models/user_model.dart';
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

  Future<void> createIndividualRequest(IndividaulPackageModel package, String name, String phone, String note) async {
    emit(state.copyWith(createIndividualRequest: RequestState.loading));
    final result = await ServerGate.i.sendToServer(
      url: ApiConstants.createIndividualRequest,
      body: {
        "Contact": UserModel.i.contactId,
        "PriceDetails": package.id,
        "Id": UserModel.i.id,
        "ReqSource": "2",
        "FullName": name,
        "Mobile": phone,
        "Notes": note,
      },
    );
    if (result.success) {
      // packages = List<IndividaulPackageModel>.from((result.data['data'] ?? []).map((x) => IndividaulPackageModel.fromJson(x)));
      emit(state.copyWith(createIndividualRequest: RequestState.done));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(createIndividualRequest: RequestState.error, msg: result.msg));
    }
  }
}
