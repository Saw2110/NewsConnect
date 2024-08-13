import 'package:flutter/material.dart';
import 'package:news_connect/core/core.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      canPop: false,
      body: Center(
        child: Text("INDEX"),
      ),
    );
  }
}
