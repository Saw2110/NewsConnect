import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/core.dart';
import '../../profile.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl(this.firestore);

  @override
  Future<void> createNewUser(UserModel user) async {
    final usersRef = firestore.collection(FirebaseConst.usersCollection);
    await usersRef.doc(user.id).set({
      'id': user.id,
      'email': user.email,
      'image': user.image,
      'fullName': user.fullName,
      'contactNo': user.contactNo,
      'createdDate': DateTime.now().toString(),
      'gender': user.gender,
      'bio': user.bio,
      'address': user.address,
    });
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final usersRef = firestore.collection(FirebaseConst.usersCollection);
    await usersRef.doc(user.id).update({
      'email': user.email,
      'image': user.image,
      'fullName': user.fullName,
      'contactNo': user.contactNo,
      'gender': user.gender,
      'bio': user.bio,
      'address': user.address,
    });
  }

  @override
  Future<UserModel> getUsers(String uid) {
    final usersRef = firestore.collection(FirebaseConst.usersCollection);
    return usersRef.doc(uid).get().then((doc) {
      if (doc.exists) {
        return UserModel.fromDocument(doc);
      } else {
        throw Exception("User not found");
      }
    });
  }
}
