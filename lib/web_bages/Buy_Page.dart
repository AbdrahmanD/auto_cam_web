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


                  Container(width: w/6,
                    child: Text("$user",
                        style: GoogleFonts.aBeeZee(
                            fontSize: w/96, color: Colors.white)
                    ),)
                ],
              ),
            ),

            /// main content
            Container(              height:( h/4)*3,

              child: Row(
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
SizedBox(width: 28,),
                  ///home
                  Expanded(
                      flex: 20,
                      child: Container(
                        height: h - 200,
                        child:
                        ListView(
                          children: [
                            Text("Chose your Plan",
                              style: GoogleFonts.aclonica(fontSize: 32, color: Colors.white),),
                            SizedBox(height: 18,),

                            Text("all plan give you access to our accessories library \n"
                                "all plan basically support BeamSaw and Drilling machine  \n"
                                "you can add additional support for another machines like : \n"
                                "cnc routers  or another type of BeamSaws or Drilling machines ",
                              style: GoogleFonts.aBeeZee(fontSize: 22, color: Colors.white),),
                            SizedBox(height: 24,),
                            Text(" 1 - use AUTOCAM online with monthly limit (100 time) for 75\$ monthly .",
                              style: GoogleFonts.adamina(fontSize: 18, color: Colors.white),),
                            SizedBox(height: 12,),
                            Text(" 2 - use AUTOCAM online Unlimited for 200\$ monthly.", style: GoogleFonts.adamina(fontSize: 18, color: Colors.white),),SizedBox(height: 12,),
                            Text(" 3 - have desktop AUTOCAM for windows or mac for 2200\$ once .", style: GoogleFonts.adamina(fontSize: 18, color: Colors.white),),
                            SizedBox(height: 24,),
                            Text(" 4 - Additional support for another type of  machines for 500\$ once .", style: GoogleFonts.adamina(fontSize: 18, color: Colors.white),),SizedBox(height: 12,),

                            ///  mobile num
                            Container( height: 200,
                              child: Row(
                                children: [

                                  // SizedBox(height: 32,),
                                  Container(width: 42,height: 42,child:
                                  Image.asset('lib/assets/images/icons8-whatsapp-480.png')
                                  ),
                                  SizedBox(width: 42,),

                                  Container(width: 42,height: 42,child:
                                  Icon(Icons.phone,size: 42,color: Colors.white,)                            ),
                                  SizedBox(width: 56,),

                                  Text("+971 566614432" ,
                                    style: GoogleFonts.arsenal(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 32,),



                                ],
                              ),
                            ),

                          ],
                        ),
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
            ),
          ],
        ),
      ),

    ));

  }
}
