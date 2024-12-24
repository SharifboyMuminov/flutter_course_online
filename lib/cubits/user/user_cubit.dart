import 'package:fire_auth/cubits/user/user_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/notes_model.dart';
import 'package:fire_auth/data/repositories/user_repository.dart';
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
        emit(state.copyWith(formsStatus: FormsStatus.unauthenticated));
      } else {
        setStateToError(networkResponse.errorText);
      }
    }
  }

  Future<void> fetchUserForDocId({required String docId}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
        await _userRepository.getUserForDocId(docId: docId);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          userModel: networkResponse.data,
        ),
      );
    } else {
      if (networkResponse.errorText == "not_found") {
        emit(state.copyWith(formsStatus: FormsStatus.unauthenticated));
      } else {
        setStateToError(networkResponse.errorText);
      }
    }
  }

  Future<void> saveNotes({required NotesModel notesModel}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    List<NotesModel> notes = state.userModel.userNotes;

    notes.add(notesModel);

    NetworkResponse networkResponse = await _userRepository.updateUserNotes(
      userModel: state.userModel.copyWith(userNotes: notes),
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(statusMessage: "pop"));
      fetchUserForDocId(docId: state.userModel.docId);
    } else {
      setStateToError(networkResponse.errorText);
    }
  }

  Future<void> updateNotes(
      {required NotesModel notesModel, required int indexNotesModel}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    List<NotesModel> notes = state.userModel.userNotes;

    notes[indexNotesModel] = notesModel;

    NetworkResponse networkResponse = await _userRepository.updateUserNotes(
      userModel: state.userModel.copyWith(userNotes: notes),
    );

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(statusMessage: "pop"));
      fetchUserForDocId(docId: state.userModel.docId);
    } else {
      setStateToError(networkResponse.errorText);
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
