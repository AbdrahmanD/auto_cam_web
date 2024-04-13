

import 'package:auto_cam_web/online_autoam/Model/Main_Models/JoinHolePattern.dart';

class User_modle{

  late String name;
  late String password;
  late String email;
  // late bool   sign_in;
  late bool   active_account;
  late int    counter;
  late String plan;
  List<JoinHolePattern> patterns=[];

  User_modle(this.name, this.password, this.email,  this.active_account,
      this.counter, this.plan)

  {
  }

  User_modle.fromjson(Map<String,dynamic> map){
    this.name=map["name"];
    this.name=map["password"];
    this.name=map["email"];
    // this.name=map["sign_in"];
    this.name=map["active_account"];
    this.name=map["counter"];
    this.name=map["plan"];
    map["patterns"].forEach((pattern){
      patterns.add(JoinHolePattern.fromJson(pattern));
    });

  }

  Map<String,dynamic>  tojson(){

    Map<String,dynamic> map={};

    map["name"]=this.name  ;
    map["password"]=this.password  ;
    map["email"]=this.email  ;
    // map["sign_in"]=this.sign_in  ;
    map["active_account"]=this.active_account  ;
    map["counter"]=this.counter  ;
    map["plan"]=this.plan  ;
    map["patterns"]=this.patterns.map((element) {element.toJson();}).toList()  ;


    return map;
  }

}