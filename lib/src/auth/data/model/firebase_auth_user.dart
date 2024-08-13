import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_user.dart';

class FirebaseAuthUser extends AuthUser {
  FirebaseAuthUser({required super.uid, required super.email});

  factory FirebaseAuthUser.fromFirebaseUser(User user) {
    return FirebaseAuthUser(uid: user.uid, email: user.email!);
  }
}
