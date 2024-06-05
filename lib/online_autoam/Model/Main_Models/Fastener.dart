import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener_shape_3d.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
import 'package:get/get.dart';

class Fastener {
  late int id;

  late Fastener_Templet fastener_templet;
  late Point_model fastener_origin;
  late String fastener_axis;
  late bool fastener_direction;

  late double material_thickness;

  late int face_pice_id;
  late int side_pice_id;

  late int facee_name;
  late int side_name;

  late Bore_model face_1_bore;
  late Bore_model face_2_bore;
  late Bore_model side_bore;
  late Bore_model side_face_1_bore;
  late Bore_model side_face_2_bore;

  late bool rebuild;
  Draw_Controller draw_controller = Get.find();

  Fastener(
      this.id,
      this.fastener_templet,
      this.fastener_origin,
      this.fastener_axis,
      this.fastener_direction,
      this.material_thickness,
      this.face_pice_id,
      this.side_pice_id,
      this.facee_name,
      this.side_name,
      this.rebuild) {
    if (rebuild) {
      transform_fastener_to_hole();
    } else {
      face_1_bore = Bore_model(0, Point_model(0, 0, 0), 0, 0);
      face_2_bore = Bore_model(0, Point_model(0, 0, 0), 0, 0);
      side_bore = Bore_model(0, Point_model(0, 0, 0), 0, 0);
      side_face_1_bore = Bore_model(0, Point_model(0, 0, 0), 0, 0);
      side_face_2_bore = Bore_model(0, Point_model(0, 0, 0), 0, 0);
    }
  }

  transform_fastener_to_hole() {
    Piece_model face_piece =
        draw_controller.box_repository.box_model.value.box_pieces[face_pice_id];
    Piece_model side_piece =
        draw_controller.box_repository.box_model.value.box_pieces[side_pice_id];

    if (fastener_axis == "X") {

      face_1_bore = Bore_model(id,
          Point_model(
              fastener_direction
                  ? (fastener_origin.x_coordinate -fastener_templet.face_1_depth)
                  : (fastener_origin.x_coordinate +fastener_templet.face_1_depth),
              fastener_origin.y_coordinate,
              fastener_origin.z_coordinate),
          fastener_templet.face_1_diameter, fastener_templet.face_1_depth);
      side_bore = Bore_model(id, fastener_origin,
          fastener_templet.side_diameter, fastener_templet.side_depth);

      face_2_bore = Bore_model(
          id,
          Point_model(
              fastener_direction
                  ? (fastener_origin.x_coordinate - material_thickness)
                  : (fastener_origin.x_coordinate + material_thickness),
              fastener_origin.y_coordinate,
              fastener_origin.z_coordinate),
          fastener_templet.face_2_diameter,
          fastener_templet.face_2_depth);

      double y1 = 0;
      double y2 = 0;

      double z1 = 0;
      double z2 = 0;

      if (side_piece.piece_direction == "H") {
        y1 = fastener_origin.y_coordinate + material_thickness / 2;
        z1 = fastener_origin.z_coordinate;

        y2 = fastener_origin.y_coordinate - material_thickness / 2;
        z2 = fastener_origin.z_coordinate;
      }
      else if (side_piece.piece_direction == "F") {
        y1 = fastener_origin.y_coordinate;
        z1 = fastener_origin.z_coordinate + material_thickness / 2;

        y2 = fastener_origin.y_coordinate;
        z2 = fastener_origin.z_coordinate - material_thickness / 2;
      }

      side_face_1_bore = Bore_model(
          id,
          Point_model(
              fastener_direction
                  ? (fastener_origin.x_coordinate +
                      fastener_templet.side_to_face)
                  : fastener_origin.x_coordinate -
                      fastener_templet.side_to_face,
              y1,
              z1),
          fastener_templet.side_face_1_diameter,
          fastener_templet.side_face_1_depth);

      side_face_2_bore = Bore_model(
          id,
          Point_model(
              fastener_direction
                  ? (fastener_origin.x_coordinate +
                      fastener_templet.side_to_face)
                  : fastener_origin.x_coordinate -
                      fastener_templet.side_to_face,
              y2,
              z2),
          fastener_templet.side_face_2_diameter,
          fastener_templet.side_face_2_depth);

      if (face_1_bore.diameter > 0) {
        face_piece.piece_faces.faces[facee_name].bores.add(face_1_bore);
      }
      if (face_2_bore.diameter > 0) {
        face_piece.piece_faces.faces[finde_parallel_face(facee_name)].bores
            .add(face_2_bore);
      }
      if (side_bore.diameter > 0) {
        side_piece.piece_faces.faces[side_name].bores.add(side_bore);
      }

      if (side_face_1_bore.diameter > 0) {
        side_piece
            .piece_faces
            .faces[
                finde_perpendiculer_face(side_name, side_piece.piece_direction,side_piece.piece_name,"X")]
            .bores
            .add(side_face_1_bore);
      }

      if (side_face_2_bore.diameter > 0) {
        side_piece
            .piece_faces
            .faces[finde_parallel_face(finde_perpendiculer_face(
                side_name, side_piece.piece_direction,side_piece.piece_name,"X"))]
            .bores
            .add(side_face_2_bore);
      }
    }

    if (fastener_axis == "Y") {
      face_1_bore = Bore_model(id, Point_model(
          fastener_origin.x_coordinate,
          fastener_direction
              ? (fastener_origin.y_coordinate - fastener_templet.face_1_depth)
              : (fastener_origin.y_coordinate + fastener_templet.face_1_depth),
          fastener_origin.z_coordinate), fastener_templet.face_1_diameter, fastener_templet.face_1_depth);
      side_bore = Bore_model(id, fastener_origin, fastener_templet.side_diameter, fastener_templet.side_depth);

      face_2_bore = Bore_model(
          id,
          Point_model(
              fastener_origin.x_coordinate,
              fastener_direction
                  ? (fastener_origin.y_coordinate - material_thickness)
                  : (fastener_origin.y_coordinate + material_thickness),
              fastener_origin.z_coordinate),
          fastener_templet.face_2_diameter,
          fastener_templet.face_2_depth);


      double x1 = 0;
      double x2 = 0;

      double z1 = 0;
      double z2 = 0;

      if (side_piece.piece_direction == "V") {
        x1 = fastener_origin.x_coordinate + material_thickness / 2;
        z1 = fastener_origin.z_coordinate;

        x2 = fastener_origin.x_coordinate - material_thickness / 2;
        z2 = fastener_origin.z_coordinate;
      }
      else if (side_piece.piece_direction == "F") {
        x1 = fastener_origin.x_coordinate;
        z1 = fastener_origin.z_coordinate + material_thickness / 2;

        x2 = fastener_origin.x_coordinate;
        z2 = fastener_origin.z_coordinate - material_thickness / 2;
      }

      side_face_1_bore = Bore_model(
          id,
          Point_model(
x1,              fastener_direction
                  ? (fastener_origin.y_coordinate + fastener_templet.side_to_face)
                  : fastener_origin.y_coordinate - fastener_templet.side_to_face,
              z1),
          fastener_templet.side_face_1_diameter,
          fastener_templet.side_face_1_depth);

      side_face_2_bore = Bore_model(
          id,
          Point_model(
x2,              fastener_direction
                  ? (fastener_origin.y_coordinate + fastener_templet.side_to_face)
                  : fastener_origin.y_coordinate - fastener_templet.side_to_face,
              z2),
          fastener_templet.side_face_2_diameter,
          fastener_templet.side_face_2_depth);

      if (face_1_bore.diameter > 0) {
        face_piece.piece_faces.faces[facee_name].bores.add(face_1_bore);
      }
      if (face_2_bore.diameter > 0) {
        face_piece.piece_faces.faces[finde_parallel_face(facee_name)].bores
            .add(face_2_bore);
      }
      if (side_bore.diameter > 0) {
        side_piece.piece_faces.faces[side_name].bores.add(side_bore);
      }
      if (side_face_1_bore.diameter > 0) {
        side_piece
            .piece_faces
            .faces[
                finde_perpendiculer_face(side_name, side_piece.piece_direction,side_piece.piece_name,"Y")]
            .bores
            .add(side_face_1_bore);
      }
      if (side_face_2_bore.diameter > 0) {
        side_piece
            .piece_faces
            .faces[finde_parallel_face(finde_perpendiculer_face(
                side_name, side_piece.piece_direction,side_piece.piece_name,"Y"))]
            .bores
            .add(side_face_2_bore);
      }
    }

    if (fastener_axis == "Z") {

      face_1_bore = Bore_model(id,
          Point_model(
        fastener_origin.x_coordinate,
        fastener_origin.y_coordinate,
        fastener_direction
            ? (fastener_origin.z_coordinate -fastener_templet.face_1_depth)
            : (fastener_origin.z_coordinate +fastener_templet.face_1_depth),

      ), fastener_templet.face_1_diameter, fastener_templet.face_1_depth);

      side_bore = Bore_model(id, fastener_origin, fastener_templet.side_diameter, fastener_templet.side_depth);

      face_2_bore = Bore_model(
          id,
          Point_model(
            fastener_origin.x_coordinate,
            fastener_origin.y_coordinate,
            fastener_direction
                ? (fastener_origin.z_coordinate - material_thickness)
                : (fastener_origin.z_coordinate + material_thickness),
          ),
          fastener_templet.face_2_diameter,
          fastener_templet.face_2_depth);

      double x1 = 0;
      double x2 = 0;

      double y1 = 0;
      double y2 = 0;

      if (side_piece.piece_direction == "V") {
        x1 = fastener_origin.x_coordinate + material_thickness / 2;
        y1 = fastener_origin.y_coordinate;

        x2 = fastener_origin.x_coordinate - material_thickness / 2;
        y2 = fastener_origin.y_coordinate;
      }
      else if (side_piece.piece_direction == "H") {
        x1 = fastener_origin.x_coordinate;
        y1 = fastener_origin.y_coordinate + material_thickness / 2;

        x2 = fastener_origin.x_coordinate;
        y2 = fastener_origin.y_coordinate - material_thickness / 2;
      }

      side_face_1_bore = Bore_model(
          id,
          Point_model(
              x1,y1,
              fastener_direction
                  ? (fastener_origin.z_coordinate +
                      fastener_templet.side_to_face)
                  : (fastener_origin.z_coordinate -
                      fastener_templet.side_to_face)),
          fastener_templet.side_face_1_diameter,
          fastener_templet.side_face_1_depth);

      side_face_2_bore = Bore_model(
          id,
          Point_model(
              x2,y2,
              fastener_direction
                  ? (fastener_origin.z_coordinate +
                      fastener_templet.side_to_face)
                  : (fastener_origin.z_coordinate -
                      fastener_templet.side_to_face)),
          fastener_templet.side_face_2_diameter,
          fastener_templet.side_face_2_depth);

      if (face_1_bore.diameter > 0) {
        face_piece.piece_faces.faces[facee_name].bores.add(face_1_bore);
      }
      if (face_2_bore.diameter > 0) {
        face_piece.piece_faces.faces[finde_parallel_face(facee_name)].bores
            .add(face_2_bore);
      }
      if (side_bore.diameter > 0) {
        side_piece.piece_faces.faces[side_name].bores.add(side_bore);
      }
      if (side_face_1_bore.diameter > 0) {
        side_piece
            .piece_faces
            .faces[
                finde_perpendiculer_face(side_name, side_piece.piece_direction,side_piece.piece_name,"Z")]
            .bores
            .add(side_face_1_bore);
      }
      if (side_face_2_bore.diameter > 0) {
        side_piece
            .piece_faces
            .faces[finde_parallel_face(finde_perpendiculer_face(
                side_name, side_piece.piece_direction,side_piece.piece_name,"Z"))]
            .bores
            .add(side_face_2_bore);
      }
    }
  }

  int finde_parallel_face(int face) {
    int resault = 0;
    if (face == 0) {
      resault = 2;
    }
    if (face == 1) {
      resault = 3;
    }
    if (face == 2) {
      resault = 0;
    }
    if (face == 3) {
      resault = 1;
    }
    if (face == 4) {
      resault = 5;
    }
    if (face == 5) {
      resault = 4;
    }

    return resault;
  }

  int finde_perpendiculer_face(int face, String piece_direction, String side_piece_name, String fastener_axis) {

    int resault = 0;

    if (fastener_axis=="X") {
      
      if (piece_direction == "F") {
          resault = 5;
      }
      
      else if (piece_direction == "H")
      {

      if(side_piece_name.contains("T")){
        resault=0;

      }else  if(side_piece_name.contains("B")||side_piece_name.contains("SH")){
resault=2;
      }

    }

    }

    else if (fastener_axis=="Y") {

      if (piece_direction == "F") {
        resault = 5;
      }

      else if (piece_direction == "V")
      {

        if(side_piece_name.contains("R")){
          resault=1;

        }else  if(side_piece_name.contains("L")||side_piece_name.contains("PA")){
          resault=3;
        }

      }

    }

    else if (fastener_axis=="Z") {

      if (piece_direction == "H") {
        if(side_piece_name.contains("T")){
          resault=0;

        }else  if(side_piece_name.contains("B")||side_piece_name.contains("SH")){
          resault=2;
        }      }

      else if (piece_direction == "V")
      {

        if(side_piece_name.contains("R")){
          resault=1;

        }else  if(side_piece_name.contains("L")||side_piece_name.contains("PA")){
          resault=3;
        }

      }

    }




    return resault;
  }
}

class Fastener_Templet {
  late String name;

  late double side_to_face;

  late double face_1_diameter;
  late double face_1_depth;

  late double face_2_diameter;
  late double face_2_depth;

  late double side_diameter;
  late double side_depth;

  late double side_face_1_diameter;
  late double side_face_1_depth;

  late double side_face_2_diameter;
  late double side_face_2_depth;

  Fastener_Templet(
      this.name,
      this.side_to_face,
      this.face_1_diameter,
      this.face_1_depth,
      this.face_2_diameter,
      this.face_2_depth,
      this.side_diameter,
      this.side_depth,
      this.side_face_1_diameter,
      this.side_face_1_depth,
      this.side_face_2_diameter,
      this.side_face_2_depth);
}
