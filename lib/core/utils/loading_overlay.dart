import 'package:flutter/material.dart';
import 'package:news_connect/core/core.dart';

class AppLoadingOverlay {
  final BuildContext _context;
  static BuildContext? newContext;
  static bool taskCompleted = true;

  void hide() {
    if (taskCompleted) return;
    taskCompleted = true;
    if (newContext != null) {
      Navigator.of(newContext!).pop();
    }
  }

  Future<void> show() async {
    taskCompleted = false;
    showDialog(
      context: _context,
      builder: (context) {
        newContext = context;
        return _FullScreenLoader();
      },
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  AppLoadingOverlay._create(this._context);

  factory AppLoadingOverlay.of(BuildContext context) {
    return AppLoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: AppLoadingOverlay.taskCompleted,
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
          backgroundColor: AppColors.black,
        ),
      ),
    );
  }
}
