import 'package:auto_cam_web/online_autoam/View/Main_Screen.dart';
import 'package:flutter/material.dart';

class Try_Page extends StatefulWidget {
  const Try_Page({Key? key}) : super(key: key);

  @override
  State<Try_Page> createState() => _Try_PageState();
}

class _Try_PageState extends State<Try_Page> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr
        , child:Scaffold
      (
          body: Main_Screen()
        )

    );
  }
}
