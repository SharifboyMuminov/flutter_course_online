import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/model/category_model.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/product_model.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';

class HomeRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getCategories() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await _firebaseFirestore.collection("categories").get();

      networkResponse.data = result.docs
          .map((value) => CategoryModel.fromJson(value.data()))
          .toList();
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> getProductsForCategoryId(String categoryId) async {
    NetworkResponse networkResponse = NetworkResponse();

    String userId = StorageRepository.getString(key: "user_id");

    try {
      var result = await _firebaseFirestore
          .collection("product")
          .where("category_id", isEqualTo: categoryId)
          .get();

      networkResponse.data = result.docs
          .map((value) => ProductModel.fromJson(value.data()))
          .toList();
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Stream<List<ProductModel>> getProduct({String categoryId = ""}) {
    try {
      if (categoryId.isNotEmpty) {
        return _firebaseFirestore
            .collection("product")
            .where("category_id", isEqualTo: categoryId)
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map(
                    (doc) => ProductModel.fromJson(doc.data()),
                  )
                  .toList(),
            );
      }

      return _firebaseFirestore.collection("product").snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => ProductModel.fromJson(doc.data()),
                )
                .toList(),
          );
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      return Stream.error("Firebase xatoligi: ${e.friendlyMessage}");
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      return Stream.error("Noma'lum xatolik: $e");
    }
  }
}
