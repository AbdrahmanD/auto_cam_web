

class Point_model{

  late double x_coordinate;
  late double y_coordinate;
  late double z_coordinate;

  Point_model(this.x_coordinate,this.y_coordinate,this.z_coordinate);

  Point_model.fromJson(Map<String, dynamic> json) {

    x_coordinate = json["x_coordinate"];
    y_coordinate = json["y_coordinate"];
    z_coordinate = json["z_coordinate"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['"x_coordinate"'] = "${this.x_coordinate}";
    data['"y_coordinate"'] = "${this.y_coordinate}";
    data['"z_coordinate"'] = "${this.z_coordinate}";
    return data;
  }

  Point_model correct_cordinate( ){

    double new_X=double.parse(this.x_coordinate.toStringAsFixed(2));
    double new_Y=double.parse(this.y_coordinate.toStringAsFixed(2));
    double new_Z=double.parse(this.z_coordinate.toStringAsFixed(2));

    return Point_model(new_X, new_Y, new_Z);
  }


}

class Fastener_Point {

   late double distance;
  late String fastener_type;

   Fastener_Point(this.distance, this.fastener_type);
}