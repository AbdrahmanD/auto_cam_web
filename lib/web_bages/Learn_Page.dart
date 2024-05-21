 import 'package:auto_cam_web/online_autoam/View/Cabinet_Editor.dart';
import 'package:auto_cam_web/web_bages/Buy_Page.dart';
import 'package:auto_cam_web/web_bages/Contact_US_Page.dart';
import 'package:auto_cam_web/web_bages/Home_Screen.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

 import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class Learn_Page extends StatefulWidget {
  const Learn_Page({Key? key}) : super(key: key);

  @override
  State<Learn_Page> createState() => _Learn_PageState();
}

class _Learn_PageState extends State<Learn_Page> {





  bool sign_in = false;
  String user="";
  final my_setting_data = GetStorage();



  /// video
  Map<String,String> videos_links= {

    "intro" :        "<iframe width='951' height='594' src='https://www.youtube.com/embed/-AszPIWm8E4' title='interface' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "create box" :   "<iframe width='951' height='594' src='https://www.youtube.com/embed/7Ik-JNxaBwU' title='add and save box' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "box types"  :   "<iframe width='951' height='594' src='https://www.youtube.com/embed/MhgsSBj38QA' title='box types' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add shelf" :    "<iframe width='951' height='594' src='https://www.youtube.com/embed/ChBXoCAER_4' title='add shelf'        frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add partition" :"<iframe width='951' height='594' src='https://www.youtube.com/embed/Ve-QaF_f2qQ' title='add partition'    frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add Door" :     "<iframe width='951' height='594' src='https://www.youtube.com/embed/T6OekQoyXaE' title='add door'         frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add drawer" :   "<iframe width='951' height='594' src='https://www.youtube.com/embed/7zUh5vkXSd4' title='add drawer'       frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add support" :  "<iframe width='951' height='594' src='https://www.youtube.com/embed/bKpKKIbnr3I' title='add support'      frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add back panel":"<iframe width='951' height='594' src='https://www.youtube.com/embed/H3xdoZ0DT_g' title='add backPanel' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",
    "add inner box" :"<iframe width='951' height='594' src='https://www.youtube.com/embed/pctByCkyIh0' title='add box'          frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' referrerpolicy='strict-origin-when-cross-origin' allowfullscreen></iframe>",

   };





    int index=0;

  ScrollController scrollController = ScrollController();



   ///

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (my_setting_data.read("sign_in") != null) {
      sign_in = my_setting_data.read("sign_in");
    } else {
      sign_in = false;
    }

    if (my_setting_data.read("user") != null) {
      user = my_setting_data.read("user");
    } else {
      user = "";
    }



    return Directionality(textDirection: TextDirection.ltr, child: Scaffold(
      backgroundColor: Color.fromRGBO(26, 43, 52, 1),

      body:

      Container(

        width: w, height: h,
        child: Column(
          children: [
            Container(
              height: h/4,
              child:

              /// app par
              Row(
                children: [


                  Container(
                    width: (w / 3),
                    // height: h - 200,
                    child:
                    Center(
                        child: Image.asset(
                          "lib/assets/images/app_fotos/logo.png",
                        )),
                  ),
                  ///home page
                  Container(
                    // color: Colors.blue,
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Home_Screen());
                          },
                          child: Text("Home",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),

                  /// try page
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Cabinet_Editor(true));
                          },
                          child: Text("Try",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),

                  /// Learn
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Learn_Page());
                          },
                          child: Text("Learn",
                            style: GoogleFonts.aBeeZee(
                              fontSize: w/80, color: Color.fromRGBO(0, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    color: Colors.white,
                                    offset: Offset(0, -5))
                              ],
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 4,
                              // decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                        )),
                  ),


                  /// contact us
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Contact_US_Page(false));

                          },
                          child: Text("contact",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)
                          ),
                        )),
                  ),


                  ///buy
                  Container(
                    width: w / 16,
                    child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(Buy_Page());
                          },
                          child: Text("Buy",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: w/96, color: Colors.white)),
                        )),
                  ),




                  SizedBox(
                    width: (w / 9),
                  ),

                  /// Sign in / out
                  // Container(
                  //   width: w / 18,
                  //   child: Center(
                  //       child: InkWell(
                  //         onTap: () {
                  //
                  //           !sign_in?
                  //           signInWithGoogle()
                  //               :
                  //           signOut();
                  //
                  //
                  //         },
                  //         child: Text(sign_in?"Sign out":"Sign in",
                  //             style: GoogleFonts.aBeeZee(
                  //                 fontSize: w/96, color: Colors.white)
                  //         ),
                  //       )),
                  // ),


                  Container(width: w/6,
                    child: Text("$user",
                        style: GoogleFonts.aBeeZee(
                            fontSize: w/96, color: Colors.white)
                    ),)
                ],
              ),
            ),

            /// main content
            Container(              height: (h/4)*3,

              child: Row(
                children: [

                  ///Sized box
                  Container(width: 56,
                    // height: h - 200,
                  ),

                  /// main title
                  Container(width: w/4,
                    height: h - 200,
                    child:
                    ListView.builder(
                        itemCount: videos_links.length,
                        itemBuilder: (context,i){
                          return Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 24,),

                              Row(
                                children: [
                                  Container(width: 32,height: 32,child: Text("$i  - "
                                    ,style: GoogleFonts.arsenal(fontSize: 18,fontWeight: FontWeight.w100,color: Colors.white),

                                  )),
                                  InkWell(
                                    onTap: (){
                                      index=i;
                                      double video_position=double.parse("$i")*550;
                                      scrollController.animateTo(video_position,
                                          duration: const Duration(milliseconds: 100),
                                          curve: Curves.bounceIn);

                                      setState(() {});

                                    },
                                    child: Container(width: w/4-76,child: Center(child: Text(
                                      videos_links.keys.toList()[i]
                                      ,style: GoogleFonts.arsenal(fontSize: 18,fontWeight: FontWeight.w100,color: Colors.white),

                                    ))),
                                  ),


                                  SizedBox(width: 12,),


                                ],
                              ),


                              SizedBox(height: 12,),
                              /// divider
                              Container(

                                height: 0.3,color: Colors.white,
                              ),
                            ],
                          );
                        })

                  ),


                  ///video player
                  Container(
                    width: (w/4)*3-80,
                    height: h-200,

                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child:
              ListView.builder(


                controller: scrollController,
                  itemCount: videos_links.length,
                  itemBuilder: (context,i){
                return

                  Container(width: 500,height: 550,
                  child: Column(
                    children: [

                      SizedBox(height: 15,),
                      Text(videos_links.keys.toList()[i],style: TextStyle(fontSize: 24,color: Colors.white)),
                      // HtmlWidget(videos_links[0]),
                      Container(width:w/2,height: 481,child: Center(child:
                      HtmlWidget(videos_links.values.toList()[i])
                      // Text("$i",style: TextStyle(fontSize: 190),)

                      ),),
                      SizedBox(height: 18,),
                      Container(height: 2,color: Colors.grey,width: 300,)
                    ],
                  ),
                );

              })
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),

    ));



  }
}


