import 'dart:math' as math;
import 'dart:ui';
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
 import 'package:auto_cam_web/online_autoam/Controller/View_3_D/CameraTransformer.dart';
import 'package:auto_cam_web/online_autoam/Controller/Painters/three_D_Painter.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener_shape_3d.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class transform_controller {

  Draw_Controller draw_controller = Get.find();

  late Point_model camera_position;


  double a1=math.pi/24;
  double a2=-math.pi/6;
  double a3=math.pi/12;

 late  CameraTransformer cameraTransformer ;
  late Size screen_size;


  transform_controller(this.screen_size ){
     camera_position=Point_model(0, 0, 0);


  }


  /// /////////////////////////////////////////////////////
  /// /////////////////////////////////////////////////////




  three_D_Painter camera_cordinate_draw(Size screen_size  ){



    cameraTransformer = CameraTransformer(
        camera_position.x_coordinate, camera_position.y_coordinate, camera_position.z_coordinate,
        a1, a2, a3
    );


    /// original box model
    Box_model b=draw_controller.box_repository.box_model.value;

    /// instance of box model
    Box_model box_model=Box_model(b.box_name, b.box_type, b.box_width, b.box_height, b.box_depth,
        b.init_material_thickness, b.init_material_name, b.back_panel_thickness,
        b.grove_value, b.bac_panel_distence, b.top_base_piece_width, b.is_back_panel, Point_model(0,0,0));

    box_model.box_pieces=[];
    box_model.fasteners_shape_3d=draw_controller.box_repository.box_model.value.fasteners_shape_3d;

    /// stupid boy dont forget to try understand this
    /// when its active
    // box_model.fasteners=b.fasteners;

    /// copy all pieces
    for(int i=0;i<b.box_pieces.length;i++){

      Piece_model p = Piece_model(
      b.box_pieces[i].piece_id, b.box_pieces[i].piece_name,
      b.box_pieces[i].piece_direction, b.box_pieces[i].material_name,
      b.box_pieces[i].piece_width, b.box_pieces[i].piece_height,
      b.box_pieces[i].piece_thickness, b.box_pieces[i].piece_origin );

      p.piece_inable=b.box_pieces[i].piece_inable;

      box_model.box_pieces.add(p);

    }




    for(int i=0;i<box_model.box_pieces.length;i++){

      Piece_model p =box_model.box_pieces[i];

      for(int f=0;f<p.piece_faces.faces.length;f++){
        for(int c=0;c<p.piece_faces.faces[f].corners.length;c++){
        p.piece_faces.faces[f].corners[c]=cameraTransformer.transform(p.piece_faces.faces[f].corners[c]);

      }}


    }


    List<Fastener> converted_fasteners=[];
    List<Cylinder> converted_cylinder=[];

    for(int f=0;f<b.fasteners.length;f++){


      Fastener fastener=Fastener(
         b.fasteners[f].id,
         b.fasteners[f].fastener_templet,
          cameraTransformer.transform(b.fasteners[f].fastener_origin),
         b.fasteners[f].fastener_axis,
         b.fasteners[f].fastener_direction,
         b.fasteners[f].material_thickness,
        b.fasteners[f].facee_name,
        b.fasteners[f].side_name,
        b.fasteners[f].face_pice_id,
        b.fasteners[f].side_pice_id,
false
      );

      converted_fasteners.add(fastener);
    }


    if (b.fasteners_shape_3d.length>0) {

      for(int f3d=0;f3d<b.fasteners_shape_3d.length;f3d++){

        for (var c = 0; c<b.fasteners_shape_3d[f3d].cylinders.length; c++) {

          Cylinder original_cylinder=b.fasteners_shape_3d[f3d].cylinders[c];

          Cylinder new_cylinder=Cylinder([], [], [], Colors.red);

          for(int cf=0;cf<original_cylinder.main_circle.length;cf++){


            basic_line m_c    = basic_line(
                cameraTransformer.transform(original_cylinder.main_circle[cf].start_point),
                cameraTransformer.transform(original_cylinder.main_circle[cf].end_point)
            );

            basic_line s_c     = basic_line(
                cameraTransformer.transform(original_cylinder.second_circle[cf].start_point),
                cameraTransformer.transform(original_cylinder.second_circle[cf].end_point)
            );

            basic_line c_l     = basic_line(
                cameraTransformer.transform(original_cylinder.connect_lines[cf].start_point),
                cameraTransformer.transform(original_cylinder.connect_lines[cf].end_point)
            );

            new_cylinder.main_circle.add(m_c);
            new_cylinder.second_circle.add(s_c);
            new_cylinder.connect_lines.add(c_l);

          }

          converted_cylinder.add(new_cylinder);

        }

      }
    }



    List<LineWithType> NLineWithType=[];

    for(int w=0;w<my_web().length;w++){

      LineWithType old_line=my_web()[w];

      List<Line> new_lines=[];

      for(int l=0;l<old_line.lines.length;l++){
        Line nLine=Line(
            cameraTransformer.transform(old_line.lines[l].start_point),
            cameraTransformer.transform(old_line.lines[l].end_point),
          1
        );
        new_lines.add(nLine);
      }
      NLineWithType.add(LineWithType(new_lines, old_line.type, old_line.color));

    }


    List selected_pieces=draw_controller.selected_pieces.value;



    three_D_Painter camera_painter=
    three_D_Painter(box_model,NLineWithType, screen_size,
        draw_controller.drawing_scale.value,
        draw_controller.hover_id,
        draw_controller.mouse_position.value,
        selected_pieces,
        draw_controller.selected_faces,
        draw_controller.start_select_window.value,
        draw_controller.end_select_window.value,
      draw_controller.select_window.value,
      draw_controller.x_move,
      draw_controller.y_move,
      draw_controller.view_port.value,

        converted_fasteners,
        converted_cylinder


    );


    return camera_painter;

  }




  List<LineWithType> my_web(){
    List<LineWithType> result=[];

    List<Line> lines=[];
    for(double i=-500;i<=500;i+=10){
      Point_model px1=Point_model(i,    0, -500 );
      Point_model px2=Point_model(i,    0, 500  );
      Point_model py1=Point_model( -500,0,  i   );
      Point_model py2=Point_model( 500, 0,  i   );

      Line line_1=Line(px1,px2,1);
      Line line_2=Line(py1,py2,1);
      lines.add(line_1);
      lines.add(line_2);

    }

    LineWithType web=LineWithType(lines, 'web',Colors.black12);

    Point_model px= Point_model( 0,0,0);
    Point_model px_2=Point_model( 50,0,00);

    Line x_Axis=Line(px, px_2,1);


    Point_model py=Point_model( 0,0,0);
    Point_model py_2=Point_model( 0,50,00);

    Line y_Axis=Line(py, py_2,1);

    Point_model pz=Point_model( 0,0,0);
    Point_model pz_2=Point_model( 0,0,50);

    Line z_Axis=Line(pz, pz_2,1);

    LineWithType X_axis=LineWithType([x_Axis], 'X',Colors.red);
    LineWithType Y_axis=LineWithType([y_Axis], 'Y',Colors.blue);
    LineWithType Z_axis=LineWithType([z_Axis], 'Z',Colors.teal);

    result.add(web);
    result.add(X_axis);
    result.add(Y_axis);
    result.add(Z_axis);

    return result;
  }


  move(double dx, double dy, double dz){

    camera_position.x_coordinate+=dx/draw_controller.drawing_scale.value;
    camera_position.y_coordinate+=dy/draw_controller.drawing_scale.value;
    camera_position.z_coordinate+=dz/draw_controller.drawing_scale.value;

  }






}
