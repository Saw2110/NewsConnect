import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_connect/src/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthUser?> login(String email, String password) async {
    final (authException, firebaseAuthUser) =
        await remoteDataSource.login(email, password);

    if (authException != null) {
      _handleAuthException(authException);
      return null;
    }

    return firebaseAuthUser;
  }

  @override
  Future<AuthUser?> register(String email, String password) async {
    final (authException, firebaseAuthUser) =
        await remoteDataSource.register(email, password);

    if (authException != null) {
      _handleAuthException(authException);
      return null;
    }

    return firebaseAuthUser;
  }

  void _handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'user-not-found':
        throw AuthException('No user found for that email.');
      case 'wrong-password':
        throw AuthException('Wrong password provided for that user.');
      case 'weak-password':
        throw AuthException('The password provided is too weak.');
      case 'email-already-in-use':
        throw AuthException('The account already exists for that email.');
      default:
        throw AuthException(
            exception.message ?? 'An unexpected error occurred.');
    }
  }
}

// Custom exception class
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}
