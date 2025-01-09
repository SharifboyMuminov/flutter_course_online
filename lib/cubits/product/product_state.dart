import 'package:fire_auth/data/enums/forms_status.dart';

class ProductState {
  final String errorText;
  final String statusMessage;
  final FormsStatus formsStatus;

  ProductState({
    required this.formsStatus,
    required this.statusMessage,
    required this.errorText,
  });

  ProductState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formsStatus,
  }) {
    return ProductState(
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? "",
      errorText: errorText ?? this.errorText,
    );
  }

  factory ProductState.initial() {
    return ProductState(
      formsStatus: FormsStatus.pure,
      statusMessage: "",
      errorText: "",
    );
  }
}
