part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthUser userInfo;
  const LoginSuccess({required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

final class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});

  @override
  List<Object> get props => [message];
}
