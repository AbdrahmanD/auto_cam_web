import 'dart:ui';

import 'package:auto_cam_web/online_autoam/Controller/MY_Binding.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {


  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDdZ6eZDecCcyTlGRO3WW57og4wQwaci4Q",
          authDomain: "autocam-web.firebaseapp.com",
          projectId: "autocam-web",
          storageBucket: "autocam-web.appspot.com",
          messagingSenderId: "1061998431349",
          appId: "1:1061998431349:web:cc8eb1a9adb032c6defc3c",
          databaseURL:"https://autocam-web-default-rtdb.firebaseio.com/"

      )
  );

  final my_setting_data = GetStorage();
  my_setting_data.write("user", "");

  runApp(
      GetMaterialApp(
          scrollBehavior: MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
          ),
          initialBinding: MY_Binding(),
          initialRoute: "/",
          home: Home_Screen()
      )
  );




}