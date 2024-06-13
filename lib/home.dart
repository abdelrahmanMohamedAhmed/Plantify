// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, avoid_unnecessary_containers, prefer_final_fields, unused_field, unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bottom_bar/bottom_bar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
    int _currentPage = 0;
    int buttonIndex = 0 ;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(children: [
        Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/first.png"),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
              //launch text
            Text("let's find diseases ",style: TextStyle(
            color: Color.fromARGB(249, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.bold,),
            ),
            Text("Everything here about plants makes you better ",style: TextStyle(
            color: Color.fromARGB(255, 66, 126, 59),
            fontSize: 25,
            fontWeight: FontWeight.normal,),
            ),

            //Container of Main buttons

            //1 Button for Corn
           Container(
            margin: EdgeInsets.all(10),
            child:Column(
              children: [
                MaterialButton(
                  padding: EdgeInsets.all(15),
                  color: Color.fromARGB(255, 66, 126, 59),
                  textColor: Color.fromARGB(255, 255, 255, 255),
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: (){
                  buttonIndex=1;
                  Navigator.pushNamed(context, '/test',arguments: buttonIndex);
                },
                  child: Text("Detect Corn Leaf",style: TextStyle(fontSize: 18),),
                ),
              
              SizedBox(height: 20),
          
           // 2 Button for Rice
              MaterialButton(
            padding: EdgeInsets.all(15),
            color: Color.fromARGB(255, 66, 126, 59),
            textColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           onPressed: (){
            buttonIndex=2;
             Navigator.pushNamed(context, '/test',arguments: buttonIndex);
           },
            child: Text("Detect Rice Leaf",style: TextStyle(fontSize: 18),),
           ),
            
           ],
            ) 
           )

            ],),
          ),
          Image.asset("assets/second.png",alignment: Alignment.bottomCenter)
        ],
        )],)
       

    );
  }
}