import 'dart:math' as math;
import 'dart:ui';
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
 import 'package:auto_cam_web/online_autoam/Controller/View_3_D/CameraTransformer.dart';
import 'package:auto_cam_web/online_autoam/Controller/Painters/three_D_Painter.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
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


    /// transform all pieces corners
    // for(int i=0;i<box_model.box_pieces.length;i++){
    //
    //   Piece_model p =box_model.box_pieces[i];
    //
    //    p.piece_faces.faces[4].corners[0]=cameraTransformer.transform(p.piece_faces.faces[4].corners[0]);
    //    p.piece_faces.faces[4].corners[1]=cameraTransformer.transform(p.piece_faces.faces[4].corners[1]);
    //    p.piece_faces.faces[4].corners[2]=cameraTransformer.transform(p.piece_faces.faces[4].corners[2]);
    //    p.piece_faces.faces[4].corners[3]=cameraTransformer.transform(p.piece_faces.faces[4].corners[3]);
    //    p.piece_faces.faces[5].corners[0]=cameraTransformer.transform(p.piece_faces.faces[5].corners[0]);
    //    p.piece_faces.faces[5].corners[1]=cameraTransformer.transform(p.piece_faces.faces[5].corners[1]);
    //    p.piece_faces.faces[5].corners[2]=cameraTransformer.transform(p.piece_faces.faces[5].corners[2]);
    //    p.piece_faces.faces[5].corners[3]=cameraTransformer.transform(p.piece_faces.faces[5].corners[3]);
    //    p.piece_origin=cameraTransformer.transform(p.piece_origin);
    //
    //    p.f.fastener_origin=cameraTransformer.transform(p.f.fastener_origin);
    //
    //
    //    p.fasteners[0].fastener_origin=cameraTransformer.transform(p.fasteners[0].fastener_origin);
    //
    //
    // }

    for(int i=0;i<box_model.box_pieces.length;i++){

      Piece_model p =box_model.box_pieces[i];

      for(int f=0;f<p.piece_faces.faces.length;f++){
        for(int c=0;c<p.piece_faces.faces[f].corners.length;c++){
        p.piece_faces.faces[f].corners[c]=cameraTransformer.transform(p.piece_faces.faces[f].corners[c]);

      }}


    }


    for(int f=0;f<b.fasteners.length;f++){

      Fastener fastener=Fastener(
         b.fasteners[f].type,
          cameraTransformer.transform(b.fasteners[f].fastener_origin),
         b.fasteners[f].face_piece_id,
         b.fasteners[f].face_1,
         b.fasteners[f].face_2,
         b.fasteners[f].side_piece_id,
         b.fasteners[f].side_1,
         b.fasteners[f].side_face_1,
         b.fasteners[f].side_face_2
      );

      box_model.fasteners.add(fastener);




      // box_model.fasteners[f].fastener_origin=cameraTransformer.transform(box_model.fasteners[f].fastener_origin);
    }



    /// transform fasteners
    // for(int i=0;i<box_model.box_pieces.length;i++){
    //
    //   Piece_model p =box_model.box_pieces[i];
    //
    //   for(int f=0;f<p.fasteners.length;f++){
    //        // p.fasteners[f].fastener_origin =cameraTransformer.transform(p.fasteners[f].fastener_origin);
    //     }
    // }

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
