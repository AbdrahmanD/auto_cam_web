
 import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Sign_Up_In_Page extends StatefulWidget {
  const Sign_Up_In_Page({Key? key}) : super(key: key);



  @override
  State<Sign_Up_In_Page> createState() => _Sign_Up_In_PageState();
}

class _Sign_Up_In_PageState extends State<Sign_Up_In_Page> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn  _googleSignIn = GoogleSignIn();

  final my_setting_data = GetStorage();


  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    // GoogleSignInAuthentication googleSignInAuthentication =
    // await googleSignInAccount!.authentication;

    print('==================================================');
    print('==================================================');
    print('user name = ${googleSignInAccount!.displayName}');
    print('user email = ${googleSignInAccount!.email}');


    my_setting_data.write("user",googleSignInAccount!.displayName);
    my_setting_data.write("sign_in",true);

    Get.to(Home_Screen());



  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    my_setting_data.write("sign_in",false);

    Get.to(Home_Screen());
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr
      ,child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Container(width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: ()  {
                         signInWithGoogle();
                      },
                      child: Container(
                          width: 200,height: 56,color: Colors.green,

                          child: Text('Sign in with Google')),
                    ),
                    SizedBox(
                height: 100,                ),
                    InkWell(
                      onTap: ()  {
                        signOut();
                      },
                      child: Container(
                          width: 200,height: 56,color: Colors.red,

                          child: Text('Sign out ')),
                    ),

                  ],
                ),
              ),
            ),
          ),
        )

    );
  }
}