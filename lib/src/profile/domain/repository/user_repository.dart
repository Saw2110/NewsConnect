import '../../profile.dart';

abstract class UserRepository {
  Future<void> createNewUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<UserModel> getUsers(String uid);
}
