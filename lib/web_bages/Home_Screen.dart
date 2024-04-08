
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/View_Pages_Controller.dart';
import 'package:auto_cam_web/web_bages/Contact_US_Page.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:auto_cam_web/web_bages/Library_Page.dart';
import 'package:auto_cam_web/web_bages/Main_View_Page.dart';
import 'package:auto_cam_web/web_bages/Sign_Up_In_Page.dart';
import 'package:auto_cam_web/web_bages/Try_Page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Home_Screen> {


  List<bool> hover_texts = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final my_setting_data = GetStorage();

  View_Pages_Controller view_pages_controller=View_Pages_Controller();

  corrent_page(){

    Widget widget=Container();

    if(view_pages_controller.main_bage.value){widget=Main_View_Page();}
    if(view_pages_controller.try_bage.value){widget=Try_Page();}
    if(view_pages_controller.learn_bage.value){widget=Learn_Page();}
    if(view_pages_controller.library_bage.value){widget=Library_Page();}
    if(view_pages_controller.contact_us__bage.value){widget=Contact_US_Page();}
    if(view_pages_controller.sign_up_in_bage.value){widget=Sign_Up_In_Page();}


    return widget;
  }
  bool sign_in=false;


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if(my_setting_data.read("sign_in")!=null){
        sign_in=my_setting_data.read("sign_in");

    }
    else{
        sign_in=false;
    }
    corrent_page();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          body: Container(
            // AssetImage("lib/assets/background.png"),fit: BoxFit.fill),),
            width: w,
            height: h,
            child:

            Row(
              children: [



                /// left side
                view_pages_controller.main_bage.value?  Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(elevation: 12,
                  child: Container(width: w/5,
                      color: Colors.white,
                      child: Column(
                        children: [

                          SizedBox(
                            height: 24,
                          ),
                          /// AutoCam
                          Container(

                            height: 72,width: w/5,
                            child: Center(
                                child: Text("AutoCam",
                                    style: GoogleFonts.abhayaLibre(
                                        textStyle: TextStyle(
                                            fontSize: w / 24,
                                            color: Colors.teal)))),
                          ),

                          SizedBox(
                            height: 96,
                          ),


                          ///What is AutoCam
                          MouseRegion(
                              onHover: (v) {
                                hover_texts[0] = true;
                                setState(() {});
                              },
                              onExit: (v){
                                hover_texts[0] = false;
                                setState(() {});
                              },
                              child: Container(height: 69,
                                child: Text("What is AutoCam ?",
                                    style: GoogleFonts.abhayaLibre(
                                        textStyle: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: hover_texts[0] ? 36 : 32,
                                        ))),
                              )),
                          SizedBox(
                            height: 12,
                          ),


                          ///Design your wardrobe or kitchen cabinet
                          MouseRegion(
                              onHover: (v) {
                                hover_texts[1] = true;
                                setState(() {});
                              },
                              onExit: (v){
                                hover_texts[1] = false;
                                setState(() {});
                              },
                              child: Container(height: 56,
                                child: Text("Design wardrobe or cabinet",
                                    style: GoogleFonts.abhayaLibre(
                                        textStyle: TextStyle(
                                          fontSize: hover_texts[1] ? 24 : 18,fontWeight: FontWeight.bold,
                                        ))),
                              )),
                          SizedBox(
                            height: 8,
                          ),



                          ///Export CutList as excel file
                          MouseRegion(
                              onHover: (v) {
                                hover_texts[2] = true;
                                setState(() {});
                              },
                              onExit: (v){
                                hover_texts[2] = false;
                                setState(() {});
                              },
                              child: Container(height: 56,
                                child: Text("Export CutList as excel file ",
                                    style: GoogleFonts.abhayaLibre(
                                        textStyle: TextStyle(
                                          fontSize: hover_texts[2] ?  24 : 18,fontWeight: FontWeight.bold,
                                        ))),
                              )),
                          SizedBox(
                            height: 8,
                          ),



                          ///Export drilling files for KD work
                          MouseRegion(
                              onHover: (v) {
                                hover_texts[3] = true;
                                setState(() {});
                              },
                              onExit: (v){
                                hover_texts[3] = false;
                                setState(() {});
                              },
                              child: Container(height: 56,
                                child: Text("Export  files for KD work ",
                                    style: GoogleFonts.abhayaLibre(
                                        textStyle: TextStyle(
                                          fontSize: hover_texts[3] ?  24 : 18,fontWeight: FontWeight.bold,
                                        ))),
                              )),
                          SizedBox(
                            height: 8,
                          ),

                          ///Export drilling files for KD work
                          MouseRegion(
                              onHover: (v) {
                                hover_texts[4] = true;
                                setState(() {});
                              },
                              onExit: (v){
                                hover_texts[4] = false;
                                setState(() {});
                              },
                              child: Container(height: 56,
                                child: Text("Export Shop Drawing ",
                                    style: GoogleFonts.abhayaLibre(
                                        textStyle: TextStyle(
                                          fontSize: hover_texts[4] ?  24 : 18,fontWeight: FontWeight.bold,
                                        ))),
                              )),
                          SizedBox(
                            height: 8,
                          ),


                        ],
                      ),
                    ),
                ),
              ):SizedBox(),


                ///main screen
                Container(    width:view_pages_controller.main_bage.value?(w/5)*4-56:w,
                  // color: Colors.blue[100],
                  child: Column(
                    children: [
                      SizedBox(height: view_pages_controller.main_bage.value?18:0,),


                      /// titles : try , learn , library , contact us , log in or up
                      Card(elevation: 12,
                        child: Container(height: 32,color: Colors.white,
                          child:
                          Row(
                            children: [

                              view_pages_controller. main_bage.value?
                              SizedBox(width: 50,):
                          Container(

                          // color: Colors.teal[100],

                          height: 32,width: w/5+50,
                          child: Center(
                              child: Text("AutoCam",
                                  style: GoogleFonts.abhayaLibre(
                                      textStyle: TextStyle(
                                          fontSize:  32,
                                          color: Colors.teal)))),
                        ),

                             /// Home
                              MouseRegion(
                                onHover: (v){
                                  hover_texts[9]=true;setState(() {

                                  });
                                },
                                onExit: (v){
                                  hover_texts[9]=false;
                                  setState(() {

                                  });
                                },
                                child: InkWell(onTap: (){

                                  view_pages_controller.main_bage.value=true;
                                  view_pages_controller.try_bage.value=false;
                                  view_pages_controller.learn_bage.value=false;
                                  view_pages_controller.library_bage.value=false;
                                  view_pages_controller.contact_us__bage.value=false;
                                  view_pages_controller.sign_up_in_bage.value=false;
                                  setState(() {

                                  });

                                },
                                  child: Container(height: 32,width:hover_texts[9]? 112:80,
                                    //
                                    child: Center(child: Text("Home" ,
                                      style: GoogleFonts.aBeeZee(fontSize: hover_texts[9]? 24:16),),),
                                  ),
                                ),
                              ),SizedBox(width: hover_texts[9]? 44:76,),

                              ///try
                              MouseRegion(
                                onHover: (v){
                                  hover_texts[5]=true;setState(() {

                                  });
                                },
                                onExit: (v){
                                  hover_texts[5]=false;
                                  setState(() {

                                  });
                                },
                                child: InkWell(onTap: (){

                                 view_pages_controller.main_bage.value=false;
                                 view_pages_controller.try_bage.value=true;
                                 view_pages_controller.learn_bage.value=false;
                                 view_pages_controller.library_bage.value=false;
                                 view_pages_controller.contact_us__bage.value=false;
                                 view_pages_controller.sign_up_in_bage.value=false;
                                  setState(() {

                                  });

                                },
                                  child: Container(height: 32,width:hover_texts[5]? 112:80,
                                   child: Center(child: Text("try" ,
                                      style: GoogleFonts.aBeeZee(fontSize: hover_texts[5]? 24:16),),),
                                  ),
                                ),
                              ),SizedBox(width: hover_texts[5]? 44:76,),

                              ///learn
                              MouseRegion(
                                onHover: (v){
                                  hover_texts[6]=true;setState(() {

                                  });
                                },
                                onExit: (v){
                                  hover_texts[6]=false;
                                  setState(() {

                                  });
                                },
                                child: InkWell(onTap: (){
                                  view_pages_controller.main_bage.value=false;
                                  view_pages_controller.try_bage.value=false;
                                  view_pages_controller.learn_bage.value=true;
                                  view_pages_controller.library_bage.value=false;
                                  view_pages_controller.contact_us__bage.value=false;
                                  view_pages_controller.sign_up_in_bage.value=false;
                                  setState(() {

                                  });

                                },
                                  child: Container(height: 42,width:hover_texts[6]? 112:80,
                                     child: Center(child: Text("learn" ,
                                      style: GoogleFonts.aBeeZee(fontSize: hover_texts[6]? 24:16),),),
                                  ),
                                ),
                              ),SizedBox(width: hover_texts[6]? 44:76,),

                              ///library
                              MouseRegion(
                                onHover: (v){
                                  hover_texts[7]=true;setState(() {

                                  });
                                },
                                onExit: (v){
                                  hover_texts[7]=false;
                                  setState(() {

                                  });
                                },
                                child: InkWell(onTap: (){
                                 view_pages_controller.main_bage.value=false;
                                 view_pages_controller.try_bage.value=false;
                                 view_pages_controller.learn_bage.value=false;
                                 view_pages_controller.library_bage.value=true;
                                 view_pages_controller.contact_us__bage.value=false;
                                 view_pages_controller.sign_up_in_bage.value=false;
                                  setState(() {

                                  });

                                },
                                  child: Container(height:42,width:hover_texts[7]? 112:80,
                                  child: Center(child: Text("library" , style:
                                    GoogleFonts.aBeeZee(fontSize: hover_texts[7]? 24:16),),),
                                  ),
                                ),
                              ),SizedBox(width: hover_texts[7]? 44:76,),

                              ///contact us
                              MouseRegion(
                                onHover: (v){
                                  hover_texts[8]=true;setState(() {

                                  });
                                },
                                onExit: (v){
                                  hover_texts[8]=false;
                                  setState(() {

                                  });
                                },
                                child: InkWell(onTap: (){

                                  view_pages_controller.main_bage.value=false;
                                  view_pages_controller.try_bage.value=false;
                                  view_pages_controller.learn_bage.value=false;
                                  view_pages_controller.library_bage.value=false;
                                  view_pages_controller.contact_us__bage.value=true;
                                  view_pages_controller.sign_up_in_bage.value=false;
                                  setState(() {

                                  });
                                },
                                  child: Container(height: 42,width:hover_texts[8]? 132:100,
                                  child: Center(child: Text("Contact Us" , style:
                                    GoogleFonts.aBeeZee(fontSize: hover_texts[8]? 24:16),),),
                                  ),
                                ),
                              ),SizedBox(width: hover_texts[8]? 54:86,),

                              Expanded(child: SizedBox()),


                              /// customer name or log in or up
                              Container(
                                height: 30,
                                width: 100,
                                child: InkWell(
                                    onTap: () {

                                      view_pages_controller.main_bage.value=false;
                                      view_pages_controller.try_bage.value=false;
                                      view_pages_controller.learn_bage.value=false;
                                      view_pages_controller.library_bage.value=false;
                                      view_pages_controller.contact_us__bage.value=false;
                                      view_pages_controller.sign_up_in_bage.value=true;
                                      setState(() {

                                      });

                                      },
                                    child: Center(child: Text(!sign_in?"LOG IN":"LOG OUT"))),
                              ),

                              SizedBox(width: 24,)
                            ],
                          ),


                        ),
                      ),

Container(width: w,height: h-69,
  color: Colors.blue[100],

  child: corrent_page(),
)
                    ],
                  ),
                ),




              ],
            ),



          )),
    );
  }
}
