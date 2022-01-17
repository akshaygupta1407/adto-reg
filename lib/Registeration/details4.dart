// to ask distance to advertise
import 'dart:io';

import 'package:atdoreg/Registeration/details5.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';

class AskDistance extends StatefulWidget {
  String businessName = '';
  String mobileNumber = '';
  String businessAddress = '';
  File? image;
  String coordinates = '';
  AskDistance({required this.businessName,required this.mobileNumber,required this.businessAddress,required this.image,required this.coordinates});

  @override
  _AskDistanceState createState() => _AskDistanceState(businessName,mobileNumber,businessAddress,image,coordinates);
}

class _AskDistanceState extends State<AskDistance> {
  String businessName;
  String mobileNumber;
  String businessAddress;
  File? image;
  String coordinates;
  _AskDistanceState(this.businessName,this.mobileNumber,this.businessAddress,this.image,this.coordinates);

  int distance = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'ATDO',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  'Set the distance from your location to show your advertisement',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                // Center(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(distance.toString()),

                  ],
                ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.blue,
                        thumbColor: Colors.deepPurpleAccent,
                        overlayColor: Color(0x29EB1555),
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.00),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                      ),
                      child: Slider(value: distance.toDouble(),
                        min: 0,
                        max: 20,
                        onChanged: (double newValue){
                          setState(() {
                            distance = newValue.round();
                          });


                        },
                      ),
                    ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // color: Colors.black,
                    width: double.infinity,
                    child:
                    ElevatedButton(onPressed: ()
                    {
                      String d = distance.toString();
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SelectTime(
                        businessName: businessName,
                        mobileNumber: mobileNumber,
                        businessAddress: businessAddress,
                        image: image,
                        coordinates: coordinates,
                        distance:d,
                      )),);

                    }, child: Text('Next',style: TextStyle(color: Colors.white),))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
