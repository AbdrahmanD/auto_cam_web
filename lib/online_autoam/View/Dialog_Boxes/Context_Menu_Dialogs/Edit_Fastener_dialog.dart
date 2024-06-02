import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit_Fastener_dialog extends StatefulWidget {
  const Edit_Fastener_dialog({Key? key}) : super(key: key);

  @override
  State<Edit_Fastener_dialog> createState() => _Edit_Fastener_dialogState();
}

class _Edit_Fastener_dialogState extends State<Edit_Fastener_dialog> {

  bool chosing_fastener_type=false;
  Draw_Controller draw_controller = Get.find();
  List<String> templets_names=["dowel" , "confirm screw" , "mini fix"];


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 300,height: 400,
      child: Column(
        children: [
          Text("data"),
          ///chose chosing_fastener_type
          Padding(
            padding: const EdgeInsets.only(left: 24,right: 24),
            child: InkWell(onTap: (){
              chosing_fastener_type=!chosing_fastener_type;setState(() {

              });
            },
              child: Container(
                height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.teal[200]),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'change fastener type',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                    !chosing_fastener_type?
                    Container(width:40,height:40,child: Icon(Icons.add_circle_outline,color: Colors.black,)):
                    Container(width:40,height:40,child: Icon(Icons.remove_circle_outline,color: Colors.red))
                  ],
                ),
              ),
            ),
          ),
          if (chosing_fastener_type) Container(
              width: 532,color: Colors.grey[200],
              height: templets_names.length*40,
              child: Center(
                child: ListView.builder(
                    itemCount: templets_names.length,
                    itemBuilder: (context,i){
                      return Container(height: 40,
                        child: Center(
                          child: InkWell(onTap: (){
                            chosing_fastener_type=false;
                            Fastener_Templet temp=draw_controller.box_repository.dowel_templet;
if(templets_names[i]=="mini fix"){
  temp=draw_controller.box_repository.mini_fix;
}
else if(templets_names[i]=="confirm screw"){
  temp=draw_controller.box_repository.confirm_screw;

}
else if(templets_names[i]=="dowel"){
  temp=draw_controller.box_repository.dowel_templet;

}
draw_controller.change_fastener_templet(temp);

setState(() {

});
                            Navigator.of(Get.overlayContext!).pop();

                          },
                            child: Text(
                              templets_names[i],
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
              )) else SizedBox(),


        ],
      ),
    );
  }
}
