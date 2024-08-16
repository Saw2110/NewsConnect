import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<OnRegisterButtonPressed>(_onRegisterButtonPressed);
  }
  // Public getters for accessing the private members
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get fullnameController => _fullnameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get cPasswordController => _cPasswordController;

  // Handle login button press event
  Future<void> _onRegisterButtonPressed(
    OnRegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    if (!_isFormValid()) return;

    try {
      emit(RegisterLoading());

      final user = await _registerUser();
      if (user != null) {
        emit(RegisterSuccess(userInfo: user));
      } else {
        emit(const RegisterError(message: "Login failed"));
      }
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(message: _mapFirebaseAuthExceptionToMessage(e)));
    } catch (e) {
      emit(RegisterError(message: e.toString()));
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
  Future<AuthUser?> _registerUser() async {
    return await registerUseCase(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      fullName: _fullnameController.text.trim(),
    );
  }

  // Map Firebase exceptions to user-friendly messages
  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException e) {
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

  ///
}
