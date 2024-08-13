import 'package:news_connect/src/auth/auth.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthUser?> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email, password);
  }
}
