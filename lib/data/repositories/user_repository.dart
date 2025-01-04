import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/user_model.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getUser() async {
    NetworkResponse networkResponse = NetworkResponse();
    String userId = StorageRepository.getString(key: "user_id");


    try {
      var result =
          await _firebaseFirestore.collection("admins").doc(userId).get();

      if (result.data() != null) {
        networkResponse.data = UserModel.fromJson(result.data()!);
      } else {
        networkResponse.errorText = "not_found";
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
