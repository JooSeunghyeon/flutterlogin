import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child; // 위젯을 상속받는다.

  const DefaultLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 기본색상은 흰색으로 시작한다.
      body: child,
    );
  }
}
