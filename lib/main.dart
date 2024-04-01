import 'dart:ui';

import 'package:auto_cam_web/online_autoam/Controller/MY_Binding.dart';
import 'package:auto_cam_web/web_bages/Main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {

  await GetStorage.init();

  runApp(
      GetMaterialApp(
          scrollBehavior: MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
          ),
          initialBinding: MY_Binding(),
          home: Main_Screen()
      )
  );
}