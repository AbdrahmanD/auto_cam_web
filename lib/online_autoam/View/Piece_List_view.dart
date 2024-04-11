 import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
  import 'package:auto_cam_web/online_autoam/Controller/Painters/Faces_Painter.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Cut_List_Item.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Piece_List_view extends StatefulWidget {



  @override
  State<Piece_List_view> createState() => _Piece_List_viewState( );
}

class _Piece_List_viewState extends State<Piece_List_view> {
  Draw_Controller draw_controller = Get.find();
   List<Piece_model> pieces = [];

  _Piece_List_viewState() {


      pieces = draw_controller.box_repository.box_model.value.box_pieces;


    // print(pieces.length);
  }





  double material_size_1 = 0;
  double material_size_2 = 0;
  double material_size_3 = 0;


  double material_thickness_1 = 0;
  double material_thickness_2 = 0;
  double material_thickness_3 = 0;

  @override
  void initState() {
    calc_size();
  }

  calc_size() async {

    material_size_1 = 0;
    material_size_2 = 0;
    material_size_3 = 0;



    List<Cut_List_Item> p = await draw_controller.box_repository.cut_list_items;

    material_thickness_1=p[0].material_thickness;

    for(int i=1;i<p.length;i++){
      if(
      material_thickness_2==0 &&
          p[i].material_thickness!=material_thickness_1
      ){
        material_thickness_2=p[i].material_thickness;
      }
      else
        if(
        material_thickness_3==0 &&
          p[i].material_thickness!=material_thickness_1 &&
          p[i].material_thickness!=material_thickness_2
        )
      {
        material_thickness_3=p[i].material_thickness;

      }

    }


    for(int i=0;i<p.length;i++){

      double value=double.parse(((p[i].width/1000)*(p[i].hight/1000)*(p[i].quantity)).toStringAsFixed(2));

      if(material_thickness_1==p[i].material_thickness){
        material_size_1+=value;
      }else if(material_thickness_2==p[i].material_thickness){
        material_size_2+=value;

      }else if(material_thickness_3==p[i].material_thickness){
        material_size_3+=value;
      }




      material_size_1=double.parse("${material_size_1.toStringAsFixed(2)}");
      material_size_2=double.parse("${material_size_2.toStringAsFixed(2)}");
      material_size_3=double.parse("${material_size_3.toStringAsFixed(2)}");


    setState(() {

    });


  }}


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[100],
        child: Row(
          children: [
            Container(
              width: 300,
              color: Colors.grey[300],
              child: Column(
                children: [
                  Container(
                      height: 70,
                      child: Center(
                          child: Text(
                        'List of Box Pieces',
                        style: TextStyle(fontSize: 18),
                      ))),
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                              'to remove any piece from the \n exported files : un check it'))),
                  SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(color:Colors.grey[100],
                        height: 350,
                        child:

                            /// box pieces
                            ListView.builder(
                                itemCount: pieces.length,
                                itemBuilder: (context, i) {
                                  if (pieces[i].piece_name.contains("inner") ||
                                      pieces[i].piece_thickness==0||

                                      pieces[i].piece_name.contains('Helper') ||
                                      ( pieces[i]
                                              .piece_name
                                              .contains('drawer'))) {
                                    return SizedBox();
                                  } else {
                                    return Row(
                                      children: [
                                        Checkbox(
                                            value: pieces[i].piece_inable,
                                            onChanged: (v) {
                                              pieces[i].piece_inable =
                                                  !pieces[i].piece_inable;
                                              setState(() {});
                                            }),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(pieces[i].piece_name)
                                      ],
                                    );
                                  }
                                })),
                  ),

                  SizedBox(
                    height: 56,
                  ),

                  ///Export every piece \n  as G_code file
                  Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        Container(
                            width: 150,
                            child: Text('Export XML files',
                                style: TextStyle(
                                  fontSize: 16,
                                ))),
                        SizedBox(
                          width: 18,
                        ),
                        InkWell(
                            onTap: () {
                              draw_controller.extract_xml_files_pattern();
                            },
                            child: Icon(
                              Icons.view_array_outlined,
                              size: 32,
                              color: Colors.teal,
                            )),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: 12,
                  ),






                  SizedBox(
                    height: 64,
                  ),

                  /// size 1
                  (material_size_1>0)? Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "${material_thickness_1} mm  :",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${material_size_1}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Text(
                        "m2",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ):SizedBox(),

                  SizedBox(
                    height: 12,
                  ),

                  /// size 2
                  (material_size_2>0)?  Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "${material_thickness_2} mm  :",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${material_size_2}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Text(
                        "m2",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ):SizedBox(),
                  SizedBox(
                    height: 12,
                  ),

                  /// size 3
                  (material_size_3>0)? Row(
                    children: [
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        "${material_thickness_3} mm  :",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${material_size_3}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12,
                      ),

                      Text(
                        "m2",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ):SizedBox(),


                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: w-350,
              color: Colors.grey[300],
              child: ListView.builder(
                  itemCount: pieces.length,
                  itemBuilder: (context, i) {
                    if (pieces[i].piece_name.contains("inner") ||
                        pieces[i].piece_thickness==0||

                        pieces[i].piece_direction ==
                            'help_shelf' ||
                        (pieces[i].piece_name.contains('drawer')) ||
                        pieces[i].piece_name
                            .contains("Helper")) {
                      return SizedBox();
                    } else if (pieces[i].piece_inable) {
                      return Column(
                        children: [
                          Container(
                              width: 500,
                              color: Colors.white,
                              height: 700,
                              child: CustomPaint(
                                painter: Faces_Painter(pieces[i]),
                              )),
                          SizedBox(
                            height: 33,
                          )
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
            SizedBox(
              width: 12,
            ),

          ],
        ),
      ),
    );
  }
}

