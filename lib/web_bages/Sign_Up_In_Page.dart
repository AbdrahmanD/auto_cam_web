
 import 'package:auto_cam_web/online_autoam/Controller/Main_Controllers/Firebase_controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/User_modle.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';





class Sign_Up_In_Page extends StatefulWidget {



  @override
  State<Sign_Up_In_Page> createState() => _Sign_Up_In_PageState();
}

class _Sign_Up_In_PageState extends State<Sign_Up_In_Page> {

TextEditingController Email_controller=TextEditingController();
// TextEditingController name_controller=TextEditingController();
// TextEditingController password_controller=TextEditingController();

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
  final user_email = GlobalKey<FormState>();

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

                          child: Text('Please Enter Your Email'
                              ,
                              style: GoogleFonts.kalam(
                                  fontSize: w/64, color: Colors.white))),

                      SizedBox(height: 64,),


                      /// name and password
                      //
                      // ///name
                      // Container(
                      //   child:Row(
                      //     children: [
                      //       Container(width: 100,
                      //         child: Text('name',
                      //             style: GoogleFonts.aBeeZee(
                      //                 fontSize: w/72, color: Colors.white)),
                      //       ),
                      //       SizedBox(width: 32,),
                      //
                      //       Container(
                      //         width: 200,
                      //          child: TextFormField(
                      //           controller: name_controller,
                      //            style: TextStyle(fontSize: 18, color: Colors.white),
                      //            decoration: InputDecoration(
                      //              border: OutlineInputBorder(
                      //                borderRadius: BorderRadius.circular(8),
                      //              ),
                      //            ),
                      //         ),
                      //       ),
                      //
                      //
                      //     ],
                      //   ),
                      // ),
                      //
                      //
                      // SizedBox(
                      //   height: 32,                ),
                      //
                      //
                      // /// password
                      // Container(
                      //   child:Row(
                      //     children: [
                      //       Container(width: 100,
                      //         child: Text('password',
                      //             style: GoogleFonts.aBeeZee(
                      //                 fontSize: w/72, color: Colors.white)),
                      //       ),
                      //       SizedBox(width: 32,),
                      //
                      //       Container(
                      //         width: 200,
                      //          child: TextFormField(
                      //           controller: password_controller,
                      //            style: TextStyle(fontSize: 18 , color: Colors.white),
                      //            decoration: InputDecoration(
                      //              border: OutlineInputBorder(
                      //                borderRadius: BorderRadius.circular(8),
                      //              ),
                      //            ),
                      //         ),
                      //       ),
                      //
                      //
                      //     ],
                      //   ),
                      // ),
                      //
                      //
                      //
                      // SizedBox(
                      //   height: 72,                ),

                      /// Email

                      SizedBox(height: 64,),

                      Form(
                        key: user_email,
                        child: Container(
                          child: TextFormField(
                            validator: validateEmail,
                            controller: Email_controller,
                            style: TextStyle(fontSize: 18 , color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 64,                ),



                      InkWell(
                        onTap: ()  {

                          if(user_email.currentState!.validate()) {

                            String email_value_to_database =Email_controller.text.toString().replaceAll(".", "");

                            User_modle user = User_modle(
                              // name_controller.text.toString(),
                              // password_controller.text.toString(),
                              email_value_to_database,
                              false,
                              1,
                              "normal",

                            );


                            firebase_caontroller.user_sign_in_up(user);
                            Get.to(Home_Screen());
                          }

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