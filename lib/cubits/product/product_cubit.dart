import 'package:fire_auth/cubits/product/product_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/product_model.dart';
import 'package:fire_auth/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(ProductState.initial());

  final ProductRepository _productRepository;

  Future<void> addProduct({required ProductModel productModel}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
        await _productRepository.addProduct(productModel: productModel);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          statusMessage: "pop",
        ),
      );
    } else {
      setStateError(networkResponse.errorText);
    }
  }

  Future<void> updateProduct({required ProductModel productModel}) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse =
        await _productRepository.updateProduct(productModel: productModel);

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(formsStatus: FormsStatus.success));
    } else {
      setStateError(networkResponse.errorText);
    }
  }

  void setStateError(String error) {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.error,
        errorText: error,
      ),
    );
  }
}
