import 'package:flutter/material.dart';

class Contact_US_Page extends StatefulWidget {
  const Contact_US_Page({Key? key}) : super(key: key);

  @override
  State<Contact_US_Page> createState() => _Contact_US_PageState();
}

class _Contact_US_PageState extends State<Contact_US_Page> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr
      ,child: Scaffold(
        body: Container(
          child: Center(
            child: Text("Contact_US_Page" ,style: TextStyle(fontSize: 132),),
          ),
        ),
      ),

    );
  }
}
