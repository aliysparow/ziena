import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziena/core/widgets/select_item_sheet.dart';

import '../../../core/services/server_gate.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/flash_helper.dart';
import '../../../core/widgets/loading.dart';
import '../../../models/user_model.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState());

  deleteAccount() async {
    LoadingDialog.show();
    emit(state.copyWith(deleteAccount: RequestState.loading));
    final result = await ServerGate.i.deleteFromServer(
      url: ApiConstants.deleteAccount,
      params: {'UserId': UserModel.i.id},
    );
    LoadingDialog.hide();

    if (result.success) {
      UserModel.i.clear();
      emit(state.copyWith(deleteAccount: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(deleteAccount: RequestState.done, msg: result.msg));
    }
  }

  final name = TextEditingController(text: UserModel.i.fulName);
  final email = TextEditingController(text: UserModel.i.email);
  final phone = TextEditingController(text: UserModel.i.phone);
  SelectModel? gender;
  editProfile() async {
    emit(state.copyWith(editProfile: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.editProfile, body: {
      "UserId": UserModel.i.id,
      "FullName": name.text,
      "Email": email.text,
      "Mobile": phone.text,
    });

    if (result.success) {
      UserModel.i
        ..fromJson(result.data['data'])
        ..save();
      FlashHelper.showToast(result.msg, type: MessageType.success);
      emit(state.copyWith(editProfile: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(editProfile: RequestState.done, msg: result.msg));
    }
  }

  final oldPassword = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  editPassword() async {
    emit(state.copyWith(editProfile: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.editPassword, body: {
      "UserId": UserModel.i.id,
      "OldPassword": oldPassword.text,
      "NewPassword": password.text,
      "ConfirmPassword": confirmPassword.text,
    });

    if (result.success) {
      emit(state.copyWith(editProfile: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(editProfile: RequestState.done, msg: result.msg));
    }
  }

  contactUs() async {
    emit(state.copyWith(contactUs: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.editPassword);

    if (result.success) {
      launchUrl(Uri(path: result.data['data'], scheme: 'tel'));
      emit(state.copyWith(contactUs: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(contactUs: RequestState.done, msg: result.msg));
    }
  }
}
