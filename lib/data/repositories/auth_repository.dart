import 'package:fire_auth/data/model/network_response.dart';
import 'package:fire_auth/utils/app_extension/app_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      if (userCredential.user != null) {}
    } on FirebaseAuthException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } on FirebaseException catch (e) {
      networkResponse.errorText = e.friendlyMessage;
    } catch (e) {
      networkResponse.errorText = "Noma'lum xatolik: catch (e) ";
    }

    return networkResponse;
  }
}
