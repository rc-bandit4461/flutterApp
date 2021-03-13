import 'dart:convert' as Converter;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherDetails extends StatefulWidget {
  String city;

  WeatherDetails(this.city);

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

String getDayFromTimestamp(int timestamp) {
  return DateFormat("E")
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
}

String getTimeFromTimestamp(int timestamp) {
  return DateFormat("HH:mm a")
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
}

String getDateFromTimestamp(int timestamp) {
  return DateFormat("d/M/y")
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
}

class _WeatherDetailsState extends State<WeatherDetails> {
  List<dynamic> weatherData;

  getData(url) {
    http.get(Uri.encodeFull(url), headers: {'accept': 'application/json'}).then(
        (response) {
      setState(() {
        weatherData = Converter.jsonDecode(response.body)['list'];
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String url = "http://api.openweathermap.org/data/2.5/forecast?q="+widget
        .city+"&appid=f546f3f09c22c9df7c107d30c7ddb708";
    print("url -->" + url);
    getData(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weather" + " in " + widget.city,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: (weatherData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: weatherData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                    child: Card(
                      color: Colors.indigo,
                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin:const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("assets/icons/_" +
                                    weatherData[index]['weather'][0]['icon'] +
                                    ""
                                        ".png"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Column(
                              children: <Widget>[
                                Container(
//                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                  child: Text(
                                    getDayFromTimestamp(
                                            weatherData[index]['dt']) +
                                        " " +
                                        getDateFromTimestamp(
                                            weatherData[index]['dt']),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
//                                  margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  child: Text(
                                    getTimeFromTimestamp(
                                            weatherData[index]['dt']) +
                                        " | " +
                                        weatherData[index]['weather'][0]['main']
                                            .toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (weatherData[index]['main']['temp'] -273.15)
                                        .toStringAsFixed(1) +
                                    "°C",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
      ),
    );
  }
}
