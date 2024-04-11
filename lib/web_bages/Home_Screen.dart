
import 'package:auto_cam_web/online_autoam/View/Cabinet_Editor.dart';
import 'package:auto_cam_web/web_bages/Contact_US_Page.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:auto_cam_web/web_bages/Sign_Up_In_Page.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Home_Screen> {


  final my_setting_data = GetStorage();



ScrollController scrollController=ScrollController();

  bool sign_in = false;
  String user="";
  final GoogleSignIn  _googleSignIn = GoogleSignIn();


  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    my_setting_data.write("user",googleSignInAccount!.displayName);
    my_setting_data.write("sign_in",true);

Get.to(Home_Screen());
setState(() {

    });
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    my_setting_data.write("sign_in",false);
    my_setting_data.write("user","");

    Get.to(Home_Screen());

    setState(() {

    });
  }



  @override
  void initState() {

    if (my_setting_data.read("user") != null) {
      user = my_setting_data.read("user");
    } else {
      user = "";
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

    if (my_setting_data.read("user") != null) {
      user = my_setting_data.read("user");
    } else {
      user = "";
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(26, 43, 52, 1),
          body:

          ListView(

controller: scrollController,
            children: [


              /// home page
              Container(
                // AssetImage("lib/assets/background.png"),fit: BoxFit.fill),),
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
                                  ),
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
                                      fontSize: w/96, color: Colors.white)),
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
                                      fontSize: w/96, color: Colors.white)),
                            )),
                          ),

                          ///Download
                          Container(
                            width: w / 16,
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                Get.to(Home_Screen());
                              },
                              child: Text("Download",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: w/96, color: Colors.white)),
                            )),
                          ),


                          /// contact us
                          Container(
                            width: w / 16,
                            child: Center(
                                child: InkWell(
                              onTap: () {

                                Get.to(Contact_US_Page(false));
                                // scrollController.jumpTo(scrollController.position.maxScrollExtent);


                              },
                              child: Text("contact us",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: w/96, color: Colors.white)
                              ),
                            )),
                          ),


                          SizedBox(
                            width: (w / 9),
                          ),

                          /// Sign in / out
                          Container(
                            width: w / 18,
                            child: Center(
                                child: InkWell(
                                  onTap: () {

                                    !sign_in?
                                    signInWithGoogle()
                                        :
                                    signOut();


                                  },
                                  child: Text(sign_in?"Sign out":"Sign in",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: w/96, color: Colors.white)
                                  ),
                                )),
                          ),

                          Container(width: w/6,
                          child: Text("$user",
                              style: GoogleFonts.aBeeZee(
                              fontSize: w/96, color: Colors.white)
                          ),)
                        ],
                      ),
                    ),

                    /// main content
                    Row(
                      children: [

                        ///Sized box
                        Expanded(
                            flex: 1,
                            child: Container(
                              // height: h - 200,
                                               )),

                        /// main title
                        Expanded(
                            flex: 10,
                            child: Container(
                              // height: h - 200,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 120),
                                child: Center(
                                    child:
                                   RichText(
                                     text: TextSpan(
                                        children: [
                                         TextSpan(
                                             text: "AUTOCAM\n",
                                             style: GoogleFonts.kalam(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.bold),
                                         ),
                                          TextSpan(
                                            text: "        SOFTWARE\n\n",
                                            style: GoogleFonts.kalam(fontSize: w/32,color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text: "no cad , no cam ...\n\n",
                                            style: GoogleFonts.arsenal(fontSize: w/36,color: Colors.white),
                                          ),
                                          TextSpan(
                                            text: "only autocam\n",
                                            style: GoogleFonts.arsenal(fontSize: w/36,color: Colors.white),
                                          ),
                                       ]
                                     ),

                                   )
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child: Container(
                              height: h - 200,
                              child: Center(
                                  child: Text(
                                "home",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 32, color: Colors.white),
                              )),
                            )),

                        ///Sized box
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: h - 200,
                                child:
                                SizedBox()                        )),


                      ],
                    ),
                  ],
                ),
              ),


              /// center part , explaining text
              Container(color: Color.fromRGBO(74, 101, 114,1),
                width: w,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 256,right: 256,top: 72,bottom: 72),
                    child: Text(
                      "AUTOCAM software is the perfect solution for furniture factories.\n    "
                          " using AUTOCAM you will get :\n    "
                          "     - Design capabilities . \n    "
                          "     - Shop drawings.\n    "
                          "     - Material Quantity lists. \n    "
                          "     - Cutting files for cutting machines like : BeamSaw , CNC Routers .\n    "
                          "     - Drilling files for Drilling machines.\n\n    "
                          " with AUTOCAM \n    "
                          " No more CAD or CAM softwares ....\n\n "
                          " one place for all you work process \n\n"
                          "  AUTOCAM \n    "

                      ,style: GoogleFonts.arsenal(fontSize: w/56,fontWeight: FontWeight.w100,color: Colors.white),
                    ),
                  ),
                ),
              ),


              /// process flow
              Container(
                width: w,height: h,
                child: Container(),
              ),


              /// bottom

              Container(
                  width: w,height: h/2,
                  child: Contact_US_Page(true)
              )

            ],
          ),


      ),
    );
  }
}
