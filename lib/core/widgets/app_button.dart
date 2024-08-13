import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const AppPrimaryButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const AppSecondaryButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
