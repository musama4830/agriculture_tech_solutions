import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

import './colors.dart' as color;

class LiveMonitoring extends StatefulWidget {
  @override
  State<LiveMonitoring> createState() => _LiveMonitoringState();
}

class _LiveMonitoringState extends State<LiveMonitoring> {
  File imageFile;
  String imageDetails = 'Loading...';
  List _result;
  String _confidence = "0.00%";
  String _name = "";
  String _numbers = "";

  _loadMyModel() async {
    var resultant = await Tflite.loadModel(
        labels: "assets/labels.txt",
        model: "assets/saved_model.tflite",
        numThreads: 1);

    print(resultant);
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 1,
      threshold: 0.2,
      imageMean: 0.0,
      imageStd: 255.0,
      asynch: true,
    );

    setState(() {
      _result = res;

      _name = _result[0]["label"];
      _confidence = _result != null
          ? (_result[0]['confidence'] * 100.0).toString().substring(0, 4) + "%"
          : "";
      imageDetails = _name;
      print(_result);
      print(_name);
      print(_confidence);
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
        imageFile = File(pickedFile.path);
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
        imageFile = File(pickedFile.path);
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
                      imageFile,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              color: color.AppColor.gradientFirst.withOpacity(0.7),
              child: Center(
                child: Text(
                    "Result: ${imageDetails}" + "\nConfidence: ${_confidence}",
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
