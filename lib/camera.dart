import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:hellp_world/main-drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  String scannedText;
  File imageFile;

  VisionText visionTextOCR;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          "Camera",
          style: TextStyle(backgroundColor: Colors.red),
        ),
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: double.infinity, padding: EdgeInsets.all(10),
            child: MaterialButton(
              color: Colors.lightBlue,
              child: Text(
                "Pick image",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print("pick Image btn pressed");
                openDialog(context);
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Text("${scannedText == null ? "" : scannedText}"),
            ),
          ),
          imageFile == null
              ? Text("Pas dimage")
              : Image.file(
                  imageFile,
                  height: 300,
                )
        ],
      ),
    );
  }

  Future<VisionText> textRecognition(File imageFile) {
    // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    // final Future <VisionText> visionText
    // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final Future<VisionText> visionText =
        textRecognizer.processImage(visionImage);
    return visionText;
  }

  Future<void> openDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    var file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    File croppedFile =
                        await ImageCropper.cropImage(sourcePath: file.path);
                    VisionText visionText = await textRecognition(croppedFile);
                        scannedText = visionText.text;
                    setState(() {
                      imageFile = file;
                      visionTextOCR = visionText;
                    });
                  },
                  child: Text("Gallery")),
              FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    var file = await ImagePicker.pickImage(
                        source: ImageSource.camera,
                        maxWidth: 400,
                        maxHeight: 400);
                    File croppedFile =
                        await ImageCropper.cropImage(sourcePath: file.path);
                    VisionText visionText = await textRecognition(croppedFile);
                    print(visionText.text);
                    setState(() {
                      imageFile = croppedFile;
                      visionTextOCR = visionText;
                      scannedText = visionText.text;
                    });
                  },
                  child: Text("Camera"))
            ],
          );
        });
  }
}
