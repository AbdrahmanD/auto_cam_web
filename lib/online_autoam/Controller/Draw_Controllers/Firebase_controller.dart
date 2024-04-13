
import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/User_modle.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:firebase_database/firebase_database.dart';


class Firebase_caontroller extends GetxController{

  final my_setting_data = GetStorage();
  bool sign_in = false;

  List<String> names =[];

  bool loading_user=true;

  Firebase_caontroller(){
    names=feacth_all_users();
  }

  FirebaseDatabase database = FirebaseDatabase.instance;

  final rtdb = FirebaseDatabase.instanceFor(app: Firebase.app(),
      databaseURL: 'https://autocam-5f9b9-default-rtdb.firebaseio.com/');


  user_sign_in_up(User_modle user){

    if(names.contains(user.name)){
      Get.to(Home_Screen());
    }else if(!names.contains(user.name)){

      add_new_user(user);
      Get.to(Home_Screen());

    }

    my_setting_data.write("user_name", user.name);
    my_setting_data.write("sign_in",true);

  }


  sign_out(){
    // my_setting_data.write("user_name","");
    // sign_in=false;
    // Get.off(Home_Screen());

  }
  add_new_user(User_modle user) async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user.name}");

    await ref.set({
      "name": user.name,
      "password": user.password,
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
            users_names.add(value['name']);
          });

          loading_user=false;
    });
    return users_names;

  }




  featch_user_patterns(User_modle user){




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




}