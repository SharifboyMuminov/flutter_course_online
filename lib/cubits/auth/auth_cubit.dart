import 'package:fire_auth/cubits/auth/auth_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthState.initial());

  final AuthRepository _authRepository;

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _authRepository.registerUser(
      email: email,
      password: password,
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.error,
          errorText: networkResponse.errorText,
        ),
      );
    }
  }
}
