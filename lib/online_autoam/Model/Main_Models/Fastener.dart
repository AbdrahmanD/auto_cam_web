
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';

class Fastener {


  late int id;
  late Fastener_Templet fastener_templet;

  late Point_model fastener_origin;

  late String fastener_axis;
  late bool fastener_direction;
  late double material_thickness;


  Fastener(
      this.id,
      this.fastener_templet,
      this.fastener_origin,
      this.fastener_axis,
      this.fastener_direction,
      this.material_thickness,
   ){

    if(fastener_axis=="X"){

      fastener_templet.face_1.fastener_hole_origin=fastener_origin;
      fastener_templet.side.fastener_hole_origin=fastener_origin;

      fastener_templet.face_2.fastener_hole_origin=
          Point_model(
              fastener_direction?
              (fastener_origin.x_coordinate-material_thickness):
              (fastener_origin.x_coordinate+material_thickness),
              fastener_origin.y_coordinate,
              fastener_origin.z_coordinate
          );

      fastener_templet.side_face_1.fastener_hole_origin=
          Point_model(
              fastener_direction?
              (fastener_origin.x_coordinate+fastener_templet.side_to_face_hole):
              (fastener_origin.x_coordinate-fastener_templet.side_to_face_hole),
              fastener_origin.y_coordinate + material_thickness/2,
              fastener_origin.z_coordinate
          );

      fastener_templet.side_face_2.fastener_hole_origin=
          Point_model(
              fastener_direction?
              (fastener_origin.x_coordinate+fastener_templet.side_to_face_hole):
              (fastener_origin.x_coordinate-fastener_templet.side_to_face_hole),
              fastener_origin.y_coordinate - material_thickness/2,
              fastener_origin.z_coordinate
          );


    }
    if(fastener_axis=="Y"){

      fastener_templet.face_1.fastener_hole_origin=fastener_origin;
      fastener_templet.side.fastener_hole_origin=fastener_origin;

      fastener_templet.face_2.fastener_hole_origin=
          Point_model(
              fastener_origin.x_coordinate,
              fastener_direction?
              (fastener_origin.y_coordinate-material_thickness):
              (fastener_origin.y_coordinate+material_thickness),
              fastener_origin.z_coordinate,

          );

      fastener_templet.side_face_1.fastener_hole_origin=
          Point_model(
              fastener_origin.x_coordinate + material_thickness/2,
              fastener_direction?
              (fastener_origin.y_coordinate+fastener_templet.side_to_face_hole):
              (fastener_origin.y_coordinate-fastener_templet.side_to_face_hole),
              fastener_origin.z_coordinate
          );

      fastener_templet.side_face_2.fastener_hole_origin=
          Point_model(
              fastener_origin.x_coordinate - material_thickness/2,
              fastener_direction?
              (fastener_origin.y_coordinate+fastener_templet.side_to_face_hole):
              (fastener_origin.y_coordinate-fastener_templet.side_to_face_hole),
              fastener_origin.z_coordinate
          );


    }
    if(fastener_axis=="Z"){

      fastener_templet.face_1.fastener_hole_origin=fastener_origin;
      fastener_templet.side.fastener_hole_origin=fastener_origin;

      fastener_templet.face_2.fastener_hole_origin=
          Point_model(
              fastener_origin.x_coordinate,
              fastener_origin.y_coordinate,
              fastener_direction?
              (fastener_origin.z_coordinate-material_thickness):
              (fastener_origin.z_coordinate+material_thickness),

          );

      fastener_templet.side_face_1.fastener_hole_origin=
          Point_model(
              fastener_origin.x_coordinate + material_thickness/2,
              fastener_origin.y_coordinate,
              fastener_direction?
              (fastener_origin.z_coordinate+fastener_templet.side_to_face_hole):
              (fastener_origin.z_coordinate-fastener_templet.side_to_face_hole),
          );

      fastener_templet.side_face_2.fastener_hole_origin=
          Point_model(
            fastener_origin.x_coordinate - material_thickness/2,
            fastener_origin.y_coordinate,
            fastener_direction?
            (fastener_origin.z_coordinate+fastener_templet.side_to_face_hole):
            (fastener_origin.z_coordinate-fastener_templet.side_to_face_hole),
          );


    }



  }
}

class Fastener_Templet{

  late String name;

  late Fastener_Hole face_1;
  late Fastener_Hole face_2;

  late Fastener_Hole side;
  late double side_to_face_hole;
  late Fastener_Hole side_face_1;
  late Fastener_Hole side_face_2;

  Fastener_Templet(this.name, this.face_1, this.face_2,
      this.side,
      this.side_to_face_hole,
      this.side_face_1, this.side_face_2);

}

class Fastener_Hole{

  late Point_model fastener_hole_origin;
  late double diameter;
  late double depth;

  Fastener_Hole(this.diameter, this.depth);
}