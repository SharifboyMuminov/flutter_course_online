import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/data/model/user_model.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<NetworkResponse> registerUser({
    required String email,
    required String password,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        StorageRepository.setString(key: "user_email", value: email);
        return await saveUser(email);
      }
    } on FirebaseAuthException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> loginUser({
    required String email,
    required String password,
  }) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        StorageRepository.setString(key: "user_email", value: email);
      }
    } on FirebaseAuthException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }

  Future<NetworkResponse> saveUser(String email) async {
    NetworkResponse networkResponse = NetworkResponse();
    UserModel userModel = UserModel.initial();

    try {
      var result = await _firebaseFirestore
          .collection("users")
          .add(userModel.copyWith(email: email).toJson());

      await _firebaseFirestore
          .collection("users")
          .doc(result.id)
          .update({"doc_id": result.id});
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}
