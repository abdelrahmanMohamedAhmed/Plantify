// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    String testResult = args?['testResult'] ?? '';
    final XFile? image = args?['image'] as XFile?;

    RegExp confidenceRegExp = RegExp(r"confidence:\s*([\d.]+)");
    RegExp labelRegExp = RegExp(r"label:\s*([^ { | } \]]+)");

    String confidence = confidenceRegExp.firstMatch(testResult)?.group(1) ?? '';
    String label = labelRegExp.firstMatch(testResult)?.group(1) ?? '';

    String formattedResult = "Confidence = $confidence \n"
        "Disease = $label";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 66, 126, 59),
        title: Text(
          'Plantify',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
       
        children: [
          SizedBox(height: 50),
          Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color.fromARGB(255, 242, 255, 212),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  child: Image.file(
                    File(image!.path),
                    height: 150,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 242, 255, 212),
                    border: Border.all(
                      color: Color.fromARGB(255, 66, 126, 59),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      formattedResult,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w300,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:Color.fromARGB(255, 66, 126, 59),
                          ),
                          onPressed: () {
                             Navigator.popAndPushNamed(context, '/home');
                          },
                          child: const Text(
                            "Back Home",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:Color.fromARGB(255, 66, 126, 59),
                          ),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/test');
                          },
                          child: const Text(
                            "Another Test",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
         
          SizedBox(height: 10),
          Image.asset(
            "assets/check.jpg",
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
           SizedBox(height: 20),
          Text(
            'Result Check',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}