import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_connect/src/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> login(
      String email, String password);
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> register(
      String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> login(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (null, FirebaseAuthUser.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      return (e, null);
    } catch (e) {
      return (
        FirebaseAuthException(code: 'unexpected-error', message: e.toString()),
        null
      );
    }
  }

  @override
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> register(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (null, FirebaseAuthUser.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      return (e, null);
    } catch (e) {
      return (
        FirebaseAuthException(code: 'unexpected-error', message: e.toString()),
        null
      );
    }
  }
}
