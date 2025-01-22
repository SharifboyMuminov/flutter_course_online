import 'dart:async';

import 'package:fire_auth/cubits/home/home_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/product_model.dart';
import 'package:fire_auth/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeState.initial());

  final HomeRepository _homeRepository;
  late StreamSubscription<List<ProductModel>> _productsListen;

  Future<void> getCategories() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _homeRepository.getCategories();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(categories: networkResponse.data));
      listenProducts();
    } else {
      setStateToError(networkResponse.errorText);
    }
  }

  Future<void> listenProducts([String categoryId = ""]) async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    _productsListen = _homeRepository.getProduct(categoryId: categoryId).listen(
      (response) {
        if (!isClosed) {
          emit(
            state.copyWith(
              formsStatus: FormsStatus.success,
              products: response,
            ),
          );
        }
      },
      onError: (error) {
        setStateToError(error.toString());
      },
    );
  }

  // Future<void> setCategory(String categoryId) async {
  //   List<ProductModel> products = state.products.where(
  //     (item) {
  //       return item.categoryId == categoryId;
  //     },
  //   ).toList();
  //
  //   emit(state.copyWith(products: products));
  // }
  //
  void setStateToError(String errorText) {
    emit(
      state.copyWith(
        formsStatus: FormsStatus.error,
        errorText: errorText,
      ),
    );
  }

  @override
  Future<void> close() {
    _productsListen.cancel();
    return super.close();
  }
}
