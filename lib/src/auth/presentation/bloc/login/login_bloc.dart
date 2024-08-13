import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:news_connect/core/core.dart';
import 'package:news_connect/src/auth/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: kDebugMode ? "test@test.com" : "",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: kDebugMode ? "11Asabin@@" : "",
  );

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<OnLoginButtonPressed>(_onLoginButtonPressed);
  }

  // Public getters for accessing the private members
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  // Handle login button press event
  Future<void> _onLoginButtonPressed(
    OnLoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (!_isFormValid()) return;

    try {
      emit(LoginLoading());

      final user = await _loginUser();
      if (user != null) {
        await SetPrefs.isLogin(value: true);
        emit(LoginSuccess(userInfo: user));
      } else {
        emit(const LoginError(message: "Login failed"));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: _mapFirebaseAuthExceptionToMessage(e)));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  // Validate and save the form state
  bool _isFormValid() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _formKey.currentState?.save();
    }
    return isValid;
  }

  // Perform the login operation
  Future<AuthUser?> _loginUser() async {
    return await loginUseCase(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  // Map Firebase exceptions to user-friendly messages
  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException e) {
    log("asdasdasd => Code : ${e.code}  Exceptions : $e");
    switch (e.code) {
      case 'weak-password':
        return "The password provided is too weak.";
      case 'email-already-in-use':
        return "The account already exists for that email.";
      default:
        return e.toString();
    }
  }

  @override
  Future<void> close() {
    _emailController.dispose();
    _passwordController.dispose();
    return super.close();
  }
}
