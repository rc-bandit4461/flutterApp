import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
class Camera2 extends StatefulWidget {
  @override
  _Camera2State createState() => _Camera2State();
}

class _Camera2State extends State<Camera2> {
  File imageFile;
  VisionText visionTextOCR;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("zab"),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: double.infinity,padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    color:Colors.blue,
                    onPressed: (){
                      openDialog(context);
                    },
                    child: Text("pick img"),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child :SingleChildScrollView(child: Text
                    ('${visionTextOCR==null?'':visionTextOCR.text}', )),

                ),
                Padding(
                  padding: const EdgeInsets.all((8)),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color:Colors.deepOrangeAccent,width:
                      1),
                      image: DecorationImage(
                        fit:BoxFit.fitHeight,

                        image:(imageFile!=null) ? FileImage(imageFile)
                            :AssetImage("images/noimg.jpg")
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  Future<VisionText> textRecognition(File imageFile) {
    // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);

final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

    // final Future <VisionText> visionText
    // final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
 final Future <VisionText> visionText = textRecognizer.processImage(visionImage);

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
                    setState(() {
                      imageFile = file;
                      visionTextOCR = visionText;
                    });
                  },
                  child: Text("Gallery")),
              FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
        var file=await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 400, maxHeight: 400);

                    File croppedFile = await ImageCropper.cropImage(sourcePath: file.path);

VisionText visionText=await textRecognition(croppedFile);
                    print(visionText.text);
                    setState(() {
                      imageFile = file;
                      visionTextOCR = visionText;
                    });
                  },
                  child: Text("Camera"))
            ],
          );
        });
  }
}

