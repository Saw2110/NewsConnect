part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final AuthUser userInfo;
  const RegisterSuccess({required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

final class RegisterError extends RegisterState {
  final String message;
  const RegisterError({required this.message});

  @override
  List<Object> get props => [message];
}
