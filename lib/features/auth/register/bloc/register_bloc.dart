import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/utils/methods_helpers.dart';

import '../../../../core/routes/app_routes_fun.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/services/server_gate.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/flash_helper.dart';
import '../../../../models/city_model.dart';
import '../../verify_phone/view/verify_phone_view.dart';
import 'register_states.dart';

class RegisterBloc extends Cubit<RegisterState> {
  RegisterBloc() : super(RegisterState());
  final firstName = TextEditingController();
  final lastNeme = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  CityModel? city;

  Future<void> register() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await ServerGate.i.sendToServer(url: AppConstants.checkPhone, params: {"mobile": phone.text});
    if (result.success) {
      push(NamedRoutes.verifyPhone, arg: {
        'data': {
          "UserName": MethodsHelpers.formatPhoneNumber(phone.text),
          "Password": password.text,
          "FirstName": firstName.text.trim(),
          "LastName": lastNeme.text.trim(),
          "Email": email.text,
          "Source": '0',
          "City": city?.id,
        },
        "type": VerifyType.register
      });
      emit(state.copyWith(requestState: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(requestState: RequestState.error, msg: result.msg));
    }
  }
}
