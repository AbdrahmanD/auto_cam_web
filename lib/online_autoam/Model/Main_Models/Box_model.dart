import 'dart:math';

import 'package:auto_cam_web/online_autoam/Model/Main_Models/Door_Model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener_shape_3d.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Group_model.dart';
 import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Box_model {
  late String box_name;
  late String box_type;
  late double box_width;
  late double box_height;
  late double box_depth;
  late double init_material_thickness;
  late String init_material_name;
  late double back_panel_thickness;
  late double grove_value;
 late double bac_panel_distence;
 late double top_base_piece_width;
 late bool   is_back_panel;
 late Point_model box_origin;
   List<Piece_model> box_pieces=[];
   List<Group_model> box_groups=[];
   List<List<Group_model> > drawer_groups=[];
   List<Piece_model> box_deleted_pieces=[];
   int piece_id=0;
   List<Fastener> fasteners=[];
   List<Fastener_shape_3d> fasteners_shape_3d=[];


  Box_model(
      this.box_name,
      this.box_type,
      this.box_width,
      this.box_height,
      this.box_depth,
      this.init_material_thickness,
      this.init_material_name,
      this.back_panel_thickness,
      this.grove_value,
      this.bac_panel_distence,
      this.top_base_piece_width,
      this.is_back_panel,
      this.box_origin
      )

  {
    if(box_type=="wall_cabinet")
    { wall_cabinet();}

    if(box_type=="free_panel")
    { free_panel();}

    else if(box_type=="base_cabinet")
    { base_cabinet();}

    else if(box_type=="sink_cabinet")
    { sink_cabinet();}

    else if(box_type=="inner_cabinet")
    { inner_cabinet();}


    else if(box_type=="standard_unit")
    { standard_unit();}


    fasteners=[];


  }

  Box_model.fromJson(Map<String, dynamic> json) {
    box_name = json['box_name'];
    box_type = json['box_type'];
    box_width = json['box_width'];
    box_height = json['box_height'];
    box_depth = json['box_depth'];
    init_material_thickness = json['init_material_thickness'];
    init_material_name = json['init_material_name'];
    back_panel_thickness = json['back_panel_thickness'];
    grove_value = json['grove_value'];
    bac_panel_distence = json['bac_panel_distence'];
    top_base_piece_width = json['top_base_piece_width'];
    is_back_panel = json['is_back_panel'];
    box_origin =Point_model.fromJson(json['box_origin']) ;
  if (json['box_pieces'] != null) {
    box_pieces = <Piece_model>[];
  json['box_pieces'].forEach((v) { box_pieces!.add(new Piece_model.fromJson(v)); });
  }
  if (json['box_groups'] != null) {
    box_groups = <Group_model>[];
  json['box_groups'].forEach((v) { box_groups!.add( Group_model.from_json(v)); });

  }
    piece_id = json['piece_id'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['box_name'] = this.box_name;
  data['box_type'] = this.box_type;
  data['box_width'] = this.box_width;
  data['box_height'] = this.box_height;
  data['box_depth'] = this.box_depth;
  data['init_material_thickness'] = this.init_material_thickness;
  data['init_material_name'] = this.init_material_name;
  data['back_panel_thickness'] = this.back_panel_thickness;
  data['grove_value'] = this.grove_value;
  data['bac_panel_distence'] = this.bac_panel_distence;
  data['top_base_piece_width'] = this.top_base_piece_width;
  data['is_back_panel'] = this.is_back_panel;
  if (this.box_origin != null) {
    data['box_origin'] = this.box_origin!.toJson();
  }
  if (this.box_pieces != null) {
    data['box_pieces'] = this.box_pieces!.map((v) => v.toJson()).toList();
  }
  if (this.box_groups != null) {
    data['box_groups'] = this.box_groups!.map((v) => v.toJson()).toList();
  }
  data['piece_id'] = this.piece_id;
  return data;
}

  String  get_id(String piece_name){
    piece_id++;
    String piece_ID= first_chart_every_word_with_random_num(piece_name);

    return "${box_name}_$piece_ID";
  }


  standard_unit() {
    Piece_model  top_piece = Piece_model(
        get_id("TOP"),
        'top',
        'H',
        init_material_name,
        correct_value(box_depth),
        correct_value( box_width),
        correct_value( init_material_thickness),
        Point_model(
            correct_value(box_origin.x_coordinate),
            correct_value(box_origin.y_coordinate + box_height - init_material_thickness),
            correct_value(box_origin.z_coordinate)
        )
    );
    box_pieces.add(top_piece);

    Piece_model  base_piece = Piece_model(
        get_id("BASE"),
        'base',
        'H',
        init_material_name,
        correct_value(box_depth),
        correct_value( box_width - 2 * init_material_thickness),
        correct_value(init_material_thickness),
        Point_model(
            correct_value( box_origin.x_coordinate + init_material_thickness),
            correct_value( box_origin.y_coordinate ),
            correct_value( box_origin.z_coordinate)
        )
    );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id("RIGHT"),
        'right',
        'V',
        init_material_name,
        correct_value( box_depth),
        correct_value( box_height-init_material_thickness),
        correct_value( init_material_thickness),
        Point_model(
            correct_value(box_origin.x_coordinate+box_width - init_material_thickness),
            correct_value(box_origin.y_coordinate) ,
            correct_value(box_origin.z_coordinate)
        )
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id("LEFT"),
        'left',
        'V',
        init_material_name,
        correct_value( box_depth),
        correct_value( box_height-init_material_thickness),
        correct_value( init_material_thickness),
        Point_model(
            correct_value( box_origin.x_coordinate),
            correct_value( box_origin.y_coordinate ),
            correct_value( box_origin.z_coordinate)
        )
    );
    box_pieces.add(left_piece);

    // if(is_back_panel){
    //   Piece_model  back_panel = Piece_model(
    //       get_id("BP"),
    //       'back_panel',
    //       'F',
    //       init_material_name,
    //       correct_value(box_width-2*init_material_thickness+2*grove_value-1),
    //       correct_value(box_height-2*init_material_thickness+2*grove_value-1),
    //       correct_value(back_panel_thickness),
    //       Point_model(
    //           correct_value( box_origin.x_coordinate+init_material_thickness-grove_value+1),
    //           correct_value( box_origin.y_coordinate+init_material_thickness-grove_value+1 ),
    //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       )
    //   );
    //
    //   Piece_model  back_panel_Helper = Piece_model(
    //       get_id("Helper"),
    //       'back_panel_Helper',
    //       'F',
    //       init_material_name,
    //       correct_value(box_width-2*init_material_thickness),
    //       correct_value(box_height-2*init_material_thickness),
    //       correct_value(back_panel_thickness),
    //       Point_model(
    //           correct_value( box_origin.x_coordinate+init_material_thickness),
    //           correct_value( box_origin.y_coordinate+init_material_thickness ),
    //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       )
    //   );
    //
    //   box_pieces.add(back_panel);
    //   box_pieces.add(back_panel_Helper);
    // }
    // //
    // // Piece_model  inner = Piece_model(
    // //     get_id("inner"),
    // //     'inner_0',
    // //     'F',
    // //     'inner',
    // //     correct_value( box_width-2*init_material_thickness),
    // //     correct_value( box_height-2*init_material_thickness),
    // //     correct_value( (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
    // //     Point_model(
    // //         correct_value(box_origin.x_coordinate+init_material_thickness),
    // //         correct_value(box_origin.y_coordinate+init_material_thickness) ,
    // //         correct_value(box_origin.z_coordinate)
    // //     ),""
    // // );
    // // box_pieces.add(inner);




  }


  free_panel() {
    Piece_model  top_piece = Piece_model(
        get_id("TOP"),
        'top',
        'H',
        "helper",
        box_depth,
        box_width,
        0,
        Point_model(
            correct_value(box_origin.x_coordinate),
            correct_value(box_origin.y_coordinate + box_height ),
            correct_value(box_origin.z_coordinate)
        )
    );
    box_pieces.add(top_piece);

    Piece_model  base_piece = Piece_model(
        get_id("BASE"),
        'base',
        'H',
        "helper",
        box_depth,
         box_width,
         0,
        Point_model(
            correct_value( box_origin.x_coordinate),
            correct_value( box_origin.y_coordinate ),
            correct_value( box_origin.z_coordinate)
        )
    );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id("RIGHT"),
        'right',
        'V',
        "helper",
        box_depth,
         box_height,
         0,
        Point_model(
            correct_value(box_origin.x_coordinate+box_width),
            correct_value(box_origin.y_coordinate) ,
            correct_value(box_origin.z_coordinate)
        )
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id("LEFT"),
        'left',
        'V',
        "helper",
        box_depth,
      box_height,
      0,
        Point_model(
            correct_value( box_origin.x_coordinate),
            correct_value( box_origin.y_coordinate ),
            correct_value( box_origin.z_coordinate)
        )
    );
    box_pieces.add(left_piece);




  }


  wall_cabinet()
  {
    Piece_model  top_piece = Piece_model(
        get_id("TOP"),
        'top',
        'H',
        init_material_name,
        correct_value(box_depth),
       correct_value( box_width - 2 * init_material_thickness),
       correct_value( init_material_thickness),
        Point_model(
            correct_value(box_origin.x_coordinate + init_material_thickness),
            correct_value(box_origin.y_coordinate + box_height - init_material_thickness),
            correct_value(box_origin.z_coordinate)
        ),
    );
    box_pieces.add(top_piece);

    Piece_model  base_piece = Piece_model(
        get_id("BASE"),
        'base',
        'H',
        init_material_name,
        correct_value(box_depth),
            correct_value( box_width - 2 * init_material_thickness),
                correct_value(init_material_thickness),
        Point_model(
           correct_value( box_origin.x_coordinate + init_material_thickness),
           correct_value( box_origin.y_coordinate ),
           correct_value( box_origin.z_coordinate)
        ),
    );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id("RIGHT"),
        'right',
        'V',
        init_material_name,
       correct_value( box_depth),
       correct_value( box_height),
       correct_value( init_material_thickness),
        Point_model(
           correct_value(box_origin.x_coordinate+box_width - init_material_thickness),
           correct_value(box_origin.y_coordinate) ,
           correct_value(box_origin.z_coordinate)
        ),
    );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id("LEFT"),
        'left',
        'V',
        init_material_name,
       correct_value( box_depth),
       correct_value( box_height),
       correct_value( init_material_thickness),
        Point_model(
          correct_value( box_origin.x_coordinate),
          correct_value( box_origin.y_coordinate ),
          correct_value( box_origin.z_coordinate)
        ),
    );
    box_pieces.add(left_piece);

    // if(is_back_panel){
    //   Piece_model  back_panel = Piece_model(
    //       get_id("BP"),
    //       'back_panel',
    //       'F',
    //       init_material_name,
    //      correct_value(box_width-2*init_material_thickness+2*grove_value-1),
    //      correct_value(box_height-2*init_material_thickness+2*grove_value-1),
    //      correct_value(back_panel_thickness),
    //       Point_model(
    //          correct_value( box_origin.x_coordinate+init_material_thickness-grove_value+1),
    //          correct_value( box_origin.y_coordinate+init_material_thickness-grove_value+1 ),
    //          correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       ),
    //   );
    //
    //   Piece_model  back_panel_Helper = Piece_model(
    //       get_id("Helper"),
    //       'back_panel_Helper',
    //       'F',
    //       init_material_name,
    //       correct_value(box_width-2*init_material_thickness),
    //       correct_value(box_height-2*init_material_thickness),
    //       correct_value(back_panel_thickness),
    //       Point_model(
    //           correct_value( box_origin.x_coordinate+init_material_thickness),
    //           correct_value( box_origin.y_coordinate+init_material_thickness ),
    //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       ),
    //   );
    //
    //   box_pieces.add(back_panel);
    //   box_pieces.add(back_panel_Helper);
    // }
    // //
    // // Piece_model  inner = Piece_model(
    // //     get_id("inner"),
    // //     'inner_0',
    // //     'F',
    // //     'inner',
    // //    correct_value( box_width-2*init_material_thickness),
    // //    correct_value( box_height-2*init_material_thickness),
    // //    correct_value( (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
    // //     Point_model(
    // //        correct_value(box_origin.x_coordinate+init_material_thickness),
    // //        correct_value(box_origin.y_coordinate+init_material_thickness) ,
    // //        correct_value(box_origin.z_coordinate)
    // //     ),""
    // // );
    // // box_pieces.add(inner);




  }

  base_cabinet()
  {
    Piece_model  top_piece_1 = Piece_model(
        get_id("Top 1"),
        'top_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate)
         );
    Piece_model  top_piece_2 = Piece_model(
        get_id("Top 2"),
        'top_2',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate+box_depth-top_base_piece_width)
      );

    box_pieces.add(top_piece_1);
    box_pieces.add(top_piece_2);

    Piece_model  base_piece = Piece_model(
        get_id("Base"),
        'base',
        'H',
        init_material_name,
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
         );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id("Rught"),
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate+box_width - init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
         );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id("Left"),
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate,
            box_origin.y_coordinate ,box_origin.z_coordinate)
       );
    box_pieces.add(left_piece);
    //
    // if(is_back_panel){
    //   Piece_model  back_panel = Piece_model(
    //       get_id("BP"),
    //       'back_panel',
    //       'F',
    //       init_material_name,
    //       box_width-2*init_material_thickness+2*grove_value-1,
    //       box_height-2*init_material_thickness+2*grove_value-1,
    //       back_panel_thickness,
    //       Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
    //           box_origin.y_coordinate+init_material_thickness-grove_value+1
    //           ,box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //         );
    //   Piece_model  back_panel_Helper = Piece_model(
    //       get_id("Helper"),
    //       'back_panel_Helper',
    //       'F',
    //       init_material_name,
    //       correct_value(box_width-2*init_material_thickness),
    //       correct_value(box_height-2*init_material_thickness),
    //       correct_value(back_panel_thickness),
    //       Point_model(
    //           correct_value( box_origin.x_coordinate+init_material_thickness),
    //           correct_value( box_origin.y_coordinate+init_material_thickness ),
    //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       )
    //     );
    //
    //   box_pieces.add(back_panel);
    //   box_pieces.add(back_panel_Helper);
    // }
    // // Piece_model  inner = Piece_model(
    // //     get_id("inner"),
    // //     'inner_0',
    // //     'F',
    // //     'inner',
    // //     box_width-2*init_material_thickness,
    // //     box_height-2*init_material_thickness,
    // //     (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
    // //
    // //     Point_model(box_origin.x_coordinate+init_material_thickness,
    // //         box_origin.y_coordinate+init_material_thickness ,
    // //         box_origin.z_coordinate)
    // //     ,"" );
    // // box_pieces.add(inner);

  }


  sink_cabinet()
  {

    Piece_model  top_piece_1 = Piece_model(
        get_id("Top 1"),
        'top_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate)
        );

    double back_distance=bac_panel_distence+back_panel_thickness/2+init_material_thickness/2;
    Piece_model  top_piece_2 = Piece_model(
        get_id("Top 2"),
        'top_2',
        'F',
        init_material_name,
        box_width - 2 * init_material_thickness,
        top_base_piece_width,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height -top_base_piece_width,
            box_origin.z_coordinate+box_depth-back_distance)
         );

    box_pieces.add(top_piece_1);
    box_pieces.add(top_piece_2);

    Piece_model  base_piece = Piece_model(
        get_id("Base"),
        'base',
        'H',
        init_material_name,
        box_depth,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
        );
    box_pieces.add(base_piece);

    Piece_model  right_piece = Piece_model(
        get_id("Rught"),
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate+box_width - init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
         );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id("Left"),
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate,
            box_origin.y_coordinate ,box_origin.z_coordinate)
         );
    box_pieces.add(left_piece);

    // if(is_back_panel){
    //   Piece_model  back_panel = Piece_model(
    //       get_id("BP"),
    //       'back_panel',
    //       'F',
    //       init_material_name,
    //       box_width-2*init_material_thickness+2*grove_value-1,
    //       box_height-top_base_piece_width- init_material_thickness+2*grove_value-1,
    //       back_panel_thickness,
    //       Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
    //           box_origin.y_coordinate+init_material_thickness-grove_value+1
    //           ,box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //        );
    //   Piece_model  back_panel_Helper = Piece_model(
    //       get_id("Helper"),
    //       'back_panel_Helper',
    //       'F',
    //       init_material_name,
    //       correct_value(box_width-2*init_material_thickness),
    //       correct_value(box_height- init_material_thickness-top_base_piece_width),
    //       correct_value(back_panel_thickness),
    //       Point_model(
    //           correct_value( box_origin.x_coordinate+init_material_thickness),
    //           correct_value( box_origin.y_coordinate+init_material_thickness ),
    //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       )
    //       );
    //
    //   box_pieces.add(back_panel);
    //   box_pieces.add(back_panel_Helper);
    // }
    // // Piece_model  inner = Piece_model(
    // //     get_id("inner"),
    // //     'inner_0',
    // //     'F',
    // //     'inner',
    // //     box_width-2*init_material_thickness,
    // //     box_height-2*init_material_thickness,
    // //     (is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth),
    // //
    // //     Point_model(box_origin.x_coordinate+init_material_thickness,
    // //         box_origin.y_coordinate+init_material_thickness ,
    // //         box_origin.z_coordinate)
    // //     ,"" );
    // // box_pieces.add(inner);

  }


  inner_cabinet()
  {
    Piece_model  top_piece_1 = Piece_model(
        get_id("Top 1"),
        'top_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,box_origin.z_coordinate)
        );
    Piece_model  top_piece_2 = Piece_model(
        get_id("Top 2"),
        'top_2',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate + box_height - init_material_thickness,
            box_origin.z_coordinate+box_depth-top_base_piece_width)
        );

    box_pieces.add(top_piece_1);
    box_pieces.add(top_piece_2);

    Piece_model  base_piece_1 = Piece_model(
        get_id("Base 1"),
        'base_1',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate+box_depth-top_base_piece_width)
         );
    Piece_model  base_piece_2 = Piece_model(
        get_id("Base 2"),
        'base_2',
        'H',
        init_material_name,
        top_base_piece_width,
        box_width - 2 * init_material_thickness,
        init_material_thickness,
        Point_model(box_origin.x_coordinate + init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
       );

    box_pieces.add(base_piece_1);
    box_pieces.add(base_piece_2);

    Piece_model  right_piece = Piece_model(
        get_id("Right"),
        'right',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate+box_width - init_material_thickness,
            box_origin.y_coordinate ,box_origin.z_coordinate)
         );
    box_pieces.add(right_piece);

    Piece_model  left_piece = Piece_model(
        get_id("Left"),
        'left',
        'V',
        init_material_name,
        box_depth,
        box_height,
        init_material_thickness,
        Point_model(box_origin.x_coordinate,
            box_origin.y_coordinate ,box_origin.z_coordinate)
        );
    box_pieces.add(left_piece);

    // if(is_back_panel){
    //   Piece_model  back_panel = Piece_model(
    //       get_id("BP"),
    //       'back_panel',
    //       'F',
    //       init_material_name,
    //       box_width-2*init_material_thickness+2*grove_value-1,
    //       box_height-2*init_material_thickness+2*grove_value-1,
    //       back_panel_thickness,
    //       Point_model(box_origin.x_coordinate+init_material_thickness-grove_value+1,
    //           box_origin.y_coordinate+init_material_thickness-grove_value+1 ,
    //           box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //         );
    //   Piece_model  back_panel_Helper = Piece_model(
    //       get_id("Helper"),
    //       'back_panel_Helper',
    //       'F',
    //       init_material_name,
    //       correct_value(box_width-2*init_material_thickness),
    //       correct_value(box_height-2*init_material_thickness),
    //       correct_value(back_panel_thickness),
    //       Point_model(
    //           correct_value( box_origin.x_coordinate+init_material_thickness),
    //           correct_value( box_origin.y_coordinate+init_material_thickness ),
    //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
    //       )
    //       );
    //
    //   box_pieces.add(back_panel);
    //   box_pieces.add(back_panel_Helper);
    // }
    // // Piece_model  inner = Piece_model(
    // //     get_id("inner"),
    // //     'inner_0',
    // //     'F',
    // //     'inner',
    // //     box_width-2*init_material_thickness,
    // //     box_height-2*init_material_thickness,
    // //     0,
    // //     Point_model(box_origin.x_coordinate+init_material_thickness,
    // //         box_origin.y_coordinate+init_material_thickness ,
    // //         box_origin.z_coordinate)
    // //     ,"");
    // // box_pieces.add(inner);

  }





  add_Shelf_pattern(Point_model origin, double width, double height, double shelf_material_thickness, String shelf_type )
  {

    Piece_model new_piece = Piece_model(
      get_id("Shelf"),
        '$shelf_type',
       'H',
        init_material_name,
        width,
        height,
        shelf_material_thickness,
        origin.correct_cordinate()
         );

     box_pieces.add(new_piece);

  }

  add_Shelf(int inner,
      double frontage_Gap, double shelf_material_thickness,
      double top_Distence,int Quantity, String shelf_type,) {

    Piece_model inner_piece=box_pieces[inner];
    double shelf_width=inner_piece.piece_thickness-(frontage_Gap);
    double shelf_height=inner_piece.piece_width;






    if (Quantity == 1) {
      if (box_pieces[inner].piece_height > top_Distence && top_Distence >= 0)
      {
        Point_model origin=Point_model(
            inner_piece.piece_origin.x_coordinate,
            inner_piece.piece_origin.y_coordinate+inner_piece.piece_height-top_Distence-shelf_material_thickness,
            inner_piece.piece_origin.z_coordinate+frontage_Gap
        );

        add_Shelf_pattern(origin, shelf_width, shelf_height, shelf_material_thickness, shelf_type);
        Navigator.of(Get.overlayContext!).pop();
      }
      else
      {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }

    else {
      if (((Quantity - 1) * top_Distence +
              Quantity * shelf_material_thickness) <
          box_pieces[inner].piece_height) {

        double distance_0 = double.parse(
            (
                (box_pieces[inner].piece_height - Quantity * shelf_material_thickness) / (Quantity+1)
            ).toStringAsFixed(1)
        );

        double distance =distance_0;
        List<Point_model> origins=[];

        for (int i = 0; i < Quantity; i++) {

         Point_model origin_i=Point_model(
             box_pieces[inner].piece_origin.x_coordinate,
             box_pieces[inner].piece_origin.y_coordinate+distance,
             box_pieces[inner].piece_origin.z_coordinate+frontage_Gap);

         origins.add(origin_i);
         distance+=distance_0+shelf_material_thickness;

        }

        for (int i = 0; i < Quantity; i++) {

          add_Shelf_pattern(origins[i], shelf_width, shelf_height, shelf_material_thickness, shelf_type);
        }

        Navigator.of(Get.overlayContext!).pop();


      }

      else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }

  /// start Partition

  add_Partition_pattern(Point_model origin, double width, double height, double partition_material_thickness,
      String partition_type )
  {

    Piece_model new_piece = Piece_model(
        get_id("partitin"),
        '$partition_type',
        'V',
        init_material_name,
        width,
        height,
        partition_material_thickness,
        origin.correct_cordinate()
    );



    box_pieces.add(new_piece);

  }

  add_Partition(int inner,
      double frontage_Gap, double partition_material_thickness,
      double left_Distence,int Quantity, String partition_type,) {

    Piece_model inner_piece=box_pieces[inner];
    double partition_width=inner_piece.piece_thickness-(frontage_Gap);
    double partition_height=inner_piece.piece_height;

    if (Quantity == 1) {
      if (box_pieces[inner].piece_width > left_Distence && left_Distence >= 0) {

        Point_model origin=Point_model(
            inner_piece.piece_origin.x_coordinate+left_Distence,
            inner_piece.piece_origin.y_coordinate,
            inner_piece.piece_origin.z_coordinate+frontage_Gap
        );

        add_Partition_pattern(origin, partition_width, partition_height, partition_material_thickness, partition_type);
        Navigator.of(Get.overlayContext!).pop();
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }

    else {
      if (((Quantity - 1) * left_Distence +
          Quantity * partition_material_thickness) <
          box_pieces[inner].piece_width) {

        double distance_0 = double.parse(
            (
                (box_pieces[inner].piece_width - Quantity * partition_material_thickness) / (Quantity+1)
            ).toStringAsFixed(1)
        );

        double distance =distance_0;

        double x = box_pieces[inner].piece_origin.x_coordinate;
        double y = box_pieces[inner].piece_origin.y_coordinate;
        double z = box_pieces[inner].piece_origin.z_coordinate+frontage_Gap;

        for (int i = 0; i < Quantity; i++) {

          Point_model origin=Point_model(
              x+distance,
              y,
              z);

           distance+=distance_0+partition_material_thickness;
          add_Partition_pattern(origin, partition_width, partition_height,
              partition_material_thickness, partition_type);

        }



        Navigator.of(Get.overlayContext!).pop();


      }

      else {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }



  ///
  /// support

  add_vertical_support_pattern(int inner, double left_Distence, double width,
      double partition_material_thickness )
  {

    Piece_model new_piece = Piece_model(
        get_id("support"),
        'support${piece_id}',
        'F',
        init_material_name,
        correct_value( width),
        correct_value( box_pieces[inner].piece_height),
        correct_value( partition_material_thickness),
        Point_model(
          correct_value( box_pieces[inner].piece_origin.x_coordinate + left_Distence)  ,
          correct_value( box_pieces[inner].piece_origin.y_coordinate  )  ,
          correct_value( box_pieces[inner].piece_origin.z_coordinate )  ,
        ),
    );

    box_pieces.add(new_piece);

  }

  add_vertical_support(int inner, double left_Distence, double width,
      double partition_material_thickness, int Quantity)
  {
    if (Quantity == 1) {
      add_vertical_support_pattern(inner, left_Distence, width, partition_material_thickness );
        Navigator.of(Get.overlayContext!).pop();

    }


    else {

      if (
      ( Quantity * (width)) < box_pieces[inner].piece_width
      )
      {
        double distance = double.parse(((box_pieces[inner].piece_width - Quantity * width)
            / (Quantity + 1))
            .toStringAsFixed(1));

        add_vertical_support_pattern(inner, distance, width,  partition_material_thickness  );

        double abs_value=distance;
        for (int i = 1; i < Quantity; i++) {
          distance+=abs_value+width;
          add_vertical_support_pattern(inner, distance,width, partition_material_thickness );

        }


        Navigator.of(Get.overlayContext!).pop();


      }
      else
      {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }
  }




  add_horizontal_support_pattern(int inner, double down_distance, double width,
      double partition_material_thickness )
  {


    Piece_model new_piece = Piece_model(
        get_id("Partition"),
        'support${piece_id}',
        'F',
        init_material_name,
        correct_value( box_pieces[inner].piece_width),
        correct_value( width),
        correct_value( partition_material_thickness),
        Point_model(
          correct_value( box_pieces[inner].piece_origin.x_coordinate )  ,
          correct_value( box_pieces[inner].piece_origin.y_coordinate +down_distance )  ,
          correct_value( box_pieces[inner].piece_origin.z_coordinate )  ,
        ),
    );


    box_pieces.add(new_piece);


  }

  add_horizontal_support(int inner, double down_distance, double width,
      double partition_material_thickness, int Quantity)
  {

    if (Quantity == 1) {
      add_horizontal_support_pattern(inner, down_distance, width, partition_material_thickness );
      Navigator.of(Get.overlayContext!).pop();
    }

    else {

       if (
      ( Quantity * width) < box_pieces[inner].piece_height
      )
      {
        double distance = double.parse(((box_pieces[inner].piece_height - Quantity * width)
            / (Quantity + 1))
            .toStringAsFixed(1));

        add_horizontal_support_pattern(inner, distance, width,  partition_material_thickness  );

        double abs_value=distance;

        for (int i = 1; i < Quantity; i++) {

          distance+=abs_value+width;
          add_horizontal_support_pattern(inner, distance,width, partition_material_thickness );

        }


        Navigator.of(Get.overlayContext!).pop();


      }
      else
      {
        Get.defaultDialog(
            title: 'Error',
            content: Text('you enter wrong value , please check again'));
      }
    }


  }


  ///

  add_door(Door_Model door_model) {
    if (door_model.door_num == 1) {
      if(door_model.fix_door){

        add_fix_door_pattern(door_model);
      }else{
        add_single_door_pattern(door_model);

      }
    }
    else {
      add_double_door_pattern(door_model);
    }
  }

  add_single_door_pattern(Door_Model door_model) {

   late Piece_model door_Hinges_Helper;
    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness =(door_model.inner_door)? (-door_model.right_gap):(init_material_thickness - door_model.right_gap);
    double left_thickness  =(door_model.inner_door)? (-door_model.left_gap):(init_material_thickness - door_model.left_gap);
    double top_thickness   =(door_model.inner_door)? (-door_model.up_gap):(init_material_thickness - door_model.up_gap);
    double base_thickness  =(door_model.inner_door)? (-door_model.down_gap):(init_material_thickness - door_model.down_gap);

    double door_width = door_inner.piece_width +
        right_thickness +
        left_thickness ;

    double door_hight = door_inner.piece_height +
        top_thickness +
        base_thickness ;



    Point_model door_origin = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness ,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness-2 ):
        (door_inner.piece_origin.z_coordinate)
    );

    String id=get_id("Door ${door_model.direction}");

    Piece_model door_piece = Piece_model(
      id,
        (door_model.direction=="R")?('Door right'):('Door left'),
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin,
         );
    // door_piece.piece_inner=door_inner;

    double hw=(correct_value((22.5-(init_material_thickness - door_model.right_gap))*2));


    double hh=init_material_thickness;
    if(door_model.inner_door){
      hh=door_hight;
    }
    else{
      if(door_model.up_gap > init_material_thickness)
      {
        hh=door_hight-init_material_thickness+door_model.down_gap-0.5;
      }
      else{
       hh= door_inner.piece_height - 1;
      }
    }
    double hth=76;

    if(door_model.direction=="R"){

      Point_model door_helper_origin = Point_model(
          door_inner.piece_origin.x_coordinate +door_inner.piece_width-hw ,

          (door_model.inner_door)?
          (door_inner.piece_origin.y_coordinate+door_model.down_gap):
          (door_inner.piece_origin.y_coordinate+0.5)  ,

          ! (door_model.inner_door)?
          (door_inner.piece_origin.z_coordinate-2 ):
          (door_inner.piece_origin.z_coordinate+door_model.material_thickness)

      );
        door_Hinges_Helper = Piece_model(
        "${id}_h",
        'Door_Helper',
        'F',
        "Helper",
        hw,
        hh,
        hth,
        door_helper_origin,
      );
      box_pieces.add(door_Hinges_Helper);

    }
   else if(door_model.direction=="L"){

      Point_model door_helper_origin = Point_model(
          door_inner.piece_origin.x_coordinate  ,
          door_inner.piece_origin.y_coordinate +0.5 ,
          (!door_model.inner_door)?
          (door_inner.piece_origin.z_coordinate-2 ):
          (door_inner.piece_origin.z_coordinate)
      );


        door_Hinges_Helper = Piece_model(
        "${id}_h",
        'Door_Helper',
        'F',
        "Helper",
        hw,
        hh,
        hth,
        door_helper_origin,
      );

      box_pieces.add(door_Hinges_Helper);

    }

   if(door_model.inner_door){

     if(door_model.direction=="R"){

       Point_model door_helper_origin = Point_model(
           door_inner.piece_origin.x_coordinate +door_inner.piece_width -door_model.right_gap-32.5,
           door_inner.piece_origin.y_coordinate +door_model.down_gap,
           door_inner.piece_origin.z_coordinate +door_model.material_thickness
       );

         door_Hinges_Helper = Piece_model(
         "${id}_h_door",
         'Door_Helper',
         'F',
         "Helper",
         18,
         door_hight,
         30,
         door_helper_origin,
       );

       box_pieces.add(door_Hinges_Helper);


     }
     else if(door_model.direction=="L"){

       Point_model door_helper_origin = Point_model(
           door_inner.piece_origin.x_coordinate +door_model.left_gap+22.5-9,
           door_inner.piece_origin.y_coordinate +door_model.down_gap,
           door_inner.piece_origin.z_coordinate +door_model.material_thickness
       );


         door_Hinges_Helper = Piece_model(
         "${id}_h_door",
         'Door_Helper',
         'F',
         "Helper",
         18,
         door_hight,
         30,
         door_helper_origin,
       );

       box_pieces.add(door_Hinges_Helper);


     }

   }
   box_pieces.add(door_piece);

    Group_model door_grope=Group_model("Helper",[door_piece,door_Hinges_Helper],true);
    box_groups.add(door_grope);



  }


  add_fix_door_pattern(Door_Model door_model) {

    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness =(door_model.inner_door)? (-door_model.right_gap):(init_material_thickness - door_model.right_gap);
    double left_thickness  =(door_model.inner_door)? (-door_model.left_gap):(init_material_thickness - door_model.left_gap);
    double top_thickness   =(door_model.inner_door)? (-door_model.up_gap):(init_material_thickness - door_model.up_gap);
    double base_thickness  =(door_model.inner_door)? (-door_model.down_gap):(init_material_thickness - door_model.down_gap);

    double door_width = door_inner.piece_width +
        right_thickness +
        left_thickness ;

    double door_hight = door_inner.piece_height +
        top_thickness +
        base_thickness ;



    Point_model door_origin = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness ,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness ):
        (door_inner.piece_origin.z_coordinate)
    );

    String id=get_id("Door");

    Piece_model door_piece = Piece_model(
      id,
        "fix",
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin,
         );


    box_pieces.add(door_piece);

  }

  add_double_door_pattern(Door_Model door_model) {

    Piece_model door_inner = box_pieces[door_model.inner_id];

    double right_thickness =(door_model.inner_door)? (-door_model.right_gap):(init_material_thickness - door_model.right_gap);
    double left_thickness  =(door_model.inner_door)? (-door_model.left_gap):(init_material_thickness - door_model.left_gap);
    double top_thickness   =(door_model.inner_door)? (-door_model.up_gap):(init_material_thickness - door_model.up_gap);
    double base_thickness  =(door_model.inner_door)? (-door_model.down_gap):(init_material_thickness - door_model.down_gap);

    double door_width = double.parse(((door_inner.piece_width +
        right_thickness +
        left_thickness-door_model.center_gap) /
        2 ).toStringAsFixed(1));

    double door_hight = double.parse((door_inner.piece_height +
        top_thickness + base_thickness).toStringAsFixed(1)
    );

    Point_model door_origin_1 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness ,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness -2):
        (door_inner.piece_origin.z_coordinate)
    );

    Point_model door_origin_2 = Point_model(
        door_inner.piece_origin.x_coordinate -
            left_thickness +
            door_width +
            door_model.center_gap,
        door_inner.piece_origin.y_coordinate -
            base_thickness ,
        (!door_model.inner_door)?
        (door_inner.piece_origin.z_coordinate-door_model.material_thickness -2):
        (door_inner.piece_origin.z_coordinate)
    );


    ///  ///////////////////////////////////////


    String id = get_id("Door l");
    Piece_model door_piece_1 = Piece_model(
     id,
        'Door left',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_1,
         );
    String id2 = get_id("Door r");
    Piece_model door_piece_2 = Piece_model(
      id2,
      'Door right',
        'F',
        door_model.material_name,
        door_width,
        door_hight,
        door_model.material_thickness,
        door_origin_2,
         );

    box_pieces.add(door_piece_1);
    box_pieces.add(door_piece_2);



    double hw=correct_value((22.5-(init_material_thickness - door_model.right_gap))*2);



    double hh=init_material_thickness;
    if(door_model.inner_door){
      hh=door_hight;
    }
    else{
      if(door_model.up_gap > init_material_thickness)
      {

        hh=door_hight-init_material_thickness+door_model.down_gap;
      }
      else{
       hh= door_inner.piece_height -door_model.down_gap -door_model.up_gap;
      }
    }

    double hth=76;




    Point_model rdoor_helper_origin = Point_model(
    door_inner.piece_origin.x_coordinate +door_inner.piece_width-hw ,
    door_inner.piece_origin.y_coordinate+door_model.down_gap ,
    (!door_model.inner_door)?
    (door_inner.piece_origin.z_coordinate-2 ):
    (door_inner.piece_origin.z_coordinate+door_model.material_thickness)
    );


    Piece_model rdoor_Hinges_Helper = Piece_model(
    "{$id2}_h",
    'Door_Helper',
    'F',
      "Helper",
    hw,
    hh,
    hth,
    rdoor_helper_origin,
    );


    box_pieces.add(rdoor_Hinges_Helper);





    Point_model ldoor_helper_origin = Point_model(
    door_inner.piece_origin.x_coordinate  ,
    door_inner.piece_origin.y_coordinate+door_model.down_gap ,
    (!door_model.inner_door)?
    (door_inner.piece_origin.z_coordinate-2 ):
    (door_inner.piece_origin.z_coordinate+door_model.material_thickness)
    );


    Piece_model ldoor_Hinges_Helper = Piece_model(
    "${id}_h",
    'Door_Helper',
    'F',
      "Helper",
    hw,
    hh,
    hth,
    ldoor_helper_origin,
    );

    box_pieces.add(ldoor_Hinges_Helper);



    if (door_model.inner_door) {

      Point_model r_door_helper_origin = Point_model(
          door_inner.piece_origin.x_coordinate +door_inner.piece_width -door_model.right_gap-32.5,
          door_inner.piece_origin.y_coordinate +door_model.down_gap,
          door_inner.piece_origin.z_coordinate +door_model.material_thickness
      );

      Piece_model r_door_Hinges_Helper = Piece_model(
        "${id}_h_door",
        'Door_Helper',
        'F',
        "Helper",
        18,
        door_hight,
        30,
        r_door_helper_origin,
      );

      box_pieces.add(r_door_Hinges_Helper);



      Point_model l_door_helper_origin = Point_model(
          door_inner.piece_origin.x_coordinate +door_model.left_gap+22.5-9,
          door_inner.piece_origin.y_coordinate +door_model.down_gap,
          door_inner.piece_origin.z_coordinate +door_model.material_thickness
      );


      Piece_model l_door_Hinges_Helper = Piece_model(
        "${id}_h_door",
        'Door_Helper',
        'F',
        "Helper",
        18,
        door_hight,
        30,
        l_door_helper_origin,
      );

      box_pieces.add(l_door_Hinges_Helper);


      Group_model l_door_grope=Group_model("Helper",[door_piece_1,l_door_Hinges_Helper],true);
      box_groups.add(l_door_grope);

      Group_model r_door_grope=Group_model("Helper",[door_piece_2,r_door_Hinges_Helper],true);
      box_groups.add(r_door_grope);


    }




  }


//   add_filler(Filler_model filler_model , int hover_id){
//
//     double x = 0;
//     double y = 0;
//     double z = 0;
//
//     print((filler_model.corner));
//
//     late double filler_w;
//     late double filler_h;
//     late double filler_th;
//
//     /// filler inside
//     if (filler_model.filler_inside) {
//       if(filler_model.filler_vertical){
//
//         filler_w =box_pieces[hover_id].piece_width;
//         filler_h = filler_model.height;
//         filler_th = filler_model.thickness;
//
//
//         double origin_x=box_pieces[hover_id].piece_origin.x_coordinate;
//         double origin_y=box_pieces[hover_id].piece_origin.y_coordinate;
//         double origin_z=box_pieces[hover_id].piece_origin.z_coordinate;
//
//         if (filler_model.corner == 1) {
//           x = origin_x;
//           y = origin_y + filler_model.y_move;
//           z = origin_z + filler_model.x_move;
//         }
//         else if (filler_model.corner == 2) {
//           x = origin_x;
//           y = origin_y + filler_model.y_move;
//           z = origin_z + filler_model.x_move +   box_depth - ((filler_model.filler_vertical)?filler_th:filler_w );
//         }
//         else if (filler_model.corner == 3) {
//           x = origin_x;
//           y = origin_y + filler_model.y_move +   box_pieces[hover_id].piece_height -
//               ((filler_model.filler_vertical)?filler_h:filler_th ) ;
//           z = origin_z + filler_model.x_move + box_depth  -  ((filler_model.filler_vertical)?filler_th:filler_w );
//         }
//         else if (filler_model.corner == 4){
//           x = origin_x;
//           y = origin_y + filler_model.y_move+  box_pieces[hover_id].piece_height -
//               ((filler_model.filler_vertical)?filler_h:filler_th ) ;
//           z = origin_z + filler_model.x_move;
//         }
//
//
//         Piece_model old_inner = Piece_model(
//             get_id("inner"),
//             '${box_pieces[hover_id].piece_name}_1',
//             'F',
//             'inner',
//             box_pieces[hover_id].piece_width,
//             (filler_model.corner==4)?(box_pieces[hover_id].piece_height-(filler_h)):0,
//             correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
//             Point_model(
//                 box_pieces[hover_id].piece_origin.x_coordinate,
//                 box_pieces[hover_id].piece_origin.y_coordinate,
//                 box_pieces[hover_id].piece_origin.z_coordinate).correct_cordinate()
//             ,"");
//
//         Piece_model new_inner = Piece_model(
//             get_id("inner"),
//             '${box_pieces[hover_id].piece_name}_2',
//             'F',
//             'inner',
//             box_pieces[hover_id].piece_width,
//             (filler_model.corner==4)?0:(box_pieces[hover_id].piece_height-(filler_h)),
//
//             correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
//             Point_model(
//                 box_pieces[hover_id].piece_origin.x_coordinate,
//
//                 (y+filler_h)
//
//                 ,
//
//                 box_pieces[hover_id].piece_origin.z_coordinate).correct_cordinate(),
//             "");
//
//
//
//         Point_model filler_origin = Point_model(x, y, z);
//
//         String id=get_id("Filler");
//
//         Piece_model filler = Piece_model(
//             id ,
//             'filler_$id',
//             "F",
//             init_material_name,
//             filler_w,
//             filler_h,
//             filler_th,
//             filler_origin,box_pieces[hover_id].piece_name);
//
//
//
// if(filler_model.corner==1||filler_model.corner==4){
//   box_pieces.add(old_inner);
//   box_pieces.add(filler);
//   box_pieces.add(new_inner);
//
//   box_deleted_pieces.add(box_pieces[hover_id]);
//   box_pieces.remove(box_pieces[hover_id]);
// }else{
//   box_pieces.add(filler);
//
// }
//
//
//
//
//
//
//       }
//       /// horizontal filler
//       else{
//
//         filler_h = box_pieces[hover_id].piece_width;
//         filler_w = filler_model.height;
//         filler_th = filler_model.thickness;
//
//
//         double origin_x=box_pieces[hover_id].piece_origin.x_coordinate;
//         double origin_y=box_pieces[hover_id].piece_origin.y_coordinate;
//         double origin_z=box_pieces[hover_id].piece_origin.z_coordinate;
//
//         if (filler_model.corner == 1) {
//           x = origin_x;
//           y = origin_y + filler_model.y_move;
//           z = origin_z + filler_model.x_move;
//         }
//         else if (filler_model.corner == 2) {
//           x = origin_x;
//           y = origin_y + filler_model.y_move;
//           z = origin_z + filler_model.x_move +   box_depth - ((filler_model.filler_vertical)?filler_th:filler_w );
//         }
//         else if (filler_model.corner == 3) {
//           x = origin_x;
//           y = origin_y + filler_model.y_move +   box_pieces[hover_id].piece_height -
//               ((filler_model.filler_vertical)?filler_h:filler_th ) ;
//           z = origin_z + filler_model.x_move + box_depth  -  ((filler_model.filler_vertical)?filler_th:filler_w );
//         }
//         else if (filler_model.corner == 4){
//           x = origin_x;
//           y = origin_y + filler_model.y_move+  box_pieces[hover_id].piece_height -
//               ((filler_model.filler_vertical)?filler_h:filler_th ) ;
//           z = origin_z + filler_model.x_move;
//         }
//
//
//
//
//         Piece_model old_inner = Piece_model(
//             get_id("inner"),
//             '${box_pieces[hover_id].piece_name}_1',
//             'F',
//             'inner',
//             box_pieces[hover_id].piece_width,
//             (filler_model.corner==4)?(box_pieces[hover_id].piece_height-(filler_th)):0,
//             correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
//             Point_model(
//                 box_pieces[hover_id].piece_origin.x_coordinate,
//                 box_pieces[hover_id].piece_origin.y_coordinate,
//                 box_pieces[hover_id].piece_origin.z_coordinate).correct_cordinate()
//             ,"");
//
//         Piece_model new_inner = Piece_model(
//             get_id("inner"),
//             '${box_pieces[hover_id].piece_name}_2',
//             'F',
//             'inner',
//             box_pieces[hover_id].piece_width,
//             (filler_model.corner==4)?0:(box_pieces[hover_id].piece_height-(filler_th)),
//
//             correct_value((is_back_panel)?(box_depth-bac_panel_distence-back_panel_thickness):(box_depth)),
//             Point_model(
//                 box_pieces[hover_id].piece_origin.x_coordinate,
//                 (y+filler_th)
//
//
//                 ,
//
//                 box_pieces[hover_id].piece_origin.z_coordinate).correct_cordinate(),
//             "");
//
//
//
//         Point_model filler_origin = Point_model(x, y, z);
//         String id=get_id("Filler");
//
//         Piece_model filler = Piece_model(
//             id ,
//             'filler_$id',
//             "H",
//             init_material_name,
//             filler_w,
//             filler_h,
//             filler_th,
//             filler_origin,box_pieces[hover_id].piece_name);
//
//         if(filler_model.corner==1||filler_model.corner==4){
//           box_pieces.add(old_inner);
//           box_pieces.add(filler);
//           box_pieces.add(new_inner);
//
//           box_deleted_pieces.add(box_pieces[hover_id]);
//           box_pieces.remove(box_pieces[hover_id]);
//         }else{
//           box_pieces.add(filler);
//
//         }
//       }
//     }
//
//     /// filler outside
//     else{
//
//
//       if(filler_model.corner==1||filler_model.corner==2){
//         filler_w=filler_model.width;
//         filler_h=box_height;
//         filler_th=filler_model.thickness;
//       }else{
//         filler_w= box_width;
//         filler_h=filler_model.width ;
//         filler_th=filler_model.thickness;
//
//       }
//       Piece_model p =  box_pieces.where((element) => element.piece_name=="left").first;
//
//       double origin_x=p.piece_origin.x_coordinate;
//       double origin_y=p.piece_origin.y_coordinate;
//       double origin_z=p.piece_origin.z_coordinate;
//
//
//
//
//       if (filler_model.corner == 1) {
//         x = origin_x-filler_model.width;
//         y = origin_y ;
//         z = origin_z ;
//       }
//       else if (filler_model.corner == 2) {
//         x = origin_x+box_width;
//         y = origin_y ;
//         z = origin_z ;
//       }
//       else if (filler_model.corner == 3) {
//         x = origin_x;
//         y = origin_y +box_height  ;
//         z = origin_z  ;
//       }
//       else if (filler_model.corner == 4){
//         x = origin_x;
//         y = origin_y -filler_h ;
//         z = origin_z  ;
//       }
//
//
//
//       Point_model filler_origin = Point_model(x, y, z);
//       String id=get_id("Filler");
//
//       Piece_model filler = Piece_model(
//           id ,
//           'filler_$id',
//           "F",
//           init_material_name,
//           filler_w,
//           filler_h,
//           filler_th,
//           filler_origin,"");
//
//       box_pieces.add(filler);
//     }
//
//   }

  double  correct_value(double v){
    double resault= double.parse(v.toStringAsFixed(2));
    return resault;
  }


  delete_piece(Piece_model piece_model){

   box_pieces.removeWhere((element) => element.piece_id==piece_id);

  }


  String first_chart_every_word(String name){

    List<String> Lbox_name=name.split(" ");
    String nbn;
    if (Lbox_name.length>1) {
      String nn1=Lbox_name[0].substring(0,1);
      String nn2=Lbox_name[1].substring(0,1);
      nbn="$nn1$nn2";
    }else{
      String nn1=Lbox_name[0].substring(0,2);
      nbn="$nn1";
    }

    return nbn;
  }



  String first_chart_every_word_with_random_num(String name){

    String nbn="";

    String nn=first_chart_every_word(name);
    int n = Random().nextInt(1000);
    if(n<10){
      nbn="${nn}_00${n}";

    }else if(n>10&&n<100){
      nbn="${nn}_0${n}";

    }else{
      nbn="${nn}_${n}";

    }

    return nbn;
  }


  // add_back_panel(String inner_id,double back_panel_thickness,double groove_depth , bool over_all){
  //
  //    Piece_model  back_panel = Piece_model(
  //       get_id("BP"),
  //       'back_panel',
  //       'F',
  //       init_material_name,
  //       correct_value(box_width-2*init_material_thickness+2*grove_value-1),
  //       correct_value(box_height-2*init_material_thickness+2*grove_value-1),
  //       correct_value(back_panel_thickness),
  //       Point_model(
  //           correct_value( box_origin.x_coordinate+init_material_thickness-grove_value+1),
  //           correct_value( box_origin.y_coordinate+init_material_thickness-grove_value+1 ),
  //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
  //       ),
  //   );
  //
  //   Piece_model  back_panel_Helper = Piece_model(
  //       get_id("Helper"),
  //       'back_panel_Helper',
  //       'F',
  //       init_material_name,
  //       correct_value(box_width-2*init_material_thickness),
  //       correct_value(box_height-2*init_material_thickness),
  //       correct_value(back_panel_thickness),
  //       Point_model(
  //           correct_value( box_origin.x_coordinate+init_material_thickness),
  //           correct_value( box_origin.y_coordinate+init_material_thickness ),
  //           correct_value( box_origin.z_coordinate+box_depth-bac_panel_distence-back_panel_thickness)
  //       ),
  //   );
  //
  //   box_pieces.add(back_panel);
  //   box_pieces.add(back_panel_Helper);
  //
  //
  //
  // }

}
