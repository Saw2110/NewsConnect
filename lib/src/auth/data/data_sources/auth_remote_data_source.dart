import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_connect/src/auth/auth.dart';

import '../../../../core/core.dart';

abstract class AuthRemoteDataSource {
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> login(
    String email,
    String password,
  );
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> register(
    String email,
    String password,
    String fullName,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<(FirebaseAuthException?, FirebaseAuthUser?)> login(
    String email,
    String password,
  ) async {
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
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _createNewUserInFirestore(
          uid: userCredential.user!.uid,
          email: email,
          fullName: fullName,
        );
      }

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

  Future<void> _createNewUserInFirestore({
    required String uid,
    required String email,
    required String fullName,
  }) async {
    final usersRef = firestore.collection(FirebaseConst.usersCollection);
    await usersRef.doc(uid).set({
      'id': uid,
      'email': email,
      'fullName': fullName,
      'contactNo': "",
      'createdDate':DateTime.now().toString(),
      'gender': "",
      'bio': "",
      'address': "",
    });
  }
}
