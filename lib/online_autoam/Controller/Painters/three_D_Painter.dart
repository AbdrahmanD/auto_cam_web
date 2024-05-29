import 'dart:ui';

import 'package:auto_cam_web/online_autoam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class three_D_Painter extends CustomPainter {

late  Box_model box_model;
  late List<LineWithType> lines_with_type;
  late Size screen_size;
  late double scale;
  late int hover_id;
  late Offset mouse_position;
  late List  selected_pieces;
  late List  selected_faces;

late Offset start_select_window;
late Offset end_select_window  ;
late bool select_window;

late double X_move;
late double Y_move;
late String view_Port;
late List<Fastener> converted_fasteners;


  three_D_Painter(this.box_model,this.lines_with_type, this.screen_size,
      this.scale,this.hover_id,this.mouse_position,this.selected_pieces,this.selected_faces,this.start_select_window,this
.end_select_window,this.select_window,this.X_move,this.Y_move,this.view_Port
    ,this.converted_fasteners  );

  @override
  void paint(Canvas canvas, Size size) {
    size = screen_size;

    for (int i = 0; i < box_model.box_pieces.length; i++) {
      Piece_model p = box_model.box_pieces[i];

       // if (
      // p.piece_name.contains("Helper")
      // ) {
      //   continue;
      // }
      if (i == hover_id) {
        draw_hover_piece(canvas, screen_size, p);
      }
      else {
        if(p.piece_inable){
          draw_piece(canvas, screen_size, p);
        }
      }
    }
    double w = screen_size.width / 2;
    double h = screen_size.height / 2;



    draw_fasteners(canvas);
    draw_web(canvas, screen_size);

    draw_text(canvas, "X:${double.parse("${mouse_position.dx}").toStringAsFixed(2)}", Offset(400, screen_size.height - 50), 8, 18, Colors.grey);
    draw_text(canvas, "Y:${double.parse("${-mouse_position.dy}").toStringAsFixed(2)}", Offset(500, screen_size.height - 50), 8, 18, Colors.grey);
    draw_text(canvas, "scale:${double.parse("${ scale}").toStringAsFixed(2)}", Offset(600, screen_size.height - 50), 8, 18, Colors.grey);

   String view_p="";
       if(view_Port=="F"){view_p="FRONT";}
  else if(view_Port=="P"){view_p="PERSPECTIVE";}
  else if(view_Port=="R"){view_p="RIGHT";}
  else if(view_Port=="T"){view_p="TOP";}

    draw_text(canvas, "view port  : ${view_p}", Offset(700, screen_size.height - 50), 8, 18, Colors.grey);

    ///

    if (select_window) {
      draw_select_rect(canvas, screen_size);
    }

  }

draw_fasteners(Canvas canvas){
  double w = screen_size.width / 2;
  double h = screen_size.height / 2;

  if(converted_fasteners.length>0){
     for(int f=0;f<converted_fasteners.length;f++){
       canvas.drawCircle(
           Offset(w+converted_fasteners[f].fastener_origin.x_coordinate* scale,
                  h-converted_fasteners[f].fastener_origin.y_coordinate* scale
           ),       converted_fasteners[f].fastener_templet.face_1_diameter*scale/2, Paint());
     }
    }

}


  draw_web  (Canvas canvas , Size screen_size){

    double w = screen_size.width / 2;
    double h = screen_size.height / 2;

    for(int i=0;i<lines_with_type.length;i++){

      List<Line> lines=lines_with_type[i].lines;

      Paint paint=Paint();
      paint.style=PaintingStyle.stroke;
      paint.strokeWidth=1;
      paint.color=lines_with_type[i].color;

      for(int l=0;l<lines.length;l++){

        if(lines_with_type[i].type=="X"||lines_with_type[i].type=="Y"||lines_with_type[i].type=="Z"){

          continue;
        }else{ canvas.drawLine(
            Offset(lines[l].start_point.x_coordinate*scale+w,
                h-lines[l].start_point.y_coordinate*scale
            ),
            Offset(lines[l].end_point.x_coordinate*scale+w,
                h-lines[l].end_point.y_coordinate*scale
            ),
            paint);
        }

      }
    }



    for(int i=0;i<lines_with_type.length;i++){

      List<Line> lines=lines_with_type[i].lines;

      Paint paint=Paint();
      paint.style=PaintingStyle.stroke;
      paint.strokeWidth=1;
      paint.color=lines_with_type[i].color;

      for(int l=0;l<lines.length;l++){

        if(lines_with_type[i].type=="X"||lines_with_type[i].type=="Y"||lines_with_type[i].type=="Z"){

          draw_text(canvas, lines_with_type[i].type,
              Offset(lines_with_type[i].lines.first.end_point.x_coordinate*scale+w,
                  h-lines_with_type[i].lines.first.end_point.y_coordinate*scale)
              , 14, 14,lines_with_type[i].color);


          paint.strokeWidth=4;
          canvas.drawLine(
              Offset(lines[l].start_point.x_coordinate*scale+w,
                  h-lines[l].start_point.y_coordinate*scale
              ),
              Offset(lines[l].end_point.x_coordinate*scale+w,
                  h-lines[l].end_point .y_coordinate*scale
              ),
              paint);




        }else{ continue;

        }

      }



    }
  }

  draw_piece(Canvas canvas , Size screen_size , Piece_model piece_model ){

    double w = screen_size.width / 2;
    double h = screen_size.height / 2;


    ///
    Point_model p1 = piece_model.piece_faces.faces[4].corners[0];
    Point_model p2 = piece_model.piece_faces.faces[4].corners[1];
    Point_model p3 = piece_model.piece_faces.faces[4].corners[2];
    Point_model p4 = piece_model.piece_faces.faces[4].corners[3];
    Point_model p5 = piece_model.piece_faces.faces[5].corners[0];
    Point_model p6 = piece_model.piece_faces.faces[5].corners[1];
    Point_model p7 = piece_model.piece_faces.faces[5].corners[2];
    Point_model p8 = piece_model.piece_faces.faces[5].corners[3];

    Path front_path = Path();
    Path back_path  = Path();
    Path right_path = Path();
    Path left_path  = Path();
    Path top_path   = Path();
    Path base_path  = Path();

    front_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    front_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    front_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    front_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    front_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    back_path.moveTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    back_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    back_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    back_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    back_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);

    base_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    base_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    base_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    base_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    base_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    top_path.moveTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    top_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    top_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    top_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    top_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);

    left_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    left_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    left_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    left_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    left_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    right_path.moveTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    right_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    right_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    right_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    right_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);


    bool inner=piece_model.piece_name.contains('inner');
    bool Helper= piece_model.piece_name.contains('Helper');





    Paint main_paint = Paint();
    main_paint.style = PaintingStyle.stroke;
    main_paint.strokeWidth=1;





      Paint all_paint = Paint();


      if(inner){

        all_paint.color=Color.fromARGB(0, 0, 0, 0);
        main_paint.color=Color.fromARGB(0, 0, 0, 0);

      }
      else if(Helper){
        // all_paint.color=Colors.white70;
        all_paint.color=Color.fromARGB(0, 0, 0, 0);
        main_paint.color=Color.fromARGB(0, 0, 0, 0);

      }

      else{
        all_paint.color=Colors.grey[300]!;
        all_paint.blendMode=BlendMode.darken;

      }




      Paint selected_paint = Paint()
      ..style = PaintingStyle.fill
      // ..strokeWidth=1.5
      ..color=Colors.blue[300]!;


      bool selected_piece=false;

      for(Piece_model  p in selected_pieces){
        if(p.piece_id==piece_model.piece_id){
          selected_piece=true;
        }
      }



      /// selected faces
    Paint selected_face_paint = Paint()
      ..style = PaintingStyle.stroke
    ..strokeWidth=2.5
      ..color=Colors.red;


    int face_name=100;

    for(Selected_Face  f in selected_faces){
      if(f.piece_id==piece_model.piece_id){
        face_name=f.face_name;
      }
    }

      canvas.drawPath(front_path, (selected_piece)?selected_paint:all_paint);
      canvas.drawPath(back_path , (selected_piece)?selected_paint:all_paint);
      canvas.drawPath(right_path, (selected_piece)?selected_paint:all_paint);
      canvas.drawPath(left_path , (selected_piece)?selected_paint:all_paint);
      canvas.drawPath(top_path  , (selected_piece)?selected_paint:all_paint);
      canvas.drawPath(base_path , (selected_piece)?selected_paint:all_paint);

      List<Path> selected_faces_list=[];
      List<Path> un_selected_faces_list=[];

    if(face_name==1){selected_faces_list.add(top_path);}else{un_selected_faces_list.add(top_path);}
    if(face_name==2){selected_faces_list.add(right_path);}else{un_selected_faces_list.add(right_path);}
    if(face_name==3){selected_faces_list.add(base_path);}else{un_selected_faces_list.add(base_path);}
    if(face_name==4){selected_faces_list.add(left_path);}else{un_selected_faces_list.add(left_path);}
    if(face_name==5){selected_faces_list.add(front_path);}else{un_selected_faces_list.add(front_path);}
    if(face_name==6){selected_faces_list.add(back_path);}else{un_selected_faces_list.add(back_path);}



    for(Path p in un_selected_faces_list){
      canvas.drawPath(p,main_paint);
    }

    for(Path p in selected_faces_list){
      canvas.drawPath(p,selected_face_paint);
    }


  }

  draw_hover_piece(Canvas canvas , Size screen_size , Piece_model piece_model ){

    double w = screen_size.width / 2;
    double h = screen_size.height / 2;


    ///
    Point_model p1 = piece_model.piece_faces.faces[4].corners[0];
    Point_model p2 = piece_model.piece_faces.faces[4].corners[1];
    Point_model p3 = piece_model.piece_faces.faces[4].corners[2];
    Point_model p4 = piece_model.piece_faces.faces[4].corners[3];
    Point_model p5 = piece_model.piece_faces.faces[5].corners[0];
    Point_model p6 = piece_model.piece_faces.faces[5].corners[1];
    Point_model p7 = piece_model.piece_faces.faces[5].corners[2];
    Point_model p8 = piece_model.piece_faces.faces[5].corners[3];

    Path front_path = Path();
    Path back_path  = Path();
    Path right_path = Path();
    Path left_path  = Path();
    Path top_path   = Path();
    Path base_path  = Path();

    front_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    front_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    front_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    front_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    front_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    back_path.moveTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    back_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    back_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    back_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    back_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);

    base_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    base_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    base_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    base_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    base_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    top_path.moveTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    top_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    top_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    top_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    top_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);

    left_path.moveTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);
    left_path.lineTo(w + p5.x_coordinate * scale, h - p5.y_coordinate * scale);
    left_path.lineTo(w + p8.x_coordinate * scale, h - p8.y_coordinate * scale);
    left_path.lineTo(w + p4.x_coordinate * scale, h - p4.y_coordinate * scale);
    left_path.lineTo(w + p1.x_coordinate * scale, h - p1.y_coordinate * scale);

    right_path.moveTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);
    right_path.lineTo(w + p6.x_coordinate * scale, h - p6.y_coordinate * scale);
    right_path.lineTo(w + p7.x_coordinate * scale, h - p7.y_coordinate * scale);
    right_path.lineTo(w + p3.x_coordinate * scale, h - p3.y_coordinate * scale);
    right_path.lineTo(w + p2.x_coordinate * scale, h - p2.y_coordinate * scale);


    bool inner=piece_model.piece_name.contains('inner');
    bool Helper=piece_model.piece_name.contains('Helper');

    Paint main_paint = Paint();
    main_paint.style = PaintingStyle.stroke;
    main_paint.strokeWidth=1.5;



      canvas.drawPath(front_path, main_paint);
      canvas.drawPath(back_path , main_paint);
      canvas.drawPath(right_path, main_paint);
      canvas.drawPath(left_path , main_paint);
      canvas.drawPath(top_path  , main_paint);
      canvas.drawPath(base_path , main_paint);


      Paint all_paint = Paint();


      if(inner){
        all_paint.color=Colors.teal[100]!;

      }
      else if(Helper){
        all_paint.color=Colors.blue[100]!;

      }
      else{
        all_paint.color=Colors.blue[200]!;

      }

      all_paint.blendMode=BlendMode.darken;



      Paint selected_paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth=0.5
      ..color=Colors.black;

      int selected_face=1;
      String selected_piece=piece_model.piece_name;



      canvas.drawPath(front_path, all_paint);
      canvas.drawPath(back_path ,all_paint);
      canvas.drawPath(right_path,all_paint);
      canvas.drawPath(left_path ,all_paint);
      canvas.drawPath(top_path  , all_paint);
      canvas.drawPath(base_path , all_paint);





  }


  draw_text(Canvas c, String text, Offset offset, double t_size , int my_text_size , Color color) {
  TextSpan ts = TextSpan(
      text: text, style: TextStyle(fontSize: t_size/10*my_text_size, color: color,fontWeight: FontWeight.bold));
  TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
  tp.layout();

  tp.paint(c, offset);
}


draw_select_rect(Canvas canvas ,Size screen_size){


  Rect r =Rect.fromPoints(
     Offset(start_select_window.dx*scale+screen_size.width/2 +X_move*scale,Y_move*scale+screen_size.height/2+ start_select_window.dy*scale) ,
     Offset(end_select_window.dx  *scale+screen_size.width/2 +X_move*scale,Y_move*scale+screen_size.height/2+  end_select_window.dy *scale)
     //
     //  Offset(start_select_window.dx  , start_select_window.dy ) ,
     //  Offset(end_select_window.dx    ,  end_select_window.dy  )
  );
  Paint p = Paint();


  p.style =PaintingStyle.fill;
  p.color=Colors.blueGrey[100]!;
  p.blendMode=BlendMode.darken;
  canvas.drawRect(r, p);


  p.style =PaintingStyle.stroke;
  p.strokeWidth=0.5;
  p.color=Colors.black;
  canvas.drawRect(r, p);

}


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
