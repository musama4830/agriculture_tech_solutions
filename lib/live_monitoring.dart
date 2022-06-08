import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import './colors.dart' as color;

class LiveMonitoring extends StatefulWidget {
  @override
  State<LiveMonitoring> createState() => _LiveMonitoringState();
}

class _LiveMonitoringState extends State<LiveMonitoring> {
  File imageFile;
  String imageDetails = 'Image description...';
  List _result;
  String _confidence = "";
  String _name = "";
  String _numbers = "";

  _loadMyModel() async {
    var resultant = await Tflite.loadModel(
        labels: "assets/labels.txt", model: "assets/saved_model.tflite");
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _result = res;

      String str = _result[0]["label"];
      _name = str.substring(4);
      _confidence = _result != null
          ? (_result[0]['confidence'] * 100.0).toString().substring(0, 4) + "%"
          : "";
      imageDetails = _name;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMyModel();
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile as File;
      });
      Navigator.of(context).pop();
      applyModelOnImage(imageFile);
    }
  }

  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile as File;
      });
      Navigator.of(context).pop();
      applyModelOnImage(imageFile);
    }
  }

  void takePhoto() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 110,
            color: color.AppColor.gradientFirst.withOpacity(0.6),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.camera),
                        onPressed: () {
                          _getFromCamera();
                        }),
                    const SizedBox(height: 5),
                    const Text('Camera')
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.photo),
                        onPressed: () {
                          _getFromGallery();
                        }),
                    const SizedBox(height: 5),
                    const Text('Gallery')
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      appBar: AppBar(
        title: const Text("Live Monitoring"),
        centerTitle: true,
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              color: color.AppColor.gradientFirst.withOpacity(0.1),
              child: imageFile == null
                  ? const Center(
                      child: Text('Live Monitoring...'),
                    )
                  : Image.file(
                      File(imageFile.path),
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              color: color.AppColor.gradientFirst.withOpacity(0.7),
              child: Center(
                child: Text(imageDetails,
                    style: TextStyle(
                        color: color.AppColor.homePageBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        backgroundColor: color.AppColor.gradientFirst.withOpacity(0.7),
        onPressed: () => takePhoto(),
      ),
    );
  }
}
