
import 'package:auto_cam_web/online_autoam/Model/Main_Models/User_modle.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:firebase_database/firebase_database.dart';


class Firebase_caontroller extends GetxController{

  final my_setting_data = GetStorage();
  bool sign_in = false;
  String user="";
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
      print("exist");
      Get.to(Home_Screen());
    }else if(!names.contains(user.name)){
      print("new");
      Get.to(Home_Screen());

    }


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




}