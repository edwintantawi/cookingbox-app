import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final Widget title;
  final Widget body;

  const AppShell({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        elevation: 0,
      ),
      body: body,
    );
  }
}
