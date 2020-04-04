import 'package:flutter/material.dart';
import 'package:hellp_world/main-drawer.dart';
import './weather-details.dart';



class Weather extends  StatefulWidget{
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(
            "Weather" + (city == null? "":" in " + city),
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(hintText: "Nom de ville"),
                onChanged: (str) {
                  print("changed-->" + str);
                  city = str;
                },
              ),
            ),
            ListTile(
              title: RaisedButton(
                child: Text("Chercher"),
                onPressed: () {
                  if(city== null || city.length == 0) return;
                  city = city.trim();
                  print("Pressed search button");
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => WeatherDetails(city)
                  ));
                },
              ),
            )
          ],
        ));
  }
}
