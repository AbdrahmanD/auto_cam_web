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
          apiKey: "AIzaSyDfIotM6QYft8vM78-IS1JoGpMlBcdahi4",
          authDomain: "autocam-5f9b9.firebaseapp.com",
           projectId: "autocam-5f9b9",
          storageBucket: "autocam-5f9b9.appspot.com",
          messagingSenderId: "374244028436",
          appId: "1:374244028436:web:7ed439f93884db4c9cf701",
          databaseURL:"https://autocam-5f9b9-default-rtdb.firebaseio.com/"
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
          home: Home_Screen()
      )
  );
}