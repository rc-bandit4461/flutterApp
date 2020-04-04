
import 'package:flutter/material.dart';
import 'package:hellp_world/main-drawer.dart';
import './gallery-details.dart';

class Gallery extends StatefulWidget {
  String keyword;

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text(
            "Gallery",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(hintText: "Search here"),
                  onChanged: (String str) {
                    widget.keyword = str;
                    print(str);
                  },
                ),
              ),
              ListTile(
                title: RaisedButton(
                  child: Text("Search"),
                  onPressed: () {
                    if (widget.keyword == null || widget.keyword.length == 0)
                      return;
                    widget.keyword = widget.keyword.trim();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => GalleryPictures(
                                  keyword: widget.keyword,
                                )));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
