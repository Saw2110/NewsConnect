import '../../profile.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<UserModel> call(String uid) {
    return repository.getUsers(uid);
  }
}
