// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_new, avoid_print, unused_local_variable, prefer_final_fields

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ImagePickerDemo extends StatefulWidget {
  // int _currentPage = 1;
  // final _pageController = PageController();

  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  var testResult = "";
  int? _buttonIndex;

  @override
  void initState() {
    super.initState();
    // Call loadmodel in initState to ensure it's loaded when the widget is first created
    loadmodel().then((value) {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_buttonIndex == null) {
      _buttonIndex = ModalRoute.of(context)?.settings.arguments as int?;
      // Call loadmodel again if _buttonIndex changes
      loadmodel().then((value) {
        setState(() {});
      });
    }
  }

  Future<void> loadmodel() async {
    // Define loadmodel function outside of didChangeDependencies
    // Use _buttonIndex to determine which model to load
    if (_buttonIndex == 1) {
      await Tflite.loadModel(
        model: "assets/CornModel/modelMn.tflite",
        labels: "assets/CornModel/labels.txt",
      );
    } else if (_buttonIndex == 2) {
      await Tflite.loadModel(
        model: "assets/RiceModel/Rice_Model.tflite",
        labels: "assets/RiceModel/labels.txt",
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> detectimage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      testResult = _recognitions.toString();
    });
    print("//////////////////////////////////////////////////");
    print(_recognitions);
    print("//////////////////////////////////////////////////");
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
    print(testResult);
  }

  getCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
        backgroundColor: Color.fromARGB(255, 66, 126, 59),
        title: Text(
          'Plantify',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              )
            else
              Text('No image selected'),
            SizedBox(height: 20),
            // Gallery picker button
            MaterialButton(
              padding: EdgeInsets.all(22),
              color: Color.fromARGB(255, 66, 126, 59),
              textColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text(
                'Pick Image from Gallery',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            SizedBox(height: 20),
            // Camera picker button
            MaterialButton(
              padding: EdgeInsets.all(22),
              color: Color.fromARGB(255, 66, 126, 59),
              textColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text(
                'Pick Image from Camera',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            SizedBox(height: 20),
            // Show result button
            if (_image != null)
              MaterialButton(
                padding: EdgeInsets.all(18),
                color: Color.fromARGB(255, 66, 126, 59),
                textColor: Color.fromARGB(255, 255, 255, 255),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/result',
                    arguments: {
                      'testResult': testResult,
                      'image': _image,
                    },
                  );
                },
                child: Text(
                  'Show the result',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}