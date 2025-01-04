import 'package:fire_auth/data/enums/forms_status.dart';

class CategoryState {
  final String errorText;
  final String statusMessage;
  final FormsStatus formsStatus;

  CategoryState({
    required this.formsStatus,
    required this.statusMessage,
    required this.errorText,
  });

  CategoryState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formsStatus,
  }) {
    return CategoryState(
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? "",
      errorText: errorText ?? this.errorText,
    );
  }

  factory CategoryState.initial() {
    return CategoryState(
      formsStatus: FormsStatus.pure,
      statusMessage: "",
      errorText: "",
    );
  }
}
