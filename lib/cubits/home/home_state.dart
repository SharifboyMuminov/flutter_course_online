import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/category_model.dart';
import 'package:fire_auth/data/model/product_model.dart';

class HomeState {
  final String errorText;
  final String statusMessage;
  final FormsStatus formsStatus;
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  HomeState({
    required this.formsStatus,
    required this.statusMessage,
    required this.errorText,
    required this.products,
    required this.categories,
  });

  HomeState copyWith({
    String? errorText,
    String? statusMessage,
    FormsStatus? formsStatus,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
  }) {
    return HomeState(
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? "",
      errorText: errorText ?? this.errorText,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }

  factory HomeState.initial() {
    return HomeState(
      formsStatus: FormsStatus.pure,
      statusMessage: "",
      errorText: "",
      categories: [],
      products: [],
    );
  }
}
