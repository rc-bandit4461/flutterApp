import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:hellp_world/main-drawer.dart';


class QRScan extends StatefulWidget {
  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
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
          onPressed: () async {
            print("clicked");
//            return scanQR_qrscan();
//              result = await QrScanner.scan();

            return scanQR();
          },
        ),
        body: result == null ? Text("") : Text(result),
      ),
    );
  }
  Future scanQR() async {
    try {
      String scanResult = await BarcodeScanner.scan();
      setState(() {
        result = scanResult;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unkown error";
        });
      }
    } on FormatException catch (e) {
      result = "You pressed de back button before scanning";
    } catch (e) {
      setState(() {
        result = "Other error";
      });
    }
  }
}
