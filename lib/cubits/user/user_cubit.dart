import 'package:fire_auth/cubits/user/user_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(UserState.initial());

  final UserRepository _userRepository;

  Future<void> fetchUser() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _userRepository.getUser();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          userModel: networkResponse.data,
        ),
      );
    } else {
      if (networkResponse.errorText == "not_found") {
        debugPrint("not_found  -------------");
        emit(state.copyWith(formsStatus: FormsStatus.unauthenticated));
      } else {
        setStateToError(networkResponse.errorText);
      }
    }
  }

  void setStateToError(String errorText) {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.error,
        errorText: errorText,
      ),
    );
  }
}
