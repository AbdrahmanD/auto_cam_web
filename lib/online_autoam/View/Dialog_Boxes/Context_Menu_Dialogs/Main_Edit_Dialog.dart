 import 'package:auto_cam_web/online_autoam/Controller/Main_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/ADD_BOX.dart';
import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Door_Dialog.dart';
import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Drawer_Dialog.dart';
 import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Partition_Dialog.dart';
import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Shelf_Dialog.dart';
 import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_Support_Dialog.dart';
import 'package:auto_cam_web/online_autoam/View/Dialog_Boxes/Context_Menu_Dialogs/Add_back_panel_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main_Edit_Dialog extends StatelessWidget {


  Draw_Controller draw_controller=Get.find();




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// add shelf
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add shelf',
                content: Add_Shelf_Dialog()
            );
            },
          child: Text(
            'Add Shelf',
            style: TextStyle(fontSize: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),

        /// add Partition
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add Partition',
                content: Add_Partition_Dialog()
            );
          },
          child: Text(
            'Add Partition',
            style: TextStyle(fontSize: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),

        ///add Drawer
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add Drawer',
                content: Add_Drawer_Dialog()
            );
          },
          child: Text(
            'Add Drawer',
            style: TextStyle(fontSize: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),

        ///add Door
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add Door',
                content: Add_Door_Dialog()
            );
            // draw_controller.add_door(1.5);
          },
          child: Text(
            'Add Door',
            style: TextStyle(fontSize: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),


        ///add filler
        // InkWell(
        //   onTap: () {
        //     Navigator.of(Get.overlayContext!).pop();
        //     Get.defaultDialog(
        //         title: 'add Filler',
        //         content: Add_Filler_Dialog(true)
        //     );
        //     // draw_controller.add_door(1.5);
        //   },
        //   child: Text(
        //     'Add Filler',
        //     style: TextStyle(fontSize: 18),
        //   ),
        // ),
        //
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Divider(
        //     height: 1,
        //     color: Colors.blueGrey,
        //   ),
        // ),

        /// add support
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add support',
                content: Add_Support_Dialog()
            );
          },
          child: Text(
            'Add Support',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),


        ///add back panel
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add back panel',
                content: Add_back_panel_Dialog()
            );
            // draw_controller.add_door(1.5);
          },
          child: Text(
            'Add back Panel',
            style: TextStyle(fontSize: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),


        ///add box
        InkWell(
          onTap: () {
            Navigator.of(Get.overlayContext!).pop();
            Get.defaultDialog(
                title: 'add BOX',
                content: ADD_BOX()
            );
            // draw_controller.add_door(1.5);
          },
          child: Text(
            'Add BOX',
            style: TextStyle(fontSize: 18),
          ),
        ),


      ],
    );
  }
}
