import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseAuth firebaseAuth;
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUserUseCase;

  UserCubit({
    required this.firebaseAuth,
    required this.updateUserUseCase,
    required this.getUserUseCase,
  }) : super(UserInitial());

  Future<void> updateUser(UserModel user) async {
    try {
      emit(UserLoading());
      await updateUserUseCase(user);
      emit(UserSuccess(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> getUser() async {
    try {
      emit(UserLoading());
      debugPrint("asdasds => ${firebaseAuth.currentUser!.uid}");
      final users = await getUserUseCase(firebaseAuth.currentUser!.uid);

      emit(UserSuccess(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
