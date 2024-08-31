//auth_data.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_application_with_firebase/data/firestor.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String passwordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print('Login Error: ${e.message}');
      throw e;
    }
  }

  @override
  Future<void> register(
      String email, String password, String passwordConfirm) async {
    if (passwordConfirm == password) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        ).then((value) {
          Firestore_Datasource().CreateUser(email);
        });
      } on FirebaseAuthException catch (e) {
        print('Registration Error: ${e.message}');
        throw e;
      }
    } else {
      print('Passwords do not match');
      throw Exception('Passwords do not match');
    }
  }
}
