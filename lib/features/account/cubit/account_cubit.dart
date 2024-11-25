import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziena/core/services/server_gate.dart';
import 'package:ziena/core/utils/constant.dart';
import 'package:ziena/core/utils/enums.dart';
import 'package:ziena/core/widgets/flash_helper.dart';
import 'package:ziena/core/widgets/loading.dart';
import 'package:ziena/features/account/cubit/account_state.dart';
import 'package:ziena/models/user_model.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState());

  deleteAccount() async {
    loadingDialog();
    emit(state.copyWith(deleteAccount: RequestState.loading));
    final result = await ServerGate.i.deleteFromServer(
      url: ApiConstants.deleteAccount,
      params: {'UserId': UserModel.i.id},
    );
    hideLoadingDialog();
    if (result.success) {
      UserModel.i.clear();
      emit(state.copyWith(deleteAccount: RequestState.done, msg: result.msg));
    } else {
      FlashHelper.showToast(result.msg);
      emit(state.copyWith(deleteAccount: RequestState.done, msg: result.msg));

      // emit(state.copyWith(deleteAccount: RequestState.error, msg: result.msg));
    }
  }
}
