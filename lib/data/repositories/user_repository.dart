import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/user_model.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> getUser() async {
    NetworkResponse networkResponse = NetworkResponse();
    String userEmail = StorageRepository.getString(key: "user_email");

    try {
      var result = await _firebaseFirestore
          .collection("users")
          .where("user_email", isEqualTo: userEmail)
          .get();

      List<UserModel> userModels =
          result.docs.map((value) => UserModel.fromJson(value.data())).toList();

      if (userModels.isNotEmpty) {
        networkResponse.data = userModels.first;
      } else {
        networkResponse.errorText = "not_found";
      }
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }
    return networkResponse;
  }

  Future<NetworkResponse> getUserForDocId({required String docId}) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      var result =
          await _firebaseFirestore.collection("users").doc(docId).get();

      if (result.data() != null) {
        UserModel.fromJson(result.data()!);
      } else {
        networkResponse.errorText = "not_found";
      }
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> updateUserNotes({
    required UserModel userModel,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(userModel.docId)
          .update(userModel.toJsonUserNotes());
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}
