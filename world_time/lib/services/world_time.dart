import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class WorldTime {

  String location; // Location name for UI
  String time; // Time at that location
  String flag; // url to an asset flag icon
  String url; // Location url for api endpoint
  bool isDayTime; //true or false

  WorldTime({this.location, this.flag, this.url});

  void getTime() async {

    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //print(data);

      String datetime = data['datetime'];
      String a = data['utc_offset'].substring(1, 3);
      String b = data['utc_offset'].substring(4, );
      var c = data['utc_offset'].substring(0,1);

      //print(datetime);
      print(c);

      DateTime now = DateTime.parse(datetime);
      if(c =='+') {
        now = now.add(Duration(hours: int.parse(a), minutes: int.parse(b)));
      }
      else {
        now = now.subtract(Duration(hours: int.parse(a),minutes: int.parse(b)));
      }

      isDayTime = (now.hour>6 && now.hour<19) ? true : false;

      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('found error: $e');
      time = 'could not load time data';
    }
  }
}

