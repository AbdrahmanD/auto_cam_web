
 import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Firebase_controller.dart';
import 'package:auto_cam_web/online_autoam/View/Cabinet_Editor.dart';
import 'package:auto_cam_web/web_bages/Buy_Page.dart';
import 'package:auto_cam_web/web_bages/Contact_US_Page.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:auto_cam_web/web_bages/Sign_Up_In_Page.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:google_fonts/google_fonts.dart';




class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Home_Screen> {

  Firebase_caontroller firebase_caontroller = Get.find();

  final my_setting_data = GetStorage();
  bool sign_in = false;
  String user="";



  ScrollController scrollController = ScrollController();


  @override
  void initState() {

    if(
    my_setting_data.read("user_name")!=null &&
    my_setting_data.read("user_name")!=""
    ){
      user=my_setting_data.read("user_name");
      sign_in=true;
    }


    super.initState();
  }

  sign_out(){

    my_setting_data.write("user_name", "");
    sign_in=false;


    setState(() {

    });
  }





  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    double q=w/4;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(26, 43, 52, 1),
          body:

          ListView(

            children:[


              /// home page
              Container(
                // AssetImage("lib/assets/background.png"),fit: BoxFit.fill),),
                width: w, height: h+200,
                child: Column(
                  children: [

                    /// app par
                    Container(
                      height: h/4,
                      child:

                      Row(
                        children: [

                          Container(
                            width: (w / 3),
                            // height: h - 200,
                            child:
                            Center(
                                child: Image.asset(
                                  "lib/assets/images/app_fotos/logo.png",
                                )),
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



                          /// contact
                          Container(
                            width: w / 16,
                            child: Center(
                                child: InkWell(
                              onTap: () {


                                Get.to(Contact_US_Page(false));
                                // scrollController.jumpTo(scrollController.position.maxScrollExtent);


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
                                  child: Text("Buy",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: w/96, color: Colors.white)),
                                )),
                          ),



                          SizedBox(
                            width: (w / 9),
                          ),

                          /// Sign in / out
                          Container(
                            width: w / 9,
                            child: Center(
                                child: InkWell (
                                  onTap: () async{
                                   !sign_in? Get.to(Sign_Up_In_Page())
                                   :
                                   sign_out()
                                   ;
                                  },
                                  child: Text(!sign_in?"Sign in":user,
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: w/96, color: Colors.white)
                                  ),
                                )),
                          ),

                          // Container(width: w/6,
                          // child: Text("$user",
                          //     style: GoogleFonts.aBeeZee(
                          //     fontSize: w/96, color: Colors.white)
                          // ),)
                        ],
                      ),
                    ).animate(
                      effects: [ScaleEffect(duration: Duration(milliseconds: 200))],
                    ),

                    /// main content
                    Row(
                        children: [

                          ///Sized box
                          Expanded(
                              flex: 1,
                              child:
                              Container(
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

                          ///home
                          Expanded(
                              flex: 20,
                              child: Container(
                                height: h - 200,
                                child:
                                Center(
                                      child: Image.asset(
                                    "lib/assets/images/app_fotos/logo.png",
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
                width: w/1.5,
                child: Center(
                  child: Text(
                    "\n \n "
                        "AUTOCAM software is the perfect solution for furniture factories.\n    "
                        " using AUTOCAM you can :\n    "
                        "     - Design Product . \n    "
                        "     - Get Shop drawings.\n    "
                        "     - Get Material Quantity lists. \n    "
                        "     - Get Cutting files for cutting machines like : BeamSaw , CNC Routers .\n    "
                        "     - Get Drilling files for Drilling machines.\n\n    "
                        " with AUTOCAM \n    "
                        " No more CAD or CAM softwares ....\n\n "
                        " one place for all you work process \n\n"
                        "  AUTOCAM \n    "

                    ,style: GoogleFonts.arsenal(fontSize: w/56,fontWeight: FontWeight.w100,color: Colors.white),
                  ),
                ),
              ),


              /// process flow

              // Container(
              //   width: w,height: h/2,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //        itemCount: foto_names.length-1,
              //        itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.all(32.0),
              //           child: Image.asset(foto_names[index]),
              //         );
              //       },
              //     ),
              //   ),
              // ),

              Container(
                  width: w,height: h/10,

              )
,

              /// bottom

              Container(
                  width: w,
                  height: h/3,
                  child: Contact_US_Page(true)
              )

            ],
          ),


      ),
    );
  }
}
