import 'package:auto_cam_web/online_autoam/View/Main_Screen.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Try_Page extends StatefulWidget {
  const Try_Page({Key? key}) : super(key: key);

  @override
  State<Try_Page> createState() => _Try_PageState();
}

class _Try_PageState extends State<Try_Page> {

  bool sign_in = false;
  final my_setting_data = GetStorage();
  String customer_name="";

  @override
  void initState() {

    if (my_setting_data.read("customer_name") != null) {
      customer_name = my_setting_data.read("customer_name");
    } else {
      customer_name = "";
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    if (my_setting_data.read("sign_in") != null) {
      sign_in = my_setting_data.read("sign_in");
    } else {
      sign_in = false;
    }

    return Directionality(textDirection: TextDirection.ltr
        , child:Scaffold
      (
          // appBar: AppBar(
          //   backgroundColor: Color.fromRGBO(26, 43, 52, 1),
          //   title:  /// app par
          //   Container(width: w,height: 32,
          //     child: Row(
          //       children: [
          //         SizedBox(
          //           width: (w / 3),
          //         ),
          //
          //         ///home page
          //         Container(
          //           // color: Colors.blue,
          //           width: w / 18,
          //           child: Center(
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(Home_Screen());
          //                 },
          //                 child: Text("Home",
          //                   style: GoogleFonts.aBeeZee(
          //                       fontSize: w/96, color: Colors.white
          //                   ),
          //                 ),
          //               )),
          //         ),
          //
          //         /// try page
          //         Container(
          //           width: w / 18,
          //           child: Center(
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(Try_Page());
          //                 },
          //                 child: Text("Try",
          //                   style: GoogleFonts.aBeeZee(
          //                     fontSize: w/80, color: Color.fromRGBO(0, 0, 0, 0),
          //                     fontWeight: FontWeight.bold,
          //                     shadows: [
          //                       Shadow(
          //                           color: Colors.white,
          //                           offset: Offset(0, -5))
          //                     ],
          //                     decoration: TextDecoration.underline,
          //                     decorationColor: Colors.white,
          //                     decorationThickness: 4,
          //                     // decorationStyle: TextDecorationStyle.dashed,
          //                   ),
          //                 ),
          //               )),
          //         ),
          //
          //         /// Learn
          //         Container(
          //           width: w / 18,
          //           child: Center(
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(Learn_Page());
          //                 },
          //                 child: Text("Learn",
          //                     style: GoogleFonts.aBeeZee(
          //                         fontSize: w/96, color: Colors.white)
          //                 ),
          //               )),
          //         ),
          //
          //         ///Download
          //         Container(
          //           width: w / 18,
          //           child: Center(
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(Home_Screen());
          //                 },
          //                 child: Text("Download",
          //                     style: GoogleFonts.aBeeZee(
          //                         fontSize: w/96, color: Colors.white)),
          //               )),
          //         ),
          //
          //         /// Sign in / out
          //         Container(
          //           width: w / 18,
          //           child: Center(
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(Home_Screen());
          //                 },
          //                 child: Text(sign_in?"Sign out":"Sign in",
          //                     style: GoogleFonts.aBeeZee(
          //                         fontSize: w/96, color: Colors.white)
          //                 ),
          //               )),
          //         ),
          //
          //         /// contact us
          //         Container(
          //           width: w / 18,
          //           child: Center(
          //               child: InkWell(
          //                 onTap: () {
          //                   Get.to(Home_Screen());
          //                 },
          //                 child: Text("contact us",
          //                     style: GoogleFonts.aBeeZee(
          //                         fontSize: w/96, color: Colors.white)
          //                 ),
          //               )),
          //         ),
          //
          //
          //         // SizedBox(
          //         //   width: (w / 6),
          //         // ),
          //
          //         Container(width: w/6,
          //           child: Text("$customer_name",
          //               style: GoogleFonts.aBeeZee(
          //                   fontSize: w/96, color: Colors.white)
          //           ),)
          //       ],
          //     ),
          //   ),
          //
          // ),
          body: Main_Screen()
        )

    );
  }
}
