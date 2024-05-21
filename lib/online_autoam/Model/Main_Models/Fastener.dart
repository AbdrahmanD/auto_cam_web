
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';

class Fastener {


  late String type;
  late Point_model fastener_origin;

  late String face_piece_id;
  late Fastener_Hole face_1;
  late Fastener_Hole face_2;

  late String side_piece_id;

  late Fastener_Hole side_1;
  late Fastener_Hole side_face_1;
  late Fastener_Hole side_face_2;

  Fastener(
      this.type,
      this.fastener_origin,
      this.face_piece_id,
      this.face_1,
      this.face_2,
      this.side_piece_id,
      this.side_1,
      this.side_face_1,
      this.side_face_2);
}


class Fastener_Hole{
  late double diameter;
  late double depth;

  Fastener_Hole(this.diameter, this.depth);
}