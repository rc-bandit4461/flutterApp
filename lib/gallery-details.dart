import 'package:flutter/material.dart';
import 'package:hellp_world/main-drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as Converter;

class GalleryPictures extends StatefulWidget {
  String keyword;
  int number = 5;
  int offset = 5;
  List<dynamic> data;
  List<dynamic> shownData = [];
  int total;

  GalleryPictures({this.keyword});

  @override
  _GalleryPicturesState createState() => _GalleryPicturesState();
}

class _GalleryPicturesState extends State<GalleryPictures> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          widget.offset != widget.data.length) {
        setState(() {
          widget.offset += widget.number;
        });
      }
    });
  }

  void fetchMore(offset, number) {}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getData(query) async {
    print("query -->" + query);
    String url =
        "https://pixabay.com/api/?key=15799459-72fb38ad7afed098b3f7e2db7&q=" +
            query +
            "&image_type=photo";
    http.get(Uri.encodeFull(url), headers: {'accept': 'application/json'}).then(
        (response) {
//          print(response.body);
      dynamic r = Converter.jsonDecode(response.body);
      setState(() {
        widget.total = r['total'];
        widget.total %= 10;
        widget.data = r['hits'];
      });
      print((widget.data[0] as dynamic)["webformatURL"]);
      print(r['total']);
      // print(r.toString());
      print(r);
      fetchMore(widget.offset, widget.number);
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results for " + widget.keyword),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MainDrawer(),
      body: widget.data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount:
                  widget.offset >= widget.data.length ? widget.data.length : widget
                      .offset,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blueAccent,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          title:
                              Center(child: Text(widget.data[index]['tags'],
                                  style: TextStyle(color:Colors.white),))),
                      Container(
//                      constraints: BoxConstraints.tightFor(height: 150),
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                        child: Image.network(widget.data[index]['webformatURL'],
                            fit: BoxFit.fitWidth,),
                      )),

                    ],
                  ),
                );
              },
            ),
    );
  }
}
