import 'package:flutter/material.dart';
import 'package:news_connect/core/core.dart';

class PageWrapper extends StatelessWidget {
  final String appBarText;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool removeAllPadding;
  final bool canPop;
  final void Function(bool, dynamic)? onPopInvokedWithResult;
  final EdgeInsets extraPadding;
  const PageWrapper({
    super.key,
    this.appBarText = "",
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.removeAllPadding = false,
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.extraPadding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: Scaffold(
        appBar: appBarText.isNotEmpty ? AppBar(title: Text(appBarText)) : null,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: removeAllPadding
            ? body
            : Padding(
                padding: const EdgeInsets.all(10.0) + extraPadding,
                child: body,
              ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
