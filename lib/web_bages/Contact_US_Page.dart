import 'package:auto_cam_web/online_autoam/View/Cabinet_Editor.dart';
import 'package:auto_cam_web/web_bages/Buy_Page.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact_US_Page extends StatefulWidget {

  late bool home_screen_bottom;


  Contact_US_Page(this.home_screen_bottom);

  @override
  State<Contact_US_Page> createState() => _Contact_US_PageState();
}

class _Contact_US_PageState extends State<Contact_US_Page> {


  TextEditingController customer_email = TextEditingController();
  TextEditingController customer_email_subject = TextEditingController();
  TextEditingController customer_email_content = TextEditingController();


  bool sign_in = false;
  String user="";
  final my_setting_data = GetStorage();



  _sendEmail(
      String email_sender,
      String email_subject,
      String email_content
      ) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'support@autocam.pro',
      path: '$email_sender',
      queryParameters: {
        'subject': '$email_subject',
        'body': '$email_content',
      },
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }


  @override
  Widget build(BuildContext context) {



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



    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

bool home_screen_bottom=widget.home_screen_bottom;

    return Directionality(textDirection: TextDirection.ltr
      ,child: Scaffold(
        backgroundColor: Color.fromRGBO(26, 43, 52, 1),

        body:
        Container(

          width: w, height: h,
          child: Column(
            children: [
             !home_screen_bottom? Container(
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



                    /// contact
                    Container(
                      width: w / 14,
                      child: Center(
                          child: InkWell(
                            onTap: () {

                              Get.to(Contact_US_Page(false));



                            },
                            child: Text("contact",
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


                    ///Buy
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
                    Container(width: w/6,
                      child: Text("$user",
                          style: GoogleFonts.aBeeZee(
                              fontSize: w/96, color: Colors.white)
                      ),),




                  ],
                ),
              ):SizedBox(),

              Container(
                width: w,height: h/2.5,color: Color.fromRGBO(74, 101, 114,1),
                child: Row(
                  children: [

                    /// label , social media , email
                    Expanded(flex: 1,child:
                    Container(
                      child: Column(
                        children: [

                          SizedBox(height: 32,),
                          Text("AUTOCAM" ,
                            style: GoogleFonts.kalam(fontSize: 72,color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 32,),

                          ///  info@autocam.pro
                          InkWell(
                            onTap: (){

                            },
                            child: Text("info@autocam.pro" ,
                              style: GoogleFonts.arsenal(fontSize: 24,color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 16,),


                          ///  support@autocam.pro
                          InkWell(
                            onTap: (){
                              _sendEmail(
                                 customer_email.text.toString(),
                                 customer_email_subject.text.toString(),
                                 customer_email_content.text.toString(),

                              );
                            },
                            child: Text("support@autocam.pro" ,
                              style: GoogleFonts.arsenal(fontSize: 24,color: Colors.white),
                            ),
                          ),

                        ],
                      ),
                    )),

                    /// app par
                    home_screen_bottom?
                    Expanded(flex: 1,child:
                    Container(

                      child: Column(
                        children: [

                          Expanded(flex: 1,
                            child: Container(
                              // color: Colors.blue,
                              child:
SizedBox()                            ),
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
                                    style: GoogleFonts.arsenal   (
                                      fontSize: w/50, color: Color.fromRGBO(0, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            color: Colors.white,
                                            offset: Offset(0, -10))
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
                          Expanded(flex: 1,
                            child: Container(
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
                          ),

                          /// Learn
                          Expanded(flex: 1,
                            child: Container(
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
                          ),

                          ///Download
                          // Container(
                          //   width: w / 16,
                          //   child: Center(
                          //       child: InkWell(
                          //     onTap: () {
                          //       Get.to(Home_Screen());
                          //     },
                          //     child: Text("Library",
                          //         style: GoogleFonts.aBeeZee(
                          //             fontSize: w/96, color: Colors.white)),
                          //   )),
                          // ),


                          /// contact
                          Expanded(flex: 1,
                            child: Container(
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
                          ),




                          Expanded(flex: 1,
                            child: Container(
                              // color: Colors.blue,
                                child:
                                SizedBox()                            ),
                          ),



                        ],
                      ),
                    )

                    ):SizedBox(),


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




      ),

    );
  }
}
