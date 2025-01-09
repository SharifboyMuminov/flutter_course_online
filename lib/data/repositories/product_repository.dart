import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/product_model.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> addProduct({
    required ProductModel productModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result = await _firebaseFirestore
          .collection("product")
          .add(productModel.toJson());

      await _firebaseFirestore
          .collection("product")
          .doc(result.id)
          .update({"id": result.id});
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateProduct({
    required ProductModel productModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection("product")
          .doc(productModel.id)
          .update(productModel.toJson());
    } on FirebaseException catch (e) {
      log(e.friendlyMessage);

      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      log("Noma'lum xatolik: catch (e) ");

      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}
