
 import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Firebase_controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/User_modle.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';


 import 'package:google_sign_in/google_sign_in.dart';



class Sign_Up_In_Page extends StatefulWidget {



  @override
  State<Sign_Up_In_Page> createState() => _Sign_Up_In_PageState();
}

class _Sign_Up_In_PageState extends State<Sign_Up_In_Page> {

TextEditingController Email_controller=TextEditingController();
TextEditingController name_controller=TextEditingController();
TextEditingController password_controller=TextEditingController();

final my_setting_data = GetStorage();
Firebase_caontroller firebase_caontroller=Get.find();
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Directionality(textDirection: TextDirection.ltr
      ,child: MaterialApp(
          home: Scaffold(          backgroundColor: Color.fromRGBO(26, 43, 52, 1),

            body: Row(
              children: [
                Expanded(child: Container(),flex: 1,),
                Expanded(child: Container(),flex: 3,),
                Expanded(child: Container(
                  child:

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(

                          child: Text('account name and password '
                              ,
                              style: GoogleFonts.kalam(
                                  fontSize: w/64, color: Colors.white))),

                      SizedBox(height: 64,),


                      ///name
                      Container(
                        child:Row(
                          children: [
                            Container(width: 100,
                              child: Text('name',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: w/72, color: Colors.white)),
                            ),
                            SizedBox(width: 32,),

                            Container(
                              width: 200,
                               child: TextFormField(
                                controller: name_controller,
                                 style: TextStyle(fontSize: 18, color: Colors.white),
                                 decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                 ),
                              ),
                            ),


                          ],
                        ),
                      ),


                      SizedBox(
                        height: 32,                ),


                      /// password
                      Container(
                        child:Row(
                          children: [
                            Container(width: 100,
                              child: Text('password',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: w/72, color: Colors.white)),
                            ),
                            SizedBox(width: 32,),

                            Container(
                              width: 200,
                               child: TextFormField(
                                controller: password_controller,
                                 style: TextStyle(fontSize: 18 , color: Colors.white),
                                 decoration: InputDecoration(
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                 ),
                              ),
                            ),


                          ],
                        ),
                      ),



                      SizedBox(
                        height: 72,                ),

                      /// Email optional
                      Container(width: 150,
                        child: Text('email / optional',
                            style: GoogleFonts.aBeeZee(
                                fontSize: w/96, color: Colors.white)),
                      ),
                      Container(
                        child: TextFormField(
                          controller: Email_controller,
                          style: TextStyle(fontSize: 18 , color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 64,                ),



                      InkWell(
                        onTap: ()  {


                          User_modle user=User_modle(
                            name_controller.text.toString(),
                            password_controller.text.toString(),
                            Email_controller.text.toString(),
                            false,
                            1,
                            "normal",

                          );
firebase_caontroller.user_sign_in_up(user);
                            Get.to(Home_Screen());



                        },
                        child: Card(
                          elevation: 6,color: Colors.white70,shadowColor: Colors.white,
                          child:
                          Container(
                              width: 164,height: 46,

                              child: Center(child: Text('Sign in',
                                  style: GoogleFonts.kalam(
                                      fontSize: w/56,fontWeight: FontWeight.bold, color: Color.fromRGBO(26, 43, 52, 1),)
                              ))),
                        ),
                      ),

                    ],
                  ),
                ),flex: 2,),
                Expanded(child: Container(),flex: 1,),


              ],
            ),
          ),
        )

    );
  }
}