import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import './colors.dart' as color;

class LiveMonitoring extends StatefulWidget {
  @override
  State<LiveMonitoring> createState() => _LiveMonitoringState();
}

class _LiveMonitoringState extends State<LiveMonitoring> {
  File imageFile;
  var imageDetails = 'Image description...';

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.of(context).pop();
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
                  : Image.file(imageFile),
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
