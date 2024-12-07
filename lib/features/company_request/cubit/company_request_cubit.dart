import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/models/user_model.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../models/nationality_model.dart';
import '../../../models/profession_model.dart';
import 'company_request_state.dart';

class CompanyRequestCubit extends Cubit<CompanyRequestState> {
  CompanyRequestCubit() : super(CompanyRequestState());

  List<NationalityModel> countries = [];
  List<ProfessionModel> professions = [];

  final name = TextEditingController(text: '${UserModel.i.firstName} ${UserModel.i.lastName}');
  final mobile = TextEditingController(text: UserModel.i.phone);
  final notes = TextEditingController();
  NationalityModel? nationality;
  ProfessionModel? profession;

  getAllCountries() async {
    emit(state.copyWith(nationalityState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getAllCountries);
    if (result.success) {
      countries = List<NationalityModel>.from((result.data['data'] ?? []).map((x) => NationalityModel.fromJson(x)));
      emit(state.copyWith(nationalityState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(nationalityState: RequestState.error, msg: result.msg));
    }
  }

  getAllProfessions() async {
    emit(state.copyWith(professionsState: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getAllProfessions);
    if (result.success) {
      professions = List<ProfessionModel>.from((result.data['data'] ?? []).map((x) => ProfessionModel.fromJson(x)));
      emit(state.copyWith(professionsState: RequestState.done, msg: result.msg));
    } else {
      emit(state.copyWith(professionsState: RequestState.error, msg: result.msg));
    }
  }

  createCorporateReq() async {
    emit(state.copyWith(createCorporateReq: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.createCorporateReq, body: {
      "Nationality": nationality?.id,
      "Profession": nationality?.id,
      "Id": UserModel.i.id,
      "FullName": name.text,
      "Mobile": mobile.text,
      "Notes": notes.text,
      "ReqNumber": "0",
      "ReqSource": "2",
    });
    if (result.success) {
      emit(state.copyWith(createCorporateReq: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(createCorporateReq: RequestState.error, msg: result.msg));
    }
  }
}
