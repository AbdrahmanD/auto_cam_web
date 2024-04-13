import 'package:auto_cam_web/online_autoam/Controller/Active_controller.dart';
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Excel_Controller.dart';
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Firebase_controller.dart';
  import 'package:auto_cam_web/online_autoam/Controller/Repositories_Controllers/Box_Repository.dart';
 import 'package:get/get.dart';

class MY_Binding extends Bindings{

  @override
  void dependencies() {

   Get.lazyPut(()=> Box_Repository());
   Get.lazyPut(()=> Excel_Controller());
   Get.lazyPut(()=> Draw_Controller());
    Get.lazyPut(()=> Active_controller());
    Get.lazyPut(()=> Firebase_caontroller());


  }

}