import 'dart:ui';
import 'dart:math';

import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fastener_shape_3d {

  late Fastener fastener;

  List<Cylinder> cylinders = [];

  late Cylinder face_1_cylinder;
  late Cylinder face_2_cylinder;
  late Cylinder side_cylinder;
  late Cylinder side_face_1_cylinder;
  late Cylinder side_face_2_cylinder;

  Draw_Controller draw_controller = Get.find();

  Fastener_shape_3d(this.fastener) {
    if (fastener.face_1_bore.diameter > 0) {
      face_1_cylinder = generate_cylinder_from_bore(fastener.face_1_bore,false);
      cylinders.add(face_1_cylinder);
    }
    if (fastener.face_2_bore.diameter > 0) {
      face_2_cylinder = generate_cylinder_from_bore(fastener.face_2_bore,false);
      cylinders.add(face_2_cylinder);
    }
    if (fastener.side_bore.diameter > 0) {
      side_cylinder = generate_cylinder_from_bore(fastener.side_bore,false);
      cylinders.add(side_cylinder);
    }
    if (fastener.side_face_1_bore.diameter > 0) {
      side_face_1_cylinder =
          generate_cylinder_from_bore(fastener.side_face_1_bore,true);
      cylinders.add(side_face_1_cylinder);
    }
    if (fastener.side_face_2_bore.diameter > 0) {
      side_face_2_cylinder =
          generate_cylinder_from_bore(fastener.side_face_2_bore,true);
      cylinders.add(side_face_2_cylinder);
    }
  }

  Cylinder generate_cylinder_from_bore(Bore_model bore,bool side_face) {

   bool hole_direction=fastener.fastener_direction;

    double r = bore.diameter / 2;




   late List<Point_model> main_circle_points=[] ;
   late List<Point_model> second_circle_points =[];

    if (fastener.fastener_axis == "X") {


      if(side_face){
        Piece_model side_piece=draw_controller.box_repository.box_model.value.box_pieces[fastener.side_pice_id];

String plane="";
double hd=0;
double fd=0;

if(side_piece.piece_direction=="H"){
  hole_direction=bore.origin.y_coordinate<fastener.fastener_origin.y_coordinate;
   hd =hole_direction? (bore.depth):(-bore.depth);
   fd=0;
  plane="XZ";

}
else if(side_piece.piece_direction=="F"){
  hole_direction=bore.origin.z_coordinate<fastener.fastener_origin.z_coordinate;
  fd =hole_direction? (bore.depth):(-bore.depth);
  hd=0;
  plane="XY";
}

        main_circle_points   =  generate_circle_point(bore.origin,plane, r);

        second_circle_points =generate_circle_point(
            Point_model(bore.origin.x_coordinate, bore.origin.y_coordinate+hd, bore.origin.z_coordinate+fd),
            plane,r);

      }

      else {

          double d =hole_direction? (bore.depth):(-bore.depth);

          main_circle_points   =  generate_circle_point(bore.origin, "YZ", r);
        second_circle_points =generate_circle_point(
            Point_model(bore.origin.x_coordinate+d, bore.origin.y_coordinate, bore.origin.z_coordinate),
            "YZ",r);

      }

    }


    else if (fastener.fastener_axis == "Y") {


      if(side_face){
        Piece_model side_piece=draw_controller.box_repository.box_model.value.box_pieces[fastener.side_pice_id];

        String plane="";
        double vd=0;
        double fd=0;

        if(side_piece.piece_direction=="V"){
          hole_direction=bore.origin.x_coordinate<fastener.fastener_origin.x_coordinate;
          vd =hole_direction? (bore.depth):(-bore.depth);
          fd=0;
          plane="YZ";

        }
        else if(side_piece.piece_direction=="F"){
          hole_direction=bore.origin.z_coordinate<fastener.fastener_origin.z_coordinate;
          fd =hole_direction? (bore.depth):(-bore.depth);
          vd=0;
          plane="XY";
        }

        main_circle_points   =  generate_circle_point(bore.origin,plane, r);

        second_circle_points =generate_circle_point(
            Point_model(bore.origin.x_coordinate+vd, bore.origin.y_coordinate, bore.origin.z_coordinate+fd),
            plane,r);

      }

      else {

        double d =hole_direction? (bore.depth):(-bore.depth);

        main_circle_points   =  generate_circle_point(bore.origin, "XZ", r);
        second_circle_points =generate_circle_point(
            Point_model(bore.origin.x_coordinate, bore.origin.y_coordinate+d, bore.origin.z_coordinate),
            "XZ",r);

      }

    }


    else if (fastener.fastener_axis == "Z") {


      if(side_face){
        Piece_model side_piece=draw_controller.box_repository.box_model.value.box_pieces[fastener.side_pice_id];

        String plane="";
        double hd=0;
        double vd=0;

        if(side_piece.piece_direction=="H"){
          hole_direction=bore.origin.y_coordinate<fastener.fastener_origin.y_coordinate;
          hd =hole_direction? (bore.depth):(-bore.depth);
          vd=0;
          plane="XZ";

        }
        else if(side_piece.piece_direction=="V"){
          hole_direction=bore.origin.x_coordinate<fastener.fastener_origin.x_coordinate;
          vd =hole_direction? (bore.depth):(-bore.depth);
          hd=0;
          plane="XZ";
        }

        main_circle_points   =  generate_circle_point(bore.origin,plane, r);

        second_circle_points =generate_circle_point(
            Point_model(bore.origin.x_coordinate+vd, bore.origin.y_coordinate+hd, bore.origin.z_coordinate),
            plane,r);

      }

      else {

         double d =hole_direction? (bore.depth):(-bore.depth);

        main_circle_points   =  generate_circle_point(bore.origin, "XY", r);
        second_circle_points =generate_circle_point(
            Point_model(bore.origin.x_coordinate, bore.origin.y_coordinate, bore.origin.z_coordinate+d),
            "XY",r);

      }

    }


    ///

    List<basic_line> main_circle=[];
    List<basic_line> second_circle=[];
    List<basic_line> connect_lines=[];

     if (main_circle_points.length>0) {

       main_circle   = draw_circle(main_circle_points  );
       second_circle = draw_circle(second_circle_points);
       for(int i=0;i<main_circle.length;i++){
         basic_line c = basic_line(main_circle[i].start_point, second_circle[i].start_point);
         connect_lines.add(c);
       }

     }



    Cylinder cylinder = Cylinder(main_circle, second_circle, connect_lines, Colors.red);

    return cylinder;
  }

  List<Point_model> generate_circle_point(Point_model center , String plane ,double radius){
    List<Point_model> resault=[];

    if(plane=="YZ"){

      for (int i = 0; i < 6; i++) {
        double angle = (i * 60) * pi / 180; // Convert degrees to radians
        List<double> point = generatePointOnCircle(center.z_coordinate, center.y_coordinate, radius, angle);

        Point_model resault_point=Point_model(center.x_coordinate,point[1], point[0]);

        resault.add(resault_point);
      }

    }
    else if(plane=="XZ"){

      for (int i = 0; i < 8; i++) {
        double angle = (i * 45) * pi / 180; // Convert degrees to radians
        List<double> point = generatePointOnCircle(center.x_coordinate, center.z_coordinate, radius, angle);

        Point_model resault_point=Point_model(point[0],center.y_coordinate, point[1]);

        resault.add(resault_point);
      }

    }
    else if(plane=="XY"){

      for (int i = 0; i < 8; i++) {
        double angle = (i * 45) * pi / 180; // Convert degrees to radians
        List<double> point = generatePointOnCircle(center.x_coordinate, center.y_coordinate, radius, angle);

        Point_model resault_point=Point_model(point[0], point[1],center.z_coordinate);

        resault.add(resault_point);
      }

    }



    return resault;
  }

  List<double> generatePointOnCircle(double cx, double cy, double radius, double angle) {
    double x = cx + radius * cos(angle);
    double y = cy + radius * sin(angle);
    return [x, y];
  }

  List<basic_line> draw_circle(List<Point_model> points){
    List<basic_line> circle=[];

    for(int p=0;p<points.length-1;p++){
      basic_line l = basic_line(points[p],points[p+1]);
      circle.add(l);
    }
    basic_line l = basic_line(points[points.length-1],points[0]);
    circle.add(l);



    return circle;
  }




}

class Cylinder {
  late List<basic_line> main_circle;
  late List<basic_line> second_circle;
  late List<basic_line> connect_lines;
  late Color color;

  Cylinder(
      this.main_circle, this.second_circle, this.connect_lines, this.color);
}

class basic_line {
  late Point_model start_point;
  late Point_model end_point;

  basic_line(this.start_point, this.end_point);
}
