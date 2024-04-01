import 'package:flutter/material.dart';

class Sign_Up_In_Page extends StatefulWidget {
  const Sign_Up_In_Page({Key? key}) : super(key: key);

  @override
  State<Sign_Up_In_Page> createState() => _Sign_Up_In_PageState();
}

class _Sign_Up_In_PageState extends State<Sign_Up_In_Page> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr
      ,child: Scaffold(
body: Container(
  child: Center(
    child: Text("Sign_Up_In_Page" ,style: TextStyle(fontSize: 132),),
  ),
),
      ),

    );
  }
}