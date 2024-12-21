import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/user_model.dart';

class UserState {
  final String errorText;
  final String statusMessage;
  final FormsStatus formsStatus;
  final UserModel userModel;

  UserState({
    required this.formsStatus,
    required this.statusMessage,
    required this.errorText,
    required this.userModel,
  });

  UserState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formsStatus,
    UserModel? userModel,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? "",
      errorText: errorText ?? this.errorText,
    );
  }

  factory UserState.initial() {
    return UserState(
      formsStatus: FormsStatus.pure,
      statusMessage: "",
      errorText: "",
      userModel: UserModel.initial(),
    );
  }
}
