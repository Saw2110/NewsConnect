import 'package:news_connect/src/auth/auth.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthUser?> call({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await repository.register(email, password, fullName);
  }
}
