import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final firstName = TextEditingController(text: UserModel.i.firstName);
  final lastName = TextEditingController(text: UserModel.i.lastName);
  final email = TextEditingController(text: UserModel.i.email);
  String? cityId = UserModel.i.city;
  String? nationalityId = UserModel.i.nationality;
  editProfile() async {
    emit(state.copyWith(editProfile: RequestState.loading));
    final result = await ServerGate.i.putToServer(url: ApiConstants.editProfile, body: {
      "UserId": UserModel.i.id,
      "FirstName": firstName.text,
      "LastName": lastName.text,
      "Email": email.text,
      "CityId": cityId,
      "NationalityId": nationalityId,
    });

    if (result.success) {
      UserModel.i
        ..fromEditProfile(result.data['data'])
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
    emit(state.copyWith(editPassword: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: ApiConstants.editPassword, body: {
      "UserId": UserModel.i.id,
      "OldPassword": oldPassword.text,
      "NewPassword": password.text,
      "ConfirmPassword": confirmPassword.text,
    });

    if (result.success) {
      emit(state.copyWith(editPassword: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(editPassword: RequestState.done, msg: result.msg));
    }
  }

  String? phone;
  contactUs() async {
    if (phone != null) {
      launchUrl(Uri(path: phone, scheme: 'tel'));
      return;
    }
    emit(state.copyWith(contactUs: RequestState.loading));
    final result = await ServerGate.i.getFromServer(url: ApiConstants.getContactUsPhone);
    if (result.success) {
      phone = result.data['data'].toString();
      launchUrl(Uri(path: phone, scheme: 'tel'));
      emit(state.copyWith(contactUs: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(contactUs: RequestState.done, msg: result.msg));
    }
  }
}
