// time picker
import 'dart:io';

import 'package:atdoreg/Registeration/finalRegPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';

class SelectTime extends StatefulWidget {
  String businessName = '';
  String mobileNumber = '';
  String businessAddress = '';
  File? image;
  String coordinates = '';
  String distance = '';
  SelectTime(
      {required this.businessName,
      required this.mobileNumber,
      required this.businessAddress,
      required this.image,
      required this.coordinates,
      required this.distance});

  @override
  _SelectTimeState createState() => _SelectTimeState(businessName, mobileNumber,
      businessAddress, image, coordinates, distance);
}

class _SelectTimeState extends State<SelectTime> {
  String startTime = "";
  String endTime = "";
  String businessName;
  String mobileNumber;
  String businessAddress;
  File? image;
  String coordinates;
  String distance;
  _SelectTimeState(this.businessName, this.mobileNumber, this.businessAddress,
      this.image, this.coordinates, this.distance);
  Future<void> _show1() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        startTime = result.format(context);
      });
    }
  }

  Future<void> _show2() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        endTime = result.format(context);
      });
    }
  }

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
                  'Select the time to show your advertisement',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                // Center(
                //   child: TextFormField(
                //     // controller: address,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12)),
                //         hintText: "Starting Time"),
                //     onTap: () {
                //       _show1();
                //     },
                //     onChanged: (value) {
                //       // businessAddress = value;
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    // color: Colors.black,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => _show1(),
                        child: Text(
                          startTime == "" ? 'Choose StartTime' : startTime,
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    // color: Colors.black,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => _show2(),
                        child: Text(
                          endTime == "" ? 'Choose EndTime' : endTime,
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    // color: Colors.black,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => finalReg(
                              businessName: businessName,
                              mobileNumber: mobileNumber,
                              businessAddress: businessAddress,
                              image: image,
                              coordinates: coordinates,
                              distance:distance,
                              startTime: startTime,
                              endTime: endTime,
                            ),),
                          );
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
