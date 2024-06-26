
 import 'package:auto_cam_web/online_autoam/Model/Main_Models/Box_Pieces_Arrang.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Box_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Cut_List_Item.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Fastener.dart';
 import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Piece_model.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Point_model.dart';
 import 'package:get/get.dart';

class Box_Repository extends GetxController {
  double top_base_piece_width = 100;

  double pack_panel_thickness = 0;
  double pack_panel_grove_depth = 9;
  double pack_panel_distence = 0;


  Rx<Box_model> box_model = Box_model('box_name', "wall_cabinet", 400, 600, 500,
          18, 'MDF', 5, 9, 18, 100, true, Point_model(0, 0, 0),0)
      .obs;

 List<Box_model> box_series=[];

 int box_indicator =-1;

 add_new_box_to_series(){

   Box_model nb =copy_of_box_model(box_model.value);

   if (box_indicator==box_series.length-1 || box_indicator==-1) {
     box_series.add(nb);

     // print("here");

   }
   else {


       List<Box_model> nbs=[];
       for(int i=0;i<box_indicator;i++){
         nbs.add(box_series[i]);
       }
       box_series.clear();
       box_series=nbs;
       box_series.add(nb);

   }

   // print("indecator ${box_indicator}");
   // print("box_series ${box_series.length}");
   // print("==================");

   box_indicator++;


 }


   undo(){

   if (box_indicator>0) {
     box_indicator--;
     add_box_to_repo(copy_of_box_model(box_series[box_indicator]));
   }

   // print("indecator ${box_indicator}");
   // print("box_series ${box_series.length}");
   // print("==================");

 }

  redo(){

    if (box_indicator < box_series.length-1) {
      box_indicator++;
      add_box_to_repo(copy_of_box_model(box_series[box_indicator]));

    }

    // print("indecator ${box_indicator}");
    // print("box_series ${box_series.length}");
    // print("==================");


  }


  Box_model copy_of_box_model(Box_model ob){


   Box_model nb =Box_model(
       ob.box_name,
       ob.box_type,
       ob.box_width,
       ob.box_height,
       ob.box_depth,
       ob.init_material_thickness,
       ob.init_material_name,
       ob.back_panel_thickness,
       ob.grove_value,
       ob.bac_panel_distence,
       ob.top_base_piece_width,
       ob.is_back_panel,
       ob.box_origin,
       ob.piece_id
   );

   nb.box_pieces=ob.box_pieces;
   nb.fasteners= ob.fasteners;

   return nb;
  }


  String back_panel_type = "full_cover";










  /// //////////

  List<Fastener_Point> fasteners_points=[];


  String corrent_fastener="";

  List<String> fasteners_namae=["confirm_screw","mini_fix"];


  Fastener_Templet shelf_templet= Fastener_Templet("shelf_templet", 0, 5,10,0,0,0,0,0,0);

  Fastener_Templet confirm_screw= Fastener_Templet("confirm_screw", 0, 6,17,10,1,5,35,0,0);

  Fastener_Templet mini_fix= Fastener_Templet(
    "mini_fix",
    24,
    10,11,0,0,8,24,14,14
  );





  Fastener_Templet dowel_templet   = Fastener_Templet(
      "dowel",
    0,8,10,0,0,8,21,0,0
  );



  Map<String, List<JoinHolePattern>> join_patterns =
  {
    "Box_Fitting_DRILL": [],
    "Flexible_Shelves": [],
    "Drawer_Face": [],
    "Drawer_Rail_Box" : [],
    "Drawer_Rail_Side": [],
    "Door_Hinges": [],
    "side_Hinges": [],
    "Groove": [],
  };

  List brands =[].obs();



  List<Cut_List_Item> cut_list_items = [];





  bool box_have_been_saved = false;
  String box_file_path = '';






  add_box_to_repo(Box_model b) {

    box_model.value.box_pieces=b.box_pieces;
    box_model.value = b;
  }



  Box_Pieces_Arrang arrange_box(Box_model b){

    Box_Pieces_Arrang box_pieces_arrang =Box_Pieces_Arrang(box_model.value);

    return box_pieces_arrang;
  }

  enable_Piece(Piece_model p ,bool enable){

    int index=  box_model.value.box_pieces.indexWhere((element) => element.piece_id==p.piece_id);

    box_model.value.box_pieces[index].piece_inable=enable;

Box_model nb=box_model.value;

add_box_to_repo(nb);

  }







}
