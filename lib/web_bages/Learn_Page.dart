import 'package:flutter/material.dart';

class Learn_Page extends StatefulWidget {
  const Learn_Page({Key? key}) : super(key: key);

  @override
  State<Learn_Page> createState() => _Learn_PageState();
}

class _Learn_PageState extends State<Learn_Page> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr, child: Scaffold(

      body: Container(
        child: Center(
          child: Text("Learn_Page" ,style: TextStyle(fontSize: 132),),
        ),
      ),
    ));
  }
}
