
import 'package:auto_cam_web/online_autoam/View/Cabinet_Editor.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Home_Screen> {
  List<bool> hover_texts = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final my_setting_data = GetStorage();


  TextEditingController customer_email = TextEditingController();
  TextEditingController customer_email_subject = TextEditingController();
  TextEditingController customer_email_content = TextEditingController();



  bool sign_in = false;
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

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(26, 43, 52, 1),
          body:

          ListView(
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
                            width: w / 18,
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
                            width: w / 18,
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
                            width: w / 18,
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
                            width: w / 18,
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

                          /// Sign in / out
                          Container(
                            width: w / 18,
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                Get.to(Home_Screen());
                              },
                              child: Text(sign_in?"Sign out":"Sign in",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: w/96, color: Colors.white)
                              ),
                            )),
                          ),

                          /// contact us
                          Container(
                            width: w / 18,
                            child: Center(
                                child: InkWell(
                              onTap: () {
                                Get.to(Home_Screen());
                              },
                              child: Text("contact us",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: w/96, color: Colors.white)
                              ),
                            )),
                          ),


                          SizedBox(
                            width: (w / 6),
                          ),

                          Container(width: w/6,
                          child: Text("$customer_name",
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
                          " using AUTOCAM you will :\n    "
                          "     - Design capabilities . \n    "
                          "     - Shop drawings.\n    "
                          "     - Material Quantity lists. \n    "
                          "     - Cutting files for cutting machines ex : BeamSaw , CNC Routers.\n    "
                          "     - Drilling files for Drilling machines.\n\n    "
                          " with AUTOCAM \n    "
                          " No more CAD or CAM softwares .. "
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
                width: w,height: h/2,color: Color.fromRGBO(74, 101, 114,1),
                child: Row(
                  children: [

                    /// label , social media , email
                    Expanded(flex: 1,child:
                    Container(
                    child: Column(
                      children: [

                        SizedBox(height: 32,),
                        Text("AUTOCAM" ,
                          style: GoogleFonts.kalam(fontSize: 36,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 64,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(onTap: (){},child: Icon(Icons.facebook,size: 32,color: Colors.white,)),
                            SizedBox(width: 24,),
                            InkWell(onTap: (){},child: Icon(Icons.facebook,size: 32,color: Colors.white,)),
                            SizedBox(width: 24,),
                            InkWell(onTap: (){},child: Icon(Icons.facebook,size: 32,color: Colors.white,)),
                            SizedBox(width: 24,),
                          ],
                        ),
                        SizedBox(height: 16,),

                        InkWell(
                          onTap: (){

                          },
                          child: Text("info@autocam.pro" ,
                            style: GoogleFonts.arsenal(fontSize: 24,color: Colors.white),
                          ),
                        ),

                      ],
                    ),
                    )),

                    /// app par
                    Expanded(flex: 1,child: Container(

                    child: Column(
                      children: [
                        SizedBox(
                          height: (h / 25),
                        ),
                        Container(
                          height: h / 20,
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.to(Home_Screen());
                                },
                                child: Text("Home",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white)),
                              )),
                        ),
                        Container(
                          height: h / 20,
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.to(Home_Screen());
                                },
                                child: Text("Home",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white)),
                              )),
                        ),
                        Container(
                          height: h / 20,
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.to(Home_Screen());
                                },
                                child: Text("Home",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white)),
                              )),
                        ),
                        Container(
                          height: h / 20,
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.to(Home_Screen());
                                },
                                child: Text("Home",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white)),
                              )),
                        ),
                        Container(
                          height: h / 20,
                          child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.to(Home_Screen());
                                },
                                child: Text("Home",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18, color: Colors.white)),
                              )),
                        ),
                        SizedBox(
                          height: h / 10,
                        ),
                      ],
                    ),
                    )

                    ),


                    /// send message
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        decoration: BoxDecoration(

                            color: Color.fromRGBO(26, 43, 52, 1),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child:
                        Row(
                          children: [
                            SizedBox(width: 64,),
                            Column(
                              children: [

                                SizedBox(height: 24,),


                                Text("Your Email :"
                                  ,style: GoogleFonts.arsenal(fontSize: 16,fontWeight: FontWeight.w100,color: Colors.white),
                                ),
                                SizedBox(height: 6,),

                                Container(
                                  width: 200,
                                  height: 42,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12 , color: Colors.white),
                                    controller: customer_email,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    validator: (d) {
                                      if (d!.isEmpty) {
                                        return 'please add value';
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 16,),

                                Text("Subject :"
                                  ,style: GoogleFonts.arsenal(fontSize: 16,fontWeight: FontWeight.w100,color: Colors.white),
                                ),
                                SizedBox(height: 6,),

                                Container(
                                  width: 200,
                                  height: 42,
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 12 , color: Colors.white),
                                    controller: customer_email_subject,

                                    decoration: InputDecoration(

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    validator: (d) {
                                      if (d!.isEmpty) {
                                        return 'please add value';
                                      }
                                    },
                                  ),
                                ),

                                SizedBox(height: 12,),

                                /// send button
                                InkWell(onTap: (){

                                },
                                  child: Container(width: 200,height: 50,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(74, 101, 114,1),
                                      borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Center(
                                      child: Text("Send Message"
                                        ,style: GoogleFonts.arsenal(fontSize: 24,fontWeight: FontWeight.w100,color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(width: 24,),
                            Container(
                              // color: Colors.teal,

                              child: Column(
                                children: [

                                  SizedBox(height: 24,),
                                  Text("Message content :"
                                    ,style: GoogleFonts.arsenal(fontSize: 16,fontWeight: FontWeight.w100,color: Colors.white),
                                  ),

                                  SizedBox(height: 6,),



                                  Container(
                                    width: 200,
                                    // height: 200,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 12 , color: Colors.white),
                                      controller: customer_email_content,
                                      maxLines: 14,minLines: 8,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (d) {
                                        if (d!.isEmpty) {
                                          return 'please add value';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 24,),


                                ],
                              ),


                            ),
                            SizedBox(width: 64,),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )


            ],
          ),


      ),
    );
  }
}
