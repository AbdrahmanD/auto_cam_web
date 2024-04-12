import 'package:auto_cam_web/online_autoam/View/Cabinet_Editor.dart';
import 'package:auto_cam_web/web_bages/Contact_US_Page.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Buy_Page extends StatefulWidget {
  const Buy_Page({Key? key}) : super(key: key);

  @override
  State<Buy_Page> createState() => _Buy_PageState();
}

class _Buy_PageState extends State<Buy_Page> {

  bool sign_in = false;
  String user="";
   final my_setting_data = GetStorage();


  @override
  Widget build(BuildContext context) {
    if (my_setting_data.read("user") != null) {
      user = my_setting_data.read("user");
    } else {
      user = "";
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Directionality(textDirection: TextDirection.ltr, child: Scaffold(
      backgroundColor: Color.fromRGBO(26, 43, 52, 1),

      body:

      Container(

        width: w, height: h,
        child: Column(
          children: [
            Container(
              height: h/4,
              child:

              /// app par
              Row(
                children: [

                  SizedBox(
                    width: (w / 3),
                  ),
                  ///home page
                  Container(
                    // color: Colors.blue,
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Home_Screen());
                          },
                          child: Text("Home",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),

                  /// try page
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Cabinet_Editor(true));
                          },
                          child: Text("Try",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),

                  /// Learn
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Learn_Page());
                          },
                          child: Text("Learn",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),


                  /// contact us
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Contact_US_Page(false));

                          },
                          child: Text("contact",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),


                  ///buy
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Buy_Page());
                          },
                          child: Text("Buy",     style: GoogleFonts.aBeeZee(
                            fontSize: w/80, color: Color.fromRGBO(0, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.white,
                                  offset: Offset(0, -5))
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 4,
                            // decorationStyle: TextDecorationStyle.dashed,
                          ),),
                        )),
                  ),




                  SizedBox(
                    width: (w / 9),
                  ),

                  /// Sign in / out
                  // Container(
                  //   width: w / 18,
                  //   child: Center(
                  //       child: InkWell(
                  //         onTap: () {
                  //
                  //           !sign_in?
                  //           signInWithGoogle()
                  //               :
                  //           signOut();
                  //
                  //
                  //         },
                  //         child: Text(sign_in?"Sign out":"Sign in",
                  //             style: GoogleFonts.aBeeZee(
                  //                 fontSize: w/96, color: Colors.white)
                  //         ),
                  //       )),
                  // ),


                  Container(width: w/6,
                    child: Text("$user",
                        style: GoogleFonts.aBeeZee(
                            fontSize: w/96, color: Colors.white)
                    ),)
                ],
              ),
            ),

            /// main content
            Container(width: w,height: (h/4)*3,)
          ],
        ),
      ),

    ));

  }
}
