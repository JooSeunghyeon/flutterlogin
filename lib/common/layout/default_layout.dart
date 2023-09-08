import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child; // 위젯을 상속받는다.
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({this.bottomNavigationBar,this.title,required this.child, super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white, // 기본색상은 흰색으로 시작한다.
      appBar: rederAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? rederAppBar(){
    if(title == null){
      return null;
    }else{
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }

}
