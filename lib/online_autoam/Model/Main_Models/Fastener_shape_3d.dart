import 'dart:ui';
import 'dart:math';

 import 'package:auto_cam_web/online_autoam/Controller/Main_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Controller/Repositories_Controllers/Box_Repository.dart';
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


  Box_Repository box_repository=Get.find();


  Fastener_shape_3d(this.fastener) {


    if (fastener.face_1_bore.diameter > 0) {
      face_1_cylinder = generate_cylinder_from_bore(fastener.face_1_bore,false);
      cylinders.add(face_1_cylinder);
    }else{
      face_1_cylinder=Cylinder([], [], [], Colors.white);
    }
    if (fastener.face_2_bore.diameter > 0) {
      face_2_cylinder = generate_cylinder_from_bore(fastener.face_2_bore,false);
      cylinders.add(face_2_cylinder);
    }else{
      face_2_cylinder=Cylinder([], [], [], Colors.white);
    }
    if (fastener.side_bore.diameter > 0) {
      side_cylinder = generate_cylinder_from_bore(fastener.side_bore,false);
      cylinders.add(side_cylinder);
    }else{
      side_cylinder=Cylinder([], [], [], Colors.white);
    }
    if (fastener.side_face_1_bore.diameter > 0) {
      side_face_1_cylinder =
          generate_cylinder_from_bore(fastener.side_face_1_bore,true);
      cylinders.add(side_face_1_cylinder);
    }else{
      side_face_1_cylinder=Cylinder([], [], [], Colors.white);
    }
    if (fastener.side_face_2_bore.diameter > 0) {
      side_face_2_cylinder =
          generate_cylinder_from_bore(fastener.side_face_2_bore,true);
      cylinders.add(side_face_2_cylinder);
    }else{
      side_face_2_cylinder=Cylinder([], [], [], Colors.white);
    }

  }

  Map<String, dynamic> toJson() {
    return {
      '"fastener"': fastener.toJson(),
      '"cylinders"': cylinders.map((cylinder) => cylinder.toJson()).toList(),
      '"face_1_cylinder"': face_1_cylinder.toJson(),
      '"face_2_cylinder"': face_2_cylinder.toJson(),
      '"side_cylinder"': side_cylinder.toJson(),
      '"side_face_1_cylinder"': side_face_1_cylinder.toJson(),
      '"side_face_2_cylinder"': side_face_2_cylinder.toJson(),
    };
  }


  // Create Fastener_shape_3d from JSON
  factory Fastener_shape_3d.fromJson(Map<String, dynamic> json) {

    Fastener_shape_3d fastener_shape_3d=
    Fastener_shape_3d(Fastener.fromJson(json['fastener']));


    fastener_shape_3d.cylinders=(json['cylinders'] as List).map((i) => Cylinder.fromJson(i)).toList();

      fastener_shape_3d.face_1_cylinder=Cylinder.fromJson(json['face_1_cylinder']);
      fastener_shape_3d.face_2_cylinder=Cylinder.fromJson(json['face_2_cylinder']);
      fastener_shape_3d.side_cylinder=Cylinder.fromJson(json['side_cylinder']);
      fastener_shape_3d.side_face_1_cylinder=Cylinder.fromJson(json['side_face_1_cylinder']);
      fastener_shape_3d.side_face_2_cylinder=Cylinder.fromJson(json['side_face_2_cylinder']);


    return fastener_shape_3d;


  }

  Cylinder generate_cylinder_from_bore(Bore_model bore,bool side_face) {

   bool hole_direction=fastener.fastener_direction;

    double r = bore.diameter / 2;




   late List<Point_model> main_circle_points=[] ;
   late List<Point_model> second_circle_points =[];

    if (fastener.fastener_axis == "X") {


      if(side_face){
        Piece_model side_piece=box_repository.box_model.value.box_pieces[fastener.side_pice_id];

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
        Piece_model side_piece=box_repository.box_model.value.box_pieces[fastener.side_pice_id];

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
        Piece_model side_piece=box_repository.box_model.value.box_pieces[fastener.side_pice_id];

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
          plane="YZ";
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
         // if (i%2==0) {}
           basic_line c = basic_line(main_circle[i].start_point, second_circle[i].start_point);
           connect_lines.add(c);

       }

     }



    Cylinder cylinder = Cylinder(main_circle, second_circle, connect_lines, Colors.red);

    return cylinder;
  }

  List<Point_model> generate_circle_point(Point_model center , String plane ,double radius){
    List<Point_model> resault=[];

    int number_of_sides=6;

    if(plane=="YZ"){

      for (int i = 0; i < number_of_sides; i++) {
        double angle = (i * (360/number_of_sides)) * pi / 180; // Convert degrees to radians
        List<double> point = generatePointOnCircle(center.z_coordinate, center.y_coordinate, radius, angle);

        Point_model resault_point=Point_model(center.x_coordinate,point[1], point[0]);

        resault.add(resault_point);
      }

    }
    else if(plane=="XZ"){

      for (int i = 0; i < number_of_sides; i++) {
        double angle = (i * (360/number_of_sides)) * pi / 180; // Convert degrees to radians
        List<double> point = generatePointOnCircle(center.x_coordinate, center.z_coordinate, radius, angle);

        Point_model resault_point=Point_model(point[0],center.y_coordinate, point[1]);

        resault.add(resault_point);
      }

    }
    else if(plane=="XY"){

      for (int i = 0; i < number_of_sides; i++) {
        double angle = (i * (360/number_of_sides)) * pi / 180; // Convert degrees to radians
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

  // Convert Cylinder to JSON
  Map<String, dynamic> toJson() => {
    '"main_circle"': main_circle.map((line) => line.toJson()).toList(),
    '"second_circle"': second_circle.map((line) => line.toJson()).toList(),
    '"connect_lines"': connect_lines.map((line) => line.toJson()).toList(),
    '"color"': color.value,
  };

  // Create Cylinder from JSON
  factory Cylinder.fromJson(Map<String, dynamic> json) {
    return Cylinder(
      (json['main_circle'] as List).map((i) => basic_line.fromJson(i)).toList(),
      (json['second_circle'] as List).map((i) => basic_line.fromJson(i)).toList(),
      (json['connect_lines'] as List).map((i) => basic_line.fromJson(i)).toList(),
      Color(json['color']),
    );
  }


}

class basic_line {
  late Point_model start_point;
  late Point_model end_point;

  basic_line(this.start_point, this.end_point);

  // Convert basic_line to JSON
  Map<String, dynamic> toJson() => {
    '"start_point"': start_point.toJson(),
    '"end_point"': end_point.toJson(),
  };

  // Create basic_line from JSON
  factory basic_line.fromJson(Map<String, dynamic> json) {
    return basic_line(
      Point_model.fromJson(json['start_point']),
      Point_model.fromJson(json['end_point']),
    );
  }

}
