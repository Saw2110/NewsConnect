import '../../profile.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> call(UserModel user) async {
    await repository.updateUser(user);
  }
}


