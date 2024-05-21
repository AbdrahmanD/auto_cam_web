
import 'dart:convert';

 import 'package:auto_cam_web/online_autoam/Controller/Repositories_Controllers/Box_Repository.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/User_modle.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
 import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:firebase_database/firebase_database.dart';


class Firebase_caontroller extends GetxController{


// Draw_Controller draw_controller=Get.find();
  Box_Repository box_repository = Get.find();


final my_setting_data = GetStorage();
  bool sign_in = false;

  List<String> names =[];

  Firebase_caontroller(){
    names=feacth_all_users();
  }

  FirebaseDatabase database = FirebaseDatabase.instance;



  user_sign_in_up(User_modle user){

    if(
    names.length!=0 &&
    names.contains(user.email)
    ){
      featch_user_patterns();
      Get.to(Home_Screen());
    }else if(
         names.length!=0  ||
        !names.contains(user.email)
    ){

      add_new_user(user);
      Get.to(Home_Screen());

    }

    my_setting_data.write("user_name", user.email);
    my_setting_data.write("sign_in",true);
    featch_user_patterns();
  }


  sign_out(){
    // my_setting_data.write("user_name","");
    // sign_in=false;
    // Get.off(Home_Screen());

  }

  add_new_user(User_modle user) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user.email}");

    await ref.set({
      // "name": user.email,
      // // "password": user.password,
      "email": user.email,
      "active_account": user.active_account,
      "counter": user.counter,
      "plan": user.plan,
      "patterns": user.patterns,

    });
  }


  List<String> feacth_all_users(){

    List<String> users_names=[];
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");

    ref.get().then((DataSnapshot snapshot) {
          Map users = snapshot.value as Map;
          users.forEach((key, value) {
            users_names.add(value['email']);
          });

    });
    return users_names;

  }

  featch_user_patterns()async{

    box_repository.join_patterns["Box_Fitting_DRILL"]=[];
    box_repository.join_patterns["Flexible_Shelves"]=[];





    ///Box_Fitting_DRILL
    DatabaseReference ref = FirebaseDatabase.instance.ref("users").
    child("${my_setting_data.read("user_name")}").
    child("patterns").child("Box_Fitting_DRILL");

    await ref.get().then((value){
      Map<String, dynamic> data = jsonDecode(jsonEncode(value.value));
      final map = Map<String, dynamic>.from(data);

      for(int i=0;i<map.length;i++){
        JoinHolePattern joinHolePattern=JoinHolePattern.fromJson(map.values.toList()[i]);
        box_repository.join_patterns["Box_Fitting_DRILL"]!.add(joinHolePattern);
      }});


    ///Flexible_Shelves
    DatabaseReference ref_2 = FirebaseDatabase.instance.ref("users").
    child("${my_setting_data.read("user_name")}").
    child("patterns").child("Flexible_Shelves");

    await ref_2.get().then((value){
      Map<String, dynamic> data = jsonDecode(jsonEncode(value.value));
      final map = Map<String, dynamic>.from(data);

      for(int i=0;i<map.length;i++){
        JoinHolePattern joinHolePattern=JoinHolePattern.fromJson(map.values.toList()[i]);
        box_repository.join_patterns["Flexible_Shelves"]!.add(joinHolePattern);
      }});




    // print("Box_Fitting_DRILL :${box_repository.join_patterns["Box_Fitting_DRILL"]!.length}");
    // print("Flexible_Shelves :${box_repository.join_patterns["Flexible_Shelves"]!.length}");

  }

  save_pattern_to_cloud(JoinHolePattern pattern , String category) async{

    if(my_setting_data.read("user_name")!=null) {

      DatabaseReference ref = FirebaseDatabase.instance.ref("users").
      child("${my_setting_data.read("user_name")}").
      child("patterns").
      child(category).child(pattern.name);

      await ref.set(pattern.toJson());
    }

  }


  delete_Pattern_from_cloud(JoinHolePattern pattern , String category) async{

    if(my_setting_data.read("user_name")!=null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users").
      child("${my_setting_data.read("user_name")}").
      child("patterns").
      child(category).child(pattern.name);

      await ref.remove();
    }

  }




}