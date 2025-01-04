import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/user_model.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> loginUser({
    required String phoneNumber,
    required String password,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      var result = await _firebaseFirestore
          .collection("admins")
          .where("phone_number", isEqualTo: phoneNumber)
          .where("password", isEqualTo: password)
          .get();

      List<UserModel> userModels =
          result.docs.map((value) => UserModel.fromJson(value.data())).toList();

      if (userModels.isNotEmpty) {
        StorageRepository.setString(key: "user_id", value: userModels.first.docId);
        networkResponse.data = userModels.first;
      } else {
        networkResponse.errorText = "Bunday admin mavjud emas";
        log("Bunday admin mavjud emas");
      }
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
