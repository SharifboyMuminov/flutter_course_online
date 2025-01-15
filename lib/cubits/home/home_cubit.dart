import 'package:fire_auth/cubits/home/home_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeState.initial());

  final HomeRepository _homeRepository;

  Future<void> getCategories() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));

    NetworkResponse networkResponse = await _homeRepository.getCategories();

    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(categories: networkResponse.data));
      getProducts();
    } else {
      setStateToError(networkResponse.errorText);
    }
  }

  Future<void> getProducts() async {
    emit(state.copyWith(formsStatus: FormsStatus.subLoading));

    NetworkResponse networkResponse = await _homeRepository.getProducts();

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          products: networkResponse.data,
        ),
      );
    } else {
      setStateToError(networkResponse.errorText);
    }
  }

  Future<void> setCategory(String categoryId) async {
    emit(state.copyWith(formsStatus: FormsStatus.subLoading));

    NetworkResponse networkResponse =
        await _homeRepository.getProductsForCategoryId(categoryId);

    if (networkResponse.errorText.isEmpty) {
      emit(
        state.copyWith(
          formsStatus: FormsStatus.success,
          products: networkResponse.data,
        ),
      );
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
