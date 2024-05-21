import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:flutter/material.dart';

class Door_Pattern_Painter extends CustomPainter {
  late List<Bore_unit> door_bore_unit;
  late List<Bore_unit> side_bore_unit;

  late double screen_height;
  late double door_hight;

  Door_Pattern_Painter(this.door_bore_unit,this.side_bore_unit, this.screen_height,
      this.door_hight);

  @override
  void paint(Canvas canvas, Size size) {
    late double scal;
    if (door_hight > screen_height) {
      scal = screen_height / door_hight;
    } else {
      scal = 0.5 ;
    }


    draw_pattern(canvas,door_hight, scal);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  draw_pattern(Canvas canvas, double h, double scal) {



    Paint bore_painter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    Paint piece_painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black;



     Path main_piece_face = Path();

    Path second_piece_face = Path();

    Offset main_origin = Offset(200, 500);

    Offset second_origin = Offset(500, 500);

    main_piece_face.moveTo(main_origin.dx, main_origin.dy + 50 * h * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + h/2 * scal, main_origin.dy);
    main_piece_face.lineTo(main_origin.dx + h/2 * scal, main_origin.dy + 24 * h * scal);
    main_piece_face.lineTo(main_origin.dx, main_origin.dy + 50 * h * scal);

    second_piece_face.moveTo(second_origin.dx , second_origin.dy - 50 * h * scal);
    second_piece_face.lineTo(second_origin.dx, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + h/2 * scal, second_origin.dy);
    second_piece_face.lineTo(second_origin.dx + h/2 * scal , second_origin.dy - 50 * h * scal);
    second_piece_face.lineTo(second_origin.dx , second_origin.dy - 50 * h * scal);

     canvas.drawPath(main_piece_face, piece_painter);
    canvas.drawPath(second_piece_face, piece_painter);

// print(joinHolePattern.bores.length);

    for (int i = 0; i < door_bore_unit.length; i++)
    {



      double pre_distence = door_bore_unit[i].pre_distence;

      Bore_model unit = door_bore_unit[i].face_bore;
      double correct_x=door_bore_unit[i].correct_x;
      double correct_y=door_bore_unit[i].correct_y;

        canvas.drawCircle(
            Offset(
                pre_distence*scal+second_origin.dx ,
                -22.5*scal+ second_origin.dy - correct_y* scal),
            unit.diameter * scal / 2, bore_painter);

      // }

      }



    for (int i = 0; i < side_bore_unit.length; i++)
    {
      Bore_unit unit = side_bore_unit[i];

      double pre_distence = unit.pre_distence;
      Bore_model face_bore = unit.face_bore;
      bool center=unit.center;

      if(unit.mirror){
        canvas.drawCircle(
            Offset(
               (pre_distence*scal+ main_origin.dx+unit.correct_x*scal ),
                main_origin.dy +face_bore.origin.y_coordinate*scal ),
            face_bore.diameter * scal ,

            bore_painter);

        canvas.drawCircle(
            Offset(
                ((h/2-pre_distence)*scal+ main_origin.dx+unit.correct_x*scal),
                main_origin.dy +face_bore.origin.y_coordinate*scal ),
            face_bore.diameter * scal ,

            bore_painter);


      }
      else{
        canvas.drawCircle(
            Offset(
                center?(main_origin.dx +door_hight/2* scal+unit.correct_x*scal):(pre_distence*scal+ main_origin.dx + face_bore.origin.x_coordinate*scal),
                main_origin.dy +face_bore.origin.y_coordinate*scal ),
            face_bore.diameter * scal ,

            bore_painter);
      }



    }



    draw_text(canvas, "Side", Offset(main_origin.dx, main_origin.dy ), 3, 12);

    // canvas.rotate(1);

    draw_text(canvas, "Door", Offset(second_origin.dx, second_origin.dy), 3, 12);





  }

  draw_text(
      Canvas c, String text, Offset offset, double t_size, int my_text_size) {
    TextSpan ts = TextSpan(
        text: text,
        style: TextStyle(fontSize: t_size * my_text_size, color: Colors.black));
    TextPainter tp = TextPainter(text: ts, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(c, offset);
  }
}
