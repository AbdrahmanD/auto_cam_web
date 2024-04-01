
import 'package:auto_cam_web/web_bages/Contact_US_Page.dart';
import 'package:auto_cam_web/web_bages/Learn_Page.dart';
import 'package:auto_cam_web/web_bages/Library_Page.dart';
import 'package:auto_cam_web/web_bages/Main_View_Page.dart';
import 'package:auto_cam_web/web_bages/Sign_Up_In_Page.dart';
import 'package:auto_cam_web/web_bages/Try_Page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({Key? key}) : super(key: key);

  @override
  State<Main_Screen> createState() => _Main_ScreenState();
}

class _Main_ScreenState extends State<Main_Screen> {


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



  bool main_bage=true;
  bool try_bage=false;
  bool learn_bage=false;
  bool library_bage=false;
  bool contact_us__bage=false;
  bool sign_up_in_bage=false;

 Widget corrent_page(){
    Widget widget=Container();

    if(main_bage){widget=Main_View_Page();}
    if(try_bage){widget=Try_Page();}
    if(learn_bage){widget=Learn_Page();}
    if(library_bage){widget=Library_Page();}
    if(contact_us__bage){widget=Contact_US_Page();}
    if(sign_up_in_bage){widget=Sign_Up_In_Page();}


    return widget;
  }


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
              main_bage?  Padding(
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
                Container(    width:main_bage?(w/5)*4-56:w,
                  // color: Colors.blue[100],
                  child: Column(
                    children: [
                      SizedBox(height: main_bage?18:0,),


                      /// titles : try , learn , library , contact us , log in or up
                      Card(elevation: 12,
                        child: Container(height: 32,color: Colors.white,
                          child:
                          Row(
                            children: [

                              main_bage?
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

                                  main_bage=true;
                                  try_bage=false;
                                  learn_bage=false;
                                  library_bage=false;
                                  contact_us__bage=false;
                                  sign_up_in_bage=false;
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

                                  main_bage=false;
                                  try_bage=true;
                                  learn_bage=false;
                                  library_bage=false;
                                  contact_us__bage=false;
                                  sign_up_in_bage=false;
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
                                  main_bage=false;
                                  try_bage=false;
                                  learn_bage=true;
                                  library_bage=false;
                                  contact_us__bage=false;
                                  sign_up_in_bage=false;
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
                                  main_bage=false;
                                  try_bage=false;
                                  learn_bage=false;
                                  library_bage=true;
                                  contact_us__bage=false;
                                  sign_up_in_bage=false;
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

                                  main_bage=false;
                                  try_bage=false;
                                  learn_bage=false;
                                  library_bage=false;
                                  contact_us__bage=true;
                                  sign_up_in_bage=false;
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

                                      main_bage=false;
                                      try_bage=false;
                                      learn_bage=false;
                                      library_bage=false;
                                      contact_us__bage=false;
                                      sign_up_in_bage=true;
                                      setState(() {

                                      });

                                      },
                                    child: Center(child: Text("LOG IN"))),
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
