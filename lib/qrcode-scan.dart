import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart' as scanner;
import 'package:flutter/services.dart';
import 'package:hellp_world/main-drawer.dart';

class QRScan2 extends StatefulWidget {
  @override
  _QRScan2State createState() => _QRScan2State();
}

class _QRScan2State extends State<QRScan2> {
  String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text("QR Code Scanner"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("Click"),
          onPressed: () {
            print("clicked");
//            return scanQR_qrscan();
            setState(() {
               scanQR();
            });
          },
        ),
        body: result == null ? Text("") : Text(result),
      ),
    );
  }



  void scanQR() async{
String cameraScanResult = await scanner.scan();
    result = cameraScanResult;
  }
}
