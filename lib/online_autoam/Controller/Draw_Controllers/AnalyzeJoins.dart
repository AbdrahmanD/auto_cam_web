import 'dart:math';

import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Cut_List_Item.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Faces_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener_shape_3d.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
import 'package:flutter/cupertino.dart';
 import 'package:get/get.dart';


class AnalyzeJoins {

  late bool project;
  late bool collect_same_pieces;
   Draw_Controller draw_controller = Get.find();


  AnalyzeJoins(this.project,this.collect_same_pieces) {

    this.project=project;

    draw_controller.box_repository.cut_list_items = [];

       clean();
       all_face_check(draw_controller.box_repository.box_model.value);
       collect_all_same_pieces(collect_same_pieces);

  }

  clean ( ) {

    draw_controller.box_repository.box_model.value.fasteners.clear() ;
    draw_controller.box_repository.box_model.value.fasteners_shape_3d.clear() ;

    for(int p=0;p<draw_controller.box_repository.box_model.value.box_pieces.length;p++){
      for(int f=0;f<6;f++){
        draw_controller.box_repository.box_model.value.box_pieces[p].piece_faces.faces[f].bores.clear();
      }
    }
    draw_controller.box_repository.cut_list_items = [];
  }

  ///  all pieces for loop
  all_face_check(Box_model box_model) {
    for (int mp = 0; mp < box_model.box_pieces.length; mp++) {


      if (box_model.box_pieces[mp].piece_name.contains("inner")||
(         box_model.box_pieces[mp].piece_name.contains("back_panel") &&
         !box_model.box_pieces[mp].piece_name.contains("full_back_panel")) ||
          box_model.box_pieces[mp].piece_thickness==0 ||
          box_model.box_pieces[mp].piece_name.contains("base_panel")
      ) {
        continue;
      }


      for (int mf = 0; mf < box_model.box_pieces[mp].piece_faces.faces.length; mf++)
      {
        Single_Face mface = box_model.box_pieces[mp].piece_faces.faces[mf];

        for (int sp = 0; sp < box_model.box_pieces.length; sp++) {
          Piece_model spiece = box_model.box_pieces[sp];

          if (spiece.piece_id == box_model.box_pieces[mp].piece_id ||
              spiece.piece_thickness==0 ||

              spiece.piece_name.contains("inner")) {
            continue;
          }
          for (int sf = 0; sf < spiece.piece_faces.faces.length; sf++) {
            Single_Face sface = spiece.piece_faces.faces[sf];

            bool main_face_direction =
                detect_face_direction(box_model.box_pieces[mp].piece_direction, mface) == "V" ||
                    detect_face_direction(box_model.box_pieces[mp].piece_direction, mface) == "B";

            bool second_face_direction =
                detect_face_direction(spiece.piece_direction, sface) == "V" ||
                    detect_face_direction(spiece.piece_direction, sface) == "B";

            if (main_face_direction &&
                second_face_direction &&
                !(spiece.piece_name.contains("Helper"))) {
              continue;
            }


            late Line line;
            bool is_groove=false;

            if (box_model.box_pieces[mp].piece_name.contains("Helper") || spiece.piece_name.contains("Helper"))
            {
                if (
                box_model.box_pieces[mp].piece_name.contains("back_panel") || spiece.piece_name.contains("back_panel")||
                    box_model.box_pieces[mp].piece_name.contains("base_panel") || spiece.piece_name.contains("base_panel")
              ) {
                  is_groove=true;
              }}



            if (check_face_in_face((mface), (sface))) {
              line = find_center_line(sface, spiece.piece_thickness,is_groove);

            }
            else {
              line = check_tow_face_intersected(box_model,mface, sface);

            }




            late Join_Line join_line;

            if (box_model.box_pieces[mp].piece_name.contains("Helper") || spiece.piece_name.contains("Helper"))
            {

              ///Door_Helper
              if (
              box_model.box_pieces[mp].piece_name.contains("Door_Helper") || spiece.piece_name.contains("Door_Helper"))
              {

                if(box_model.box_pieces[mp].piece_name.contains("Door") && !box_model.box_pieces[mp].piece_name.contains("Helper")){

                  join_line = Join_Line(line.start_point, line.end_point, "Door_Hinges",line.line_width);

                }else{
                  join_line = Join_Line(line.start_point, line.end_point, "side_Hinges",line.line_width);

                }

              }

              ///Drawer_Helper
              else if (
              box_model.box_pieces[mp].piece_name.contains("Drawer_Helper") || spiece.piece_name.contains("Drawer_Helper"))
              {
                if(box_model.box_pieces[mp].piece_name.contains("drawer")||spiece.piece_name.contains("drawer")){
                  join_line = Join_Line(line.start_point, line.end_point, "Drawer_Rail_Side",line.line_width);
                }
                else{
                  join_line = Join_Line(line.start_point, line.end_point, "Drawer_Rail_Box",line.line_width);
                }
              }

              ///back_panel
              else if (
              box_model.box_pieces[mp].piece_name.contains("back_panel") || spiece.piece_name.contains("back_panel")||
                  box_model.box_pieces[mp].piece_name.contains("base_panel") || spiece.piece_name.contains("base_panel")
              ) {

                join_line = Join_Line(line.start_point, line.end_point, "Groove",line.line_width);

              }

              /// drawer Helper
              else if (box_model.box_pieces[mp].piece_name.contains("DBF") || spiece.piece_name.contains("DBF")) {
                join_line = Join_Line(line.start_point, line.end_point, "DBF",line.line_width);
              }

              /// helper shelf
              else if ( spiece.piece_name.contains("shelf") && !spiece.piece_name.contains("fixed"))
              {
                join_line = Join_Line(line.start_point, line.end_point, "Help",line.line_width);
              }

              /// helper partition
              else if ( spiece.piece_name.contains("partition"))
              {

                join_line = Join_Line(line.start_point, line.end_point, "Help",line.line_width);
              }


            }

            /// Drawer Face
            else if (box_model.box_pieces[mp].piece_name.contains("Drawer Face") ||
                spiece.piece_name.contains("Drawer Face"))
            {
              join_line = Join_Line(line.start_point, line.end_point, "Drawer_Face",line.line_width);
            }

            else if (
            spiece.piece_name.contains("shelf") && !spiece.piece_name.contains("fixed")
            )
            {

              join_line = Join_Line(line.start_point, line.end_point, "Flexible_Shelves",line.line_width);
            }

            else
            {
              join_line = Join_Line(line.start_point, line.end_point, "Box_Fitting_DRILL",line.line_width);
            }

            if (calculate_length_of_line(line, line_axis(line)) > 0)

            {
              if (join_line.join_type=="Groove") {

                double width;
                double grove_depth=draw_controller.box_repository.pack_panel_grove_depth;


                if(box_model.box_pieces[mp].piece_name.contains("Helper")){
                  width=box_model.box_pieces[mp].piece_thickness;
                }
                else if(spiece.piece_name.contains("Helper")){
                  width=spiece.piece_thickness;
                }
                else{
                  width=draw_controller.box_repository.pack_panel_thickness;
                }
                mface.groves.add
                  (Groove_model(
                    line.start_point, line.end_point, width,grove_depth)
                );

                // print("mpiece.piece_name : ${mpiece.piece_name}");
                // print("mface.name : ${mface.name}");

                mface.joines.add(join_line);

              }
              else{
                sface.joines.add(join_line);
                mface.joines.add(join_line);

                if (
                !join_line.join_type.contains("Flexible_Shelves")&&
                !join_line.join_type.contains("Groove")&&
                !join_line.join_type.contains("Drawer_Rail_Side")&&
                !join_line.join_type.contains("Drawer_Rail_Box")
                ) {
                  transform_line_into_fasteners(line , mp,sp,mf,sf);
                }

              }

            }

            /// ==================
          }
        }
      }

    }

  }



  transform_line_into_fasteners(Line l , int mp,int sp,int mf,int sf ){


    String join_line_axis = line_axis(l);
    List<Fastener_Point> fasteners_points =  generate_fasteners_points(  l,join_line_axis);
    Point_model origin = l.start_point;

    late Fastener_Templet fastener_templet;
    if(draw_controller.box_repository.corrent_fastener==""){
      Get.defaultDialog(title: "ALERT" , content: Container(height: 50,width: 200,child: Text("choose fasteners type"),));
    }
    else if(draw_controller.box_repository.corrent_fastener=="mini_fix"){
      fastener_templet=draw_controller.box_repository.mini_fix;
    }
    else if(draw_controller.box_repository.corrent_fastener=="confirm_screw"){
      fastener_templet=draw_controller.box_repository.confirm_screw;

    }

    Fastener_Templet dowel_templet   = draw_controller.box_repository.dowel_templet   ;
    double material_thickness=draw_controller.box_repository.box_model.value.init_material_thickness;

    Piece_model face_piece=draw_controller.box_repository.box_model.value.box_pieces[mp];

    bool fastener_direction=Detect_Fastener_Direction(face_piece,mf);
    String fastener_axis=Detect_Fastener_Axis(face_piece,mf);
    for(int i=0;i<fasteners_points.length;i++){
      Fastener_Templet  templet =
      (fasteners_points[i].fastener_type=="dowel")?
      dowel_templet:fastener_templet;

    late Fastener fastener;

      if(join_line_axis=="Z"){
        fastener=   Fastener(
            draw_controller.box_repository.box_model.value.fasteners.length-1,
            templet,
            Point_model(
                origin.x_coordinate,
                origin.y_coordinate,
                origin.z_coordinate+fasteners_points[i].distance
            ),
            fastener_axis,
            fastener_direction,
            material_thickness
            ,mp,sp,mf,sf
,true
        );
      }
      if(join_line_axis=="Y"){
        fastener=   Fastener(
            draw_controller.box_repository.box_model.value.fasteners.length-1,
            templet,
            Point_model(
                origin.x_coordinate,
                origin.y_coordinate+fasteners_points[i].distance,
                origin.z_coordinate
            ),
            fastener_axis,
            fastener_direction,
            material_thickness
            ,mp,sp,mf,sf
            ,true
        );
      }
      if(join_line_axis=="X"){
        fastener=   Fastener(
            draw_controller.box_repository.box_model.value.fasteners.length-1,
            templet,
            Point_model(
                origin.x_coordinate+fasteners_points[i].distance,
                origin.y_coordinate,
                origin.z_coordinate
            ),
            fastener_axis,
            fastener_direction,
            material_thickness
            ,mp,sp,mf,sf
            ,true
        );
      }

      draw_controller.box_repository.box_model.value.fasteners.add(fastener);


    }


    generate_3d_shape_fastener();

  }

  generate_3d_shape_fastener(){

    draw_controller.box_repository.box_model.value.fasteners_shape_3d.clear();

    for(int f=0;f<draw_controller.box_repository.box_model.value.fasteners.length;f++){

      Fastener fastener = draw_controller.box_repository.box_model.value.fasteners[f];

      Fastener_shape_3d f3d =Fastener_shape_3d(fastener);

      draw_controller.box_repository.box_model.value.fasteners_shape_3d.add(f3d);

    }

  }



  List<Fastener_Point> generate_fasteners_points(Line l,String join_line_axis){

    List<Fastener_Point> fasteners_points=[];
    double join_line_length = calculate_length_of_line(l, join_line_axis);

    if(join_line_length>40 && join_line_length<=80 ){
      fasteners_points.add(Fastener_Point(15, "dowel"));
      fasteners_points.add(Fastener_Point(join_line_length-15, "dowel"));
    }
    else if(join_line_length>80 && join_line_length<=200 ){
      fasteners_points.add(Fastener_Point(20, "dowel"));
      fasteners_points.add(Fastener_Point(join_line_length/2, "screw"));
      fasteners_points.add(Fastener_Point(join_line_length-20, "dowel"));
    }
    else if(join_line_length>200 && join_line_length<=300 ){
      fasteners_points.add(Fastener_Point(32, "screw"));
      fasteners_points.add(Fastener_Point(join_line_length/2, "dowel"));
      fasteners_points.add(Fastener_Point(join_line_length-32, "screw"));
    }
    else if(join_line_length>300 && join_line_length<=600 ){
      fasteners_points.add(Fastener_Point(32, "screw"));
      fasteners_points.add(Fastener_Point(64, "dowel"));
      fasteners_points.add(Fastener_Point(join_line_length/2, "screw"));
      fasteners_points.add(Fastener_Point(join_line_length-64, "dowel"));
      fasteners_points.add(Fastener_Point(join_line_length-32, "screw"));
    }
    else if(join_line_length>600){
      for(int i=0;i<(join_line_length%300);i++){
        fasteners_points.add(Fastener_Point(32 + i*300, "screw"));
        fasteners_points.add(Fastener_Point(64 + i*300, "dowel"));
      }

    }

    return fasteners_points;
  }

 String Detect_Fastener_Axis(Piece_model p , int face){
String fastener_axis="X";

    Single_Face mf=p.piece_faces.faces[face];
if(face_plane(mf)=="XY"){fastener_axis="Z";}
else if(face_plane(mf)=="XZ"){fastener_axis="Y";}
else if(face_plane(mf)=="YZ"){fastener_axis="X";}

return fastener_axis ;
  }



 bool  Detect_Fastener_Direction(Piece_model p , int face){
 bool direction =true;

    Single_Face mf=p.piece_faces.faces[face];
    Single_Face sf=p.piece_faces.faces[finde_parallel_face(face)];

    if(p.piece_direction=="H"){
      if(mf.corners[0].y_coordinate>sf.corners[0].y_coordinate){direction=true;}else{direction=false;}
    }
    else if(p.piece_direction=="V"){
      if(mf.corners[0].x_coordinate>sf.corners[0].x_coordinate){direction=true;}else{direction=false;}
    }
    else if(p.piece_direction=="F"){
      if(mf.corners[0].z_coordinate>sf.corners[0].z_coordinate){direction=true;}else{direction=false;}

    }

    return direction;
  }

  int finde_parallel_face(int face){
    int resault=0;
    if(face==0){resault=2;}
    if(face==1){resault=3;}
    if(face==2){resault=0;}
    if(face==3){resault=1;}
    if(face==4){resault=5;}
    if(face==5){resault=4;}

    return resault;
  }

  int finde_perpendiculer_face(int face){
    int resault=0;
    if(face==0){resault=1;}
    if(face==1){resault=2;}
    if(face==2){resault=3;}
    if(face==3){resault=0;}
    if(face==4){resault=3;}
    if(face==5){resault=1;}

    return resault;
  }


  /// ///////////////////
  /// ///////////////////

  Line find_center_line(Single_Face face, double thickness,bool is_groove) {
    // print('thickness thickness thickness : $thickness');

    Point_model corner_1 = face.corners[0];
    Point_model corner_3 = face.corners[2];

    Point_model sp = Point_model(0, 0, 0);
    Point_model ep = Point_model(0, 0, 0);
    double line_width=2;

    double x_correct=0;
    double y_correct=0;
    double z_coorect=0;

    if(is_groove){
      x_correct=draw_controller.box_repository.pack_panel_grove_depth;
      y_correct=draw_controller.box_repository.pack_panel_grove_depth;
      z_coorect=draw_controller.box_repository.pack_panel_grove_depth;
      line_width=draw_controller.box_repository.pack_panel_thickness;
    }

    if (face.name == 1 || face.name == 3) {
      if (((corner_1.x_coordinate - corner_3.x_coordinate).abs() - thickness) <
          1) {
        sp.x_coordinate = face.corners[0].x_coordinate + thickness / 2;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate - thickness / 2;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate;
      } else {
        sp.x_coordinate = face.corners[0].x_coordinate-x_correct;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate + thickness / 2;

        ep.x_coordinate = face.corners[2].x_coordinate+x_correct;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate - thickness / 2;
      }
    }
    else if (face.name == 2 || face.name == 4) {
      if (((corner_3.z_coordinate - corner_1.z_coordinate).abs() - thickness) <
          1) {
        sp.x_coordinate = face.corners[0].x_coordinate;
        sp.y_coordinate = face.corners[0].y_coordinate-y_correct;
        sp.z_coordinate = face.corners[0].z_coordinate + thickness / 2;

        ep.x_coordinate = face.corners[2].x_coordinate;
        ep.y_coordinate = face.corners[2].y_coordinate+y_correct;
        ep.z_coordinate = face.corners[2].z_coordinate - thickness / 2;
      } else {
        sp.x_coordinate = face.corners[0].x_coordinate;
        sp.y_coordinate = face.corners[0].y_coordinate + thickness / 2;
        sp.z_coordinate = face.corners[0].z_coordinate-z_coorect;

        ep.x_coordinate = face.corners[2].x_coordinate;
        ep.y_coordinate = face.corners[2].y_coordinate - thickness / 2;
        ep.z_coordinate = face.corners[2].z_coordinate+z_coorect;
      }
    }
    else if (face.name == 5 || face.name == 6) {
      if (((corner_3.x_coordinate - corner_1.x_coordinate).abs() - thickness) <
          1) {
        sp.x_coordinate = face.corners[0].x_coordinate +
            (corner_3.x_coordinate - corner_1.x_coordinate) / 2;
        sp.y_coordinate = face.corners[0].y_coordinate;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate -
            (corner_3.x_coordinate - corner_1.x_coordinate) / 2;
        ep.y_coordinate = face.corners[2].y_coordinate;
        ep.z_coordinate = face.corners[2].z_coordinate;
      } else {
        sp.x_coordinate = face.corners[0].x_coordinate-x_correct;
        sp.y_coordinate = face.corners[0].y_coordinate +
            (corner_3.y_coordinate - corner_1.y_coordinate) / 2;
        sp.z_coordinate = face.corners[0].z_coordinate;

        ep.x_coordinate = face.corners[2].x_coordinate+z_coorect;
        ep.y_coordinate = face.corners[2].y_coordinate -
            (corner_3.y_coordinate - corner_1.y_coordinate) / 2;
        ep.z_coordinate = face.corners[2].z_coordinate;
      }
    }

    Line line = Line(sp, ep,line_width);

    return line;
  }

  /// find center of face
  Point_model face_center(Single_Face face) {
    Point_model face_center = Point_model(0, 0, 0);

    Point_model p1 = face.corners[0];
    Point_model p3 = face.corners[2];

    /// the face in the YZ plane
    if (p1.x_coordinate == p3.x_coordinate) {
      face_center.x_coordinate = p1.x_coordinate;
      face_center.y_coordinate = (p1.y_coordinate + p3.y_coordinate) / 2;
      face_center.z_coordinate = (p1.z_coordinate + p3.z_coordinate) / 2;
    } else

    /// the face in the XZ plane
    if (p1.y_coordinate == p3.y_coordinate) {
      face_center.y_coordinate = p1.y_coordinate;
      face_center.x_coordinate = (p1.x_coordinate + p3.x_coordinate) / 2;
      face_center.z_coordinate = (p1.z_coordinate + p3.z_coordinate) / 2;
    } else

    /// the face in the XY plane
    if (p1.z_coordinate == p3.z_coordinate) {
      face_center.z_coordinate = p1.z_coordinate;
      face_center.y_coordinate = (p1.y_coordinate + p3.y_coordinate) / 2;
      face_center.x_coordinate = (p1.x_coordinate + p3.x_coordinate) / 2;
    }

    return face_center;
  }


  /// if the center of face in the second face
  bool check_face_in_face(Single_Face mface, Single_Face sface) {
    bool in_face = false;

    if (check_if_same_plane(mface, sface)) {
      Point_model mp0 = mface.corners[0];
      Point_model mp2 = mface.corners[2];

      Point_model sp0 = sface.corners[0];
      Point_model sp2 = sface.corners[2];

      if (face_plane(mface) == 'XY') {
        bool compare_X = (mp0.x_coordinate <= sp0.x_coordinate) &&
            (mp2.x_coordinate >= sp2.x_coordinate);
        bool compare_Y = (mp0.y_coordinate <= sp0.y_coordinate) &&
            (mp2.y_coordinate >= sp2.y_coordinate);
        bool compare_Z = (mp0.z_coordinate <= sp0.z_coordinate) &&
            (mp2.z_coordinate >= sp2.z_coordinate);

        if (compare_X && compare_Y) {
          in_face = true;
        }
      }
      else if (face_plane(mface) == 'XZ') {
        bool compare_X = (mp0.x_coordinate <= sp0.x_coordinate) &&
            (mp2.x_coordinate >= sp2.x_coordinate);
        bool compare_Y = (mp0.y_coordinate <= sp0.y_coordinate) &&
            (mp2.y_coordinate >= sp2.y_coordinate);
        bool compare_Z = (mp0.z_coordinate <= sp0.z_coordinate) &&
            (mp2.z_coordinate >= sp2.z_coordinate);

        if (compare_X && compare_Z) {
          in_face = true;
        }
      }
      else if (face_plane(mface) == 'YZ') {
        bool compare_X = (mp0.x_coordinate <= sp0.x_coordinate) &&
            (mp2.x_coordinate >= sp2.x_coordinate);

        bool compare_Y = (mp0.y_coordinate <= sp0.y_coordinate) &&
            (mp2.y_coordinate >= sp2.y_coordinate);
        bool compare_Z = (mp0.z_coordinate <= sp0.z_coordinate) &&
            (mp2.z_coordinate >= sp2.z_coordinate);

        if (compare_Z && compare_Y) {
          in_face = true;
        }
      }

    }

    return in_face;
  }

  ///is_point_in_face
  bool check_if_point_in_face(Single_Face face, Point_model p) {
    bool in_face = false;

    /// xy plane
    if (face_plane(face) == 'XY') {
      Point_model mp0 = face.corners[0];
      Point_model mp2 = face.corners[2];

      bool compair_x = (mp0.x_coordinate <= p.x_coordinate) &&
          (mp2.x_coordinate >= p.x_coordinate);
      bool compair_y = (mp0.y_coordinate <= p.y_coordinate) &&
          (mp2.y_coordinate >= p.y_coordinate);
      bool compair_z = (mp0.z_coordinate <= p.z_coordinate) &&
          (mp2.z_coordinate >= p.z_coordinate);

      if (compair_x && compair_y && compair_z) {
        in_face = true;
      }
    }

    /// xz plane
    else if (face_plane(face) == 'XZ') {
      Point_model mp0 = face.corners[0];
      Point_model mp2 = face.corners[2];

      bool compair_x = (mp0.x_coordinate <= p.x_coordinate) &&
          (mp2.x_coordinate >= p.x_coordinate);
      bool compair_y = (mp0.y_coordinate <= p.y_coordinate) &&
          (mp2.y_coordinate >= p.y_coordinate);
      bool compair_z = (mp0.z_coordinate <= p.z_coordinate) &&
          (mp2.z_coordinate >= p.z_coordinate);

      if (compair_x && compair_y && compair_z) {
        in_face = true;
      }
    }

    /// yz plane
    else if (face_plane(face) == 'YZ') {
      Point_model mp0 = face.corners[0];
      Point_model mp2 = face.corners[2];

      bool compair_x = (mp0.x_coordinate <= p.x_coordinate) &&
          (mp2.x_coordinate >= p.x_coordinate);
      bool compair_y = (mp0.y_coordinate <= p.y_coordinate) &&
          (mp2.y_coordinate >= p.y_coordinate);
      bool compair_z = (mp0.z_coordinate <= p.z_coordinate) &&
          (mp2.z_coordinate >= p.z_coordinate);


      if (compair_x && compair_y && compair_z) {
        in_face = true;
      }
    }

    return in_face;
  }

  /// detect face plane
  String face_plane(Single_Face face) {
    late String plane;

    Point_model p1 = face.corners[0];
    Point_model p3 = face.corners[2];

    /// the face in the YZ plane
    if (p1.x_coordinate == p3.x_coordinate) {
      plane = 'YZ';
    } else

    /// the face in the XZ plane
    if (p1.y_coordinate == p3.y_coordinate) {
      plane = "XZ";
    } else

    /// the face in the XY plane
    if (p1.z_coordinate == p3.z_coordinate) {
      plane = 'XY';
    }

    return plane;
  }

  /// check if it in same plane
  bool check_if_same_plane(Single_Face main_face, Single_Face secondary) {
    bool same_plane = false;
    String main_plane = face_plane(main_face);
    String secondary_plane = face_plane(secondary);

    if (main_plane == secondary_plane) {
      if (main_plane == 'XY') {
        if (face_center(main_face).z_coordinate ==
            face_center(secondary).z_coordinate) {
          same_plane = true;
        }
      } else if (main_plane == 'XZ') {
        if (face_center(main_face).y_coordinate ==
            face_center(secondary).y_coordinate) {
          same_plane = true;
        }
      } else if (main_plane == 'YZ') {
        if (face_center(main_face).x_coordinate ==
            face_center(secondary).x_coordinate) {
          same_plane = true;
        }
      } else {
        same_plane = false;
      }
    }

    return same_plane;
  }

  /// all next method are to discover the intersection between tow faces

  /// discover intersection between tow line
  bool discover_lines_intersect(Line l1, Line l2, String plane) {
    bool intersected = false;
    Point_model l1sp = l1.start_point;
    Point_model l1ep = l1.end_point;
    Point_model l2sp = l2.start_point;
    Point_model l2ep = l2.end_point;

    if (line_axis(l1) != line_axis(l2)) {
      if (plane == "XY") {
        if (line_axis(l1) == "X") {
          bool x_compare = (l1sp.x_coordinate < l2sp.x_coordinate &&
                  l1ep.x_coordinate > l2sp.x_coordinate) ||
              (l1sp.x_coordinate > l2sp.x_coordinate &&
                  l1ep.x_coordinate < l2sp.x_coordinate);

          bool y_compare = (l2sp.y_coordinate < l1sp.y_coordinate &&
                  l2ep.y_coordinate > l1sp.y_coordinate) ||
              (l2sp.y_coordinate > l1sp.y_coordinate &&
                  l2ep.y_coordinate < l1sp.y_coordinate);

          intersected = x_compare && y_compare;
        } else {
          bool x_compare = (l2sp.x_coordinate < l1sp.x_coordinate &&
                  l2ep.x_coordinate > l1sp.x_coordinate) ||
              (l2sp.x_coordinate > l1sp.x_coordinate &&
                  l2ep.x_coordinate < l1sp.x_coordinate);

          bool y_compare = (l1sp.y_coordinate < l2sp.y_coordinate &&
                  l1ep.y_coordinate > l2sp.y_coordinate) ||
              (l1sp.y_coordinate > l2sp.y_coordinate &&
                  l1ep.y_coordinate < l2sp.y_coordinate);

          intersected = x_compare && y_compare;
        }
      }

      if (plane == "XZ") {
        if (line_axis(l1) == "X") {
          bool x_compare = (l1sp.x_coordinate < l2sp.x_coordinate &&
                  l1ep.x_coordinate > l2sp.x_coordinate) ||
              (l1sp.x_coordinate > l2sp.x_coordinate &&
                  l1ep.x_coordinate < l2sp.x_coordinate);

          bool z_compare = (l2sp.z_coordinate < l1sp.z_coordinate &&
                  l2ep.z_coordinate > l1sp.z_coordinate) ||
              (l2sp.z_coordinate > l1sp.z_coordinate &&
                  l2ep.z_coordinate < l1sp.z_coordinate);

          intersected = x_compare && z_compare;
        } else {
          bool x_compare = (l2sp.x_coordinate < l1sp.x_coordinate &&
                  l2ep.x_coordinate > l1sp.x_coordinate) ||
              (l2sp.x_coordinate > l1sp.x_coordinate &&
                  l2ep.x_coordinate < l1sp.x_coordinate);

          bool z_compare = (l1sp.z_coordinate < l2sp.z_coordinate &&
                  l1ep.z_coordinate > l2sp.z_coordinate) ||
              (l1sp.z_coordinate > l2sp.z_coordinate &&
                  l1ep.z_coordinate < l2sp.z_coordinate);

          intersected = x_compare && z_compare;
        }
      }

      if (plane == "YZ") {
        if (line_axis(l1) == "Z") {
          bool z_compare = (l1sp.z_coordinate < l2sp.z_coordinate &&
                  l1ep.z_coordinate > l2sp.z_coordinate) ||
              (l1sp.z_coordinate > l2sp.z_coordinate &&
                  l1ep.z_coordinate < l2sp.z_coordinate);

          bool y_compare = (l2sp.y_coordinate < l1sp.y_coordinate &&
                  l2ep.y_coordinate > l1sp.y_coordinate) ||
              (l2sp.y_coordinate > l1sp.y_coordinate &&
                  l2ep.y_coordinate < l1sp.y_coordinate);

          intersected = z_compare && y_compare;
        } else {
          bool z_compare = (l2sp.z_coordinate < l1sp.z_coordinate &&
                  l2ep.z_coordinate > l1sp.z_coordinate) ||
              (l2sp.z_coordinate > l1sp.z_coordinate &&
                  l2ep.z_coordinate < l1sp.z_coordinate);

          bool y_compare = (l1sp.y_coordinate < l2sp.y_coordinate &&
                  l1ep.y_coordinate > l2sp.y_coordinate) ||
              (l1sp.y_coordinate > l2sp.y_coordinate &&
                  l1ep.y_coordinate < l2sp.y_coordinate);

          intersected = z_compare && y_compare;
        }
      }
    }

    return intersected;
  }

  /// discover the axis of the line
  String line_axis(Line l) {
    late String axis;
    Point_model sp = l.start_point;
    Point_model ep = l.end_point;

    if (sp.x_coordinate == ep.x_coordinate &&
        sp.y_coordinate == ep.y_coordinate) {
      axis = "Z";
    } else if (sp.x_coordinate == ep.x_coordinate &&
        sp.z_coordinate == ep.z_coordinate) {
      axis = "Y";
    } else if (sp.z_coordinate == ep.z_coordinate &&
        sp.y_coordinate == ep.y_coordinate) {
      axis = "X";
    } else {
      axis = 'Z';
    }

    return axis;
  }

  /// extract face edges as lines
  List<Line> extract_face_lines(Single_Face face) {
    List<Line> face_line = [];
    for (int i = 0; i < 4; i++) {
      int t = i;
      if (t == 3) {
        Line line = Line(face.corners[i], face.corners[0],1);
        face_line.add(line);
        continue;
      } else {
        Line line = Line(face.corners[i], face.corners[i + 1],1);
        face_line.add(line);
      }
    }

    return face_line;
  }

  /// detect the other tow corner witch will be the corners of the face that not intersected,
  /// but have same coordinate of second face border
  List<Point_model> extract_intersection_rect_corner(
      Single_Face face1, Single_Face face2) {
    List<Point_model> corners = [];

    for (int i = 0; i < 4; i++) {
      Point_model p = face1.corners[i];

      if (check_if_point_in_face(face2, p)) {
        corners.add(p);
        // for (int ii = 0; ii < corners.length; ii++) {
        //
        //   Point_model tp = corners[ii];
        //   if (tp.x_coordinate == p.x_coordinate &&
        //       tp.y_coordinate == p.y_coordinate &&
        //       tp.z_coordinate == p.z_coordinate)
        //   {
        //     continue;
        //   }
        //   else
        //   {
        //     corners.add(p);
        //   }
        //
        // }
      }
    }

    for (int i = 0; i < 4; i++) {
      Point_model p = face2.corners[i];

      if (check_if_point_in_face(face1, p)) {
        corners.add(p);

        // for (int ii = 0; ii < corners.length; ii++) {
        //
        //   Point_model tp = corners[ii];
        //   if (tp.x_coordinate == p.x_coordinate &&
        //       tp.y_coordinate == p.y_coordinate &&
        //       tp.z_coordinate == p.z_coordinate)
        //   {
        //     continue;
        //   } else {
        //     corners.add(p);
        //   }
        //
        // }
      }
    }

    return corners;
  }

  Line check_tow_face_intersected(Box_model box_model,Single_Face face1, Single_Face face2) {

     Line line = Line(Point_model(0, 0, 0), Point_model(0, 0, 0),1);

    List<Point_model> intersection_rect = [];

    if (check_if_same_plane(face1, face2)) {

      for (int f1 = 0; f1 < extract_face_lines(face1).length; f1++) {
        Line l1 = extract_face_lines(face1)[f1];

        // /// // / // / /  // /  / / / /
        // print(f1);
        //
        //
        // print("l1S: X=${l1.start_point.x_coordinate} ,Y=${l1.start_point.y_coordinate} , Z=:${l1.start_point.z_coordinate}");
        // print("l1E: X=${l1.end_point.x_coordinate}   ,Y=${l1.end_point.y_coordinate}   , Z=:${l1.end_point.z_coordinate}");
        // print("=========");
        //
        // Line l2 = extract_face_lines(face2)[f1];
        //
        // print("l2S: X=${l2.start_point.x_coordinate} ,Y=${l2.start_point.y_coordinate} , Z=:${l2.start_point.z_coordinate}");
        // print("l2E: X=${l2.end_point.x_coordinate}   ,Y=${l2.end_point.y_coordinate}   , Z=:${l2.end_point.z_coordinate}");
        // print("=========");
        //
        // /// // / // / /  // /  / / / /

        for (int f2 = 0; f2 < extract_face_lines(face2).length; f2++) {
          Line l2 = extract_face_lines(face2)[f2];


          if (discover_lines_intersect(l1, l2, face_plane(face1))) {

            late double x;
            late double y;
            late double z;

            if (l1.start_point.x_coordinate == l1.end_point.x_coordinate)
            {
              x = l1.start_point.x_coordinate;
            }
            else if (l2.start_point.x_coordinate == l2.end_point.x_coordinate)
            {
              x = l2.start_point.x_coordinate;
            }
            else
            {
              print(
                  "l1 x : ${l1.start_point.x_coordinate} , l1  eX:${l1.end_point.x_coordinate}");
            }

            if (l1.start_point.y_coordinate == l1.end_point.y_coordinate)
            {
              y = l1.start_point.y_coordinate;
            }
            else if (l2.start_point.y_coordinate == l2.end_point.y_coordinate)
            {
              y = l2.start_point.y_coordinate;
            }

            if (l1.start_point.z_coordinate == l1.end_point.z_coordinate)
            {
              z = l1.start_point.z_coordinate;
            }
            else if (l2.start_point.z_coordinate == l2.end_point.z_coordinate)
            {
              z = l2.start_point.z_coordinate;
            }

            intersection_rect.add(Point_model(x, y, z));
          }
        }
      }

      if (intersection_rect.length != 0) {
        List<Point_model> other_corners = extract_intersection_rect_corner(face1, face2);
        other_corners.forEach((element) {
          intersection_rect.add(element);
        });

        // print('other_corners :${other_corners.length}');
        // print('intersection_rect :${intersection_rect.length}');

        line = extract_join_line(box_model,intersection_rect, face1);



      }
    }



    return line;
  }

  /// nesting the points of intersection rectangle corners
  /// and add join line for both faces
  Line extract_join_line(Box_model box_model,List<Point_model> corners, Single_Face face_1) {

      Line local_join_line=Line(Point_model(0,0,0), Point_model(0,0,0),1);

    late Point_model join_line_start_point;
    late Point_model join_line_end_point;

    List<Point_model> l1 = [];
    List<Point_model> l2 = [];

    Point_model p1 = corners[0];
    String plane = face_plane(face_1);

    if (plane == "XY") {
      l1.add(p1);
      for (int i = 1; i < corners.length; i++) {
        if (p1.x_coordinate == corners[i].x_coordinate) {
          l2.add(corners[i]);
        } else if (p1.y_coordinate == corners[i].y_coordinate) {
          l1.add(corners[i]);
        }
      }

      bool xdir = l1[0].x_coordinate > l1[1].x_coordinate;
      bool ydir = l1[0].y_coordinate < l2[0].y_coordinate;

      double x_cord = xdir
          ? (l1[0].x_coordinate - (box_model.init_material_thickness) / 2)
          : (l1[0].x_coordinate + (box_model.init_material_thickness) / 2);

      join_line_start_point = Point_model(x_cord,
          ydir ? l1[0].y_coordinate : l2[0].y_coordinate, l1[0].z_coordinate);

      join_line_end_point = Point_model(x_cord,
          ydir ? l2[0].y_coordinate : l1[0].y_coordinate, l2[0].z_coordinate);
    }
    else if (plane == "XZ") {
      l1.add(p1);

      for (int i = 1; i < corners.length; i++) {
        if (p1.z_coordinate == corners[i].z_coordinate) {
          l2.add(corners[i]);
        } else if (p1.x_coordinate == corners[i].x_coordinate) {
          l1.add(corners[i]);
        }
      }
      late bool join_axis_is_Z;
      if ((l1[0].z_coordinate - l2[0].z_coordinate).obs ==
          box_model.init_material_thickness) {
        join_axis_is_Z = false;
      } else {
        join_axis_is_Z = true;
      }
      late double x_cord_1;
      late double x_cord_2;
      if (join_axis_is_Z) {
        x_cord_1 = (l1[0].x_coordinate + l2[0].x_coordinate) / 2;
        x_cord_2 = x_cord_1;
      } else {
        if (l1[0].x_coordinate < l2[0].x_coordinate) {
          x_cord_1 = l1[0].x_coordinate;
          x_cord_2 = l2[0].x_coordinate;
        } else {
          x_cord_1 = l2[0].x_coordinate;
          x_cord_2 = l1[0].x_coordinate;
        }
      }

      late double z_cord_1;
      late double z_cord_2;

      if (join_axis_is_Z) {
        z_cord_1 = l1[0].z_coordinate;
        z_cord_2 = l1[1].z_coordinate;
      } else {
        if (l1[0].z_coordinate < l2[0].z_coordinate) {
          z_cord_1 = l1[0].z_coordinate;
          z_cord_2 = l2[0].z_coordinate;
        } else {
          z_cord_1 = l2[0].z_coordinate;
          z_cord_2 = l1[0].z_coordinate;
        }
      }

      join_line_start_point = Point_model(x_cord_1, l1[0].y_coordinate, z_cord_1);
      join_line_end_point = Point_model(x_cord_2, l1[0].y_coordinate, z_cord_2);
    }
    else if (plane == "YZ") {

      l1.add(p1);

      for (int i = 1; i < corners.length; i++) {
        if (p1.z_coordinate == corners[i].z_coordinate) {
          l2.add(corners[i]);
        } else if (p1.y_coordinate == corners[i].y_coordinate) {
          l1.add(corners[i]);
        }
      }
      late bool join_axis_is_Z;

      if (((l1[0].z_coordinate - l1[1].z_coordinate)).abs() >
          ((l1[0].y_coordinate - l2[0].y_coordinate)).abs()) {
        join_axis_is_Z = true;
      } else {
        join_axis_is_Z = false;
      }
      late double y_cord_1;
      late double y_cord_2;
      if (join_axis_is_Z) {
        y_cord_1 = (l1[0].y_coordinate + l2[0].y_coordinate) / 2;
        y_cord_2 = y_cord_1;
      }
      else {
        if (l1[0].y_coordinate < l2[0].y_coordinate) {
          y_cord_1 = l1[0].y_coordinate;
          y_cord_2 = l2[0].y_coordinate;
        } else {
          y_cord_1 = l2[0].y_coordinate;
          y_cord_2 = l1[0].y_coordinate;
        }
      }

      late double z_cord_1;
      late double z_cord_2;

      if (join_axis_is_Z) {

        if (l1[0].z_coordinate < l1[1].z_coordinate) {
          z_cord_1 = l1[0].z_coordinate;
          z_cord_2 = l1[1].z_coordinate;
        } else {
          z_cord_1 = l1[1].z_coordinate;
          z_cord_2 = l1[0].z_coordinate;
        }
      }
      else {


        z_cord_1 = (l1[0].z_coordinate + l1[1].z_coordinate) / 2;
        z_cord_2 = z_cord_1;
      }

      join_line_start_point = Point_model(l1[0].x_coordinate, y_cord_1, z_cord_1);
      join_line_end_point = Point_model(l1[0].x_coordinate, y_cord_2, z_cord_2);

      if(join_axis_is_Z){
        if (join_line_start_point.z_coordinate < join_line_end_point.z_coordinate)
        {
          local_join_line = Line(join_line_start_point, join_line_end_point,1);
        }
        else
        {
          local_join_line = Line(join_line_end_point, join_line_start_point,1);
        }
      }
      else{if (join_line_start_point.y_coordinate < join_line_end_point.y_coordinate)
      {
        local_join_line = Line(join_line_start_point, join_line_end_point,1);
      }


      }



    }





    return local_join_line;
  }

  int detect_second_face(Box_model box_model, String piece_name, String piece_direction, Single_Face face) {
    int second_face_id = 0;

    if (piece_direction == "H") {
        if (piece_name.contains("top")) {
          second_face_id = 0;
        }else{
          second_face_id = 2;

        }

    }
    else if (piece_direction == "V") {
      if (piece_name.contains("left") || piece_name.contains("DBR")) {
        second_face_id = 1;
      }
      else {
        second_face_id = 3;
      }
    }
    else if (piece_direction == "F") {

      if (piece_name.contains("DBF")) {
        second_face_id = 4;
      }
      else {
        second_face_id = 5;
      }


     }

    return second_face_id;
  }

  String detect_face_direction(String piece_direction, Single_Face face) {
    String face_direction = 'V';

    if (piece_direction == "H") {
      if (face.name == 2 ||
          face.name == 4 ||
          face.name == 5 ||
          face.name == 6) {
        face_direction = "H";
      } else if (face.name == 1) {
        face_direction = "V";
      } else if (face.name == 3) {
        face_direction = "B";
      }
    } else if (piece_direction == "V") {
      if (face.name == 1 ||
          face.name == 3 ||
          face.name == 5 ||
          face.name == 6) {
        face_direction = "H";
      } else if (face.name == 2) {
        face_direction = "V";
      } else if (face.name == 4) {
        face_direction = "B";
      }
    } else if (piece_direction == "F") {
      if (face.name == 1 ||
          face.name == 2 ||
          face.name == 3 ||
          face.name == 4) {
        face_direction = "H";
      } else if (face.name == 5) {
        face_direction = "V";
      } else if (face.name == 6) {
        face_direction = "B";
      }
    } else {
      face_direction = 'R';
    }

    return face_direction;
  }

  double calculate_length_of_line(Line line, String axis) {
    late double length;
    if (axis == "X") {
      length = line.end_point.x_coordinate - line.start_point.x_coordinate;
    } else if (axis == "Y") {
      length = line.end_point.y_coordinate - line.start_point.y_coordinate;
    } else if (axis == "Z") {
      length = line.end_point.z_coordinate - line.start_point.z_coordinate;
    }
    return length.abs();
  }


  /// collect same pieces [] ....
  collect_all_same_pieces(bool collect) {

    List<Piece_model> pices =[];

  pices=draw_controller.box_repository.box_model.value.box_pieces;

if(collect)
    {

      List<String> compared = [];

      List<List<Piece_model>> same_pices = [];

      for (int m = 0; m < pices.length; m++) {
        Piece_model m_piece = pices[m];

        if (!compared.contains(m_piece.piece_id) &&
            !m_piece.piece_name.contains('Helper') &&
            !m_piece.piece_name.contains('inner')&&
            m_piece.piece_thickness!=0

        ) {
          List<Piece_model> same_pices_item = [];
          same_pices_item.add(m_piece);
          compared.add(m_piece.piece_id);

          ///

          for (int s = 0; s < pices.length; s++) {
            Piece_model s_piece = pices[s];

            if (!compared.contains(s_piece.piece_id) &&
                !s_piece.piece_name.contains('Helper') &&
                !s_piece.piece_name.contains('inner')&&
                m_piece.piece_thickness!=0) {
              if (tow_pieces_are_same(m_piece, s_piece)) {
                same_pices_item.add(s_piece);
                compared.add(s_piece.piece_id);
              }
            }
          }

          ///

          same_pices.add(same_pices_item);
        }
      }

      same_pices.forEach((items) {
        String names = '';
        String ids = '';

        String material_name = items[0].material_name;
        items.forEach((element) {
          names = '$names\n '
              '${element.piece_name}';

        });

        items.forEach((element) {
          ids = '$ids\n '
              '${element.piece_id}';

        });

        Cut_List_Item cut_list_item = Cut_List_Item(
            ids,
            names,
            material_name,
            items[0].piece_thickness,
            items[0].piece_width,
            items[0].piece_height,
            items.length);

        draw_controller.box_repository.cut_list_items.add(cut_list_item);
      });

    }
else
{

  for(int pi=0;pi<pices.length;pi++){
    if(
    !pices[pi].piece_name.contains("Helper") &&
        !pices[pi].piece_name.contains("inner") &&
    pices[pi].piece_thickness!=0

    ){

      Cut_List_Item cut_list_item = Cut_List_Item(
          pices[pi].piece_id,
          pices[pi].piece_name,
          pices[pi].material_name,
          pices[pi].piece_thickness,
          pices[pi].piece_width,
          pices[pi].piece_height,
          1
      );

      draw_controller.box_repository.cut_list_items.add(cut_list_item);
    }
  }
}


  }

  bool tow_pieces_are_same(Piece_model m_piece, Piece_model s_piece) {
    bool same = false;
    bool width_same = (m_piece.piece_width == s_piece.piece_width);
    bool height_same = (m_piece.piece_height == s_piece.piece_height);
    bool thickness_same = (m_piece.piece_thickness == s_piece.piece_thickness);
    bool faces_same = false;
    if (width_same && height_same && thickness_same) {
      same = true;

      for (int f = 0; f < m_piece.piece_faces.faces.length; f++) {
        Single_Face m_single_face = m_piece.piece_faces.faces[f];
        Single_Face s_single_face = s_piece.piece_faces.faces[f];
        if (same_faces(m_single_face, s_single_face)) {
          faces_same = true;
        }
      }
    }

    return same;
  }

  bool same_faces(Single_Face m_face, Single_Face s_face) {
    bool resault = true;

    List<Bore_model> m_bores = m_face.bores;
    List<Bore_model> s_bores = s_face.bores;

    if (m_bores.length == s_bores.length) {
    } else {
      resault = false;
    }

    return resault;
  }
}
