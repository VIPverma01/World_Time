import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);

    //set background
    String bgImage = data['isDayTime'] ? 'day.jpg':'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.lightBlueAccent[200] : Colors.indigo[600];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              image: ExactAssetImage('images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location' : result['location'],
                          'isDayTime' : result['isDayTime'],
                          'flag' : result['flag']
                        };
                      });
                    },
                    icon: Icon(
                        Icons.edit_location,
                    size: 30,),
                    label: Text(
                        'Choose Location',
                    style: TextStyle(
                      fontSize: 20
                    ),
                    ),
                    color: Colors.transparent,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 70,
                          color: Colors.grey[200],
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
       ),
          ),
        ),
      ),
    );
  }
}
