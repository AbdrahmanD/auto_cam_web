import 'package:flutter/material.dart';

class Library_Page extends StatefulWidget {
  const Library_Page({Key? key}) : super(key: key);

  @override
  State<Library_Page> createState() => _Library_PageState();
}

class _Library_PageState extends State<Library_Page> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr,child: Scaffold(
      body: Container(
        child: Center(
          child: Text("Library_Page" ,style: TextStyle(fontSize: 132),),
        ),
      ),
    ),

    );
  }
}
