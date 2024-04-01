
import 'package:auto_cam_web/online_autoam/Controller/Draw_Controllers/Draw_Controller.dart';
import 'package:auto_cam_web/online_autoam/Model/Main_Models/Drawers_group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Add_Drawer_Dialog extends StatefulWidget {
  @override
  State<Add_Drawer_Dialog> createState() => _Add_Drawer_DialogState();
}

class _Add_Drawer_DialogState extends State<Add_Drawer_Dialog> {
  TextEditingController drawer_box_material_thickness = TextEditingController();
  TextEditingController drawer_face_material_thickness =
      TextEditingController();
  TextEditingController drawer_base_material_thickness = TextEditingController();
  TextEditingController under_base_thickness = TextEditingController();
  TextEditingController drawer_face_material_name = TextEditingController();

  TextEditingController drawer_face_up_distace_controller   = TextEditingController();
  TextEditingController drawer_face_down_distace_controller = TextEditingController();
  TextEditingController drawer_slide_height_controller = TextEditingController();

  TextEditingController drawer_box_depth = TextEditingController();

  TextEditingController drawer_quantity = TextEditingController();
  TextEditingController side_gap_controller= TextEditingController();

  Draw_Controller draw_controller = Get.find();

  String drawer_type = 'normal_side';

  ///

  TextEditingController All_base_gape_controller = TextEditingController();
  TextEditingController All_top_gape_controller = TextEditingController();
  TextEditingController each_top_gape_controller = TextEditingController();
  TextEditingController left_gape_controller     = TextEditingController();
  TextEditingController right_gape_controller    = TextEditingController();

  TextEditingController round_gape_controller    = TextEditingController();
  TextEditingController front_gape_controller    = TextEditingController();

  bool inner_drawer = false;
  bool double_face = true;

  inner_drawer_changed(){
    if(!inner_drawer){
      inner_drawer=true;
      round_gape_controller.text="2";
      front_gape_controller.text="2";
    }else{
      inner_drawer=false;
      All_base_gape_controller.text = '4';
      All_top_gape_controller.text='4';
      each_top_gape_controller.text = '2';
      left_gape_controller.text = '1';
      right_gape_controller.text = '1';
    }
  }

  ///
  ///
  @override
  void initState() {
    super.initState();

    drawer_box_material_thickness.text =
        '${draw_controller.box_repository.box_model.value.init_material_thickness}';
    drawer_face_up_distace_controller  .text = '${30}';
    drawer_face_down_distace_controller  .text = '${20}';
    drawer_slide_height_controller  .text = '${20}';
    drawer_box_depth.text = '${400}';
    drawer_quantity.text = '${1}';
    drawer_face_material_thickness.text = '18';
    drawer_face_material_name.text = 'MDF';
    drawer_base_material_thickness.text = '5';
    All_base_gape_controller.text = '4';
    All_top_gape_controller.text='4';
    each_top_gape_controller.text = '2';
    left_gape_controller.text = '1';
    right_gape_controller.text = '1';
    side_gap_controller.text = '12';
    under_base_thickness.text = '20';

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 550,
      child: Row(
        children: [
          SizedBox(width: 16,),
          Column(
            children: [
              Container(width: 200,height: 50,
                child: Row(
                  children: [
                    Text('Type'),
      SizedBox(width: 12,),
      DropdownButton<String>(
        value: drawer_type,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            drawer_type = value!;
            print(drawer_type);
          });
        },
        items: const[
          DropdownMenuItem(child: Text('normal_side'),value:'normal_side' ),
          DropdownMenuItem(child: Text('concealed_hafle_1'),value:'concealed_hafle_1' ),
        ]
      )
                  ],
                ),
              ),
              SizedBox(height: 12,),

              /// inner drawer ?
              Container(width: 200,height: 50,
                child: Row(
                  children: [
                    Text('inner drawer'),
                    SizedBox(width: 12,),
                    Checkbox(value: inner_drawer, onChanged: (v){
                      inner_drawer_changed();
                      setState(() {

                      });
                    }),
                  ],
                ),
              ),
              SizedBox(height: 12,),

              Container(
                child: inner_drawer?
                Column(
                  children: [

                    ///round Gap

                    Row(
                      children: [
                        Text('round Gap'),
                        SizedBox(
                          width: 24,
                        ),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: round_gape_controller,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),


                    /// front gap
                    Row(
                      children: [
                        Text('front Gap'),
                        SizedBox(
                          width: 24,
                        ),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: front_gape_controller,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),

                  ],
                ):
                /// overlap values
                Column(
                  children: [
                    Text('All Sides Gap '),
                    SizedBox(
                      height: 16,
                    ),
                    ///All_base_gape_controller

                    Row(
                      children: [
                        Text('All_base    '),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: All_base_gape_controller,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),


                    ///All_Top_gape_controller

                    Row(
                      children: [
                        Text('All Top    '),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: All_top_gape_controller,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),


                    /// each_top_gape_controller
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text('each_top   ' ),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: each_top_gape_controller,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),

                    ///left_gape_controller
                    Row(
                      children: [
                        Text('left_gape   '),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: left_gape_controller,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9 -]')),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),

                    ///right_gape_controller
                    Row(
                      children: [
                        Text('right_gape '),
                        Container(
                          height: 32,
                          width: 60,
                          child: TextFormField(
                            controller: right_gape_controller,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9 -]')),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            validator: (d) {
                              if (d!.isEmpty) {
                                return 'add value please';
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  if(inner_drawer){

                    All_base_gape_controller.text='${draw_controller.box_repository.box_model.value.init_material_thickness+double.parse(round_gape_controller.text.toString())}';
                    All_top_gape_controller.text='${draw_controller.box_repository.box_model.value.init_material_thickness+double.parse(round_gape_controller.text.toString())}';
                    each_top_gape_controller.text='${double.parse(round_gape_controller.text.toString())}';
                    left_gape_controller    .text='${draw_controller.box_repository.box_model.value.init_material_thickness+double.parse(round_gape_controller.text.toString())}';
                    right_gape_controller   .text='${draw_controller.box_repository.box_model.value.init_material_thickness+double.parse(round_gape_controller.text.toString())}';
                    round_gape_controller   .text='${draw_controller.box_repository.box_model.value.init_material_thickness+double.parse(round_gape_controller.text.toString())}';

                  }



                  double double_drawer_box_material_thickness = double.parse("${double.parse(
                      drawer_box_material_thickness.text.toString()).
                  toInt
                  (
                  )
                }");
                  double double_drawer_face_material_thickness = double.parse(
                      drawer_face_material_thickness.text.toString());
                  double double_All_base_gape_controller =
                  double.parse(All_base_gape_controller.text.toString());
                  double double_All_Top_gape_controller =
                  double.parse(All_top_gape_controller.text.toString());
                  double double_drawer_base_material_thickness = double.parse(drawer_base_material_thickness.text.toString());
                  double double_under_base_thickness = double.parse(under_base_thickness.text.toString());
                  double double_each_top_gape_controller =
                  double.parse(each_top_gape_controller.text.toString());
                  double double_left_gape_controller =
                  double.parse(left_gape_controller.text.toString());
                  double double_right_gape_controller =
                  double.parse(right_gape_controller.text.toString());

                  double double_drawer_face_up_distace  =   double.parse(drawer_face_up_distace_controller.text.toString());
                  double double_drawer_face_down_distace  = double.parse(drawer_face_down_distace_controller.text.toString());
                  double double_drawer_slide_height   = double.parse(drawer_slide_height_controller.text.toString());

                  double double_drawer_box_depth =
                  double.parse(drawer_box_depth.text.toString());
                  int double_drawer_quantity =
                  double.parse(drawer_quantity.text.toString()).toInt();

                  double double_slide_side_gap = double.parse(side_gap_controller.text.toString())*2;

                  double front_gape = inner_drawer?(double.parse(front_gape_controller.text.toString())):0;

                  Drawers_group_model my_drawer = Drawers_group_model(
                      1,
                      draw_controller.hover_id,
                      drawer_type,
                      inner_drawer,
                      double_drawer_quantity,
                      double_All_base_gape_controller,
                      double_All_Top_gape_controller,
                      double_each_top_gape_controller,
                      double_left_gape_controller,
                      double_right_gape_controller,
                      double_drawer_face_material_thickness,
                      drawer_face_material_name.text.toString(),
                      double_drawer_box_material_thickness,
                      double_drawer_base_material_thickness,
                      double_under_base_thickness,
                      double_drawer_box_depth,

                      double_drawer_face_up_distace  ,
                      double_drawer_face_down_distace,

                      double_slide_side_gap,
                      double_drawer_slide_height,
                      double_face,
                      front_gape
                  );

                  my_drawer.add_drawer();
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.teal),
                  width: 140,
                  height: 40,
                  child: Center(
                      child: Text(
                        'ok',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ),
            ],
          ),

          //divider
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: 2,
              color: Colors.grey,
            ),
          ),

          Container(
            width: 282,
            height: 600,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Material thickness     '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child:
                      TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_box_material_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///face material thickness
                Row(
                  children: [
                    Text('face thickness           '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_face_material_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///face material name
                Row(
                  children: [
                    Text('Face Material name   '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        controller: drawer_face_material_name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///base panel thickness
                Row(
                  children: [
                    Text('base panel thickness'),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_base_material_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),


                Divider(height: 4,color: Colors.black,),
                SizedBox(
                  height: 6,
                ),

                /// under base  thickness
                Row(
                  children: [
                    Text('under base thickness'),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: under_base_thickness,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ), SizedBox(
                  height: 6,
                ),

                ///drawer_slide_height
                Row(
                  children: [
                    Text('slide height from down'),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_slide_height_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ), SizedBox(
                  height: 6,
                ),

                SizedBox(
                  height: 6,
                ),



                ///ddrawer_face_up_distace_controller
                ///
                Row(
                  children: [
                    Text('UP                      ',style: TextStyle(fontSize: 18),),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_face_up_distace_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                ///drawer_face_down_distace_controller
                Row(
                  children: [
                    Text('DOWN                ',style: TextStyle(fontSize: 18),),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_face_down_distace_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),



                ///  double face ?
                Container(width: 200,height: 50,
                  child: Row(
                    children: [
                      Text("double face"),
                      SizedBox(width: 12,),
                      Checkbox(value: double_face, onChanged: (v){

double_face=!double_face;                        setState(() {

                        });
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 12,),


                Divider(height: 4,color: Colors.black,),
                SizedBox(
                  height: 6,
                ),



                Row(
                  children: [
                    Text('Drawer side depth     '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: drawer_box_depth,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),

                /// drawer side gap
                Row(
                  children: [
                    Text('Side Gap each side   '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,

                        controller: side_gap_controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text('Drawers quantity       '),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: TextFormField(
                        onChanged: (_) {
                          // bottom_changed();
                        },
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: drawer_quantity,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (d) {
                          if (d!.isEmpty) {
                            return 'add value please';
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(width: 400,child: Image.asset("lib/assets/images/drawer.png"),)
        ],
      ),
    );
  }
}

