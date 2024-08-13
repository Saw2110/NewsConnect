import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_connect/core/core.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<CheckLoginStatusEvent>(_onLoginCheck);
  }

  Future<void> _onLoginCheck(
    CheckLoginStatusEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      bool isLogin = await GetPrefs.isLogin();
      if (isLogin) {
        emit(SplashLoginSuccess());
      } else {
        emit(SplashLoginFailed());
      }
    });
  }
}
