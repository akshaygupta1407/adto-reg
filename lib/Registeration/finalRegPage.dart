// final registration page where user will recheck the details and then it will send to the firebase
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'package:firebase_storage/firebase_storage.dart';

class finalReg extends StatefulWidget {
  String businessName = '';
  String mobileNumber = '';
  String businessAddress = '';
  File? image;
  String coordinates = '';
  String distance = '';
  String startTime = "";
  String endTime = "";

  finalReg({required this.businessName,
    required this.mobileNumber,
    required this.businessAddress,
    required this.image,
    required this.coordinates,
    required this.distance,required this.startTime,required this.endTime});
  @override
  _finalRegState createState() => _finalRegState(businessName, mobileNumber,
      businessAddress, image, coordinates, distance,startTime,endTime);
}

class _finalRegState extends State<finalReg> {
  String startTime;
  String endTime;
  String businessName;
  String mobileNumber;
  String businessAddress;
  File? image;
  String coordinates;
  String distance;
  _finalRegState(this.businessName,this.mobileNumber, this.businessAddress,
      this.image, this.coordinates, this.distance,this.startTime,this.endTime);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseStorage storage = FirebaseStorage.instance;



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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Your final Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 20,),
                Text(businessName),
                Text(mobileNumber),
                Text(businessAddress),
                SizedBox(height: 10,),
                Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10,),
                Text(coordinates),
                Text(distance),
                Text(startTime),
                Text(endTime),
                SizedBox(height: 10,),
                Container(
                  // color: Colors.black,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                          String url = "";
                          Reference ref = storage.ref().child("${image.toString()}");
                          UploadTask uploadTask = ref.putFile(image!);

                          var dowurl = await (await uploadTask).ref.getDownloadURL();
                          url = dowurl.toString();
                          print(url);
                          // Reference reference = storage.ref().child("${image.toString()}");
                          // UploadTask uploadTask = reference.putFile(image!);
                          const start1 = '{';
                          const end1 = ',';
                          final startIndex1 = coordinates.indexOf(start1);
                          final endIndex1 = coordinates.indexOf(end1, startIndex1 + start1.length);
                          print(coordinates.substring(startIndex1 + start1.length, endIndex1));
                          String latitude = coordinates.substring(startIndex1 + start1.length, endIndex1);
                          const start2 = ',';
                          const end2 = '}';
                          final startIndex2 = coordinates.indexOf(start2);
                          final endIndex2 = coordinates.indexOf(end2, startIndex2 + start2.length);
                          print(coordinates.substring(startIndex2 + start2.length, endIndex2));
                          String longitude = coordinates.substring(startIndex2 + start2.length, endIndex2);

                          await users.add({
                            'BusinessName' : businessName,
                            'MobileNumber' : mobileNumber,
                            'BusinessAddress' : businessAddress,
                            'Coordinates' : coordinates,
                            'Latitude' : latitude,
                            'Longitude' : longitude,
                            'Distance' : distance,
                            'StartTime' : startTime,
                            'EndTime' : endTime,
                            'ImageId' : image.toString(),
                            'ImageUrl' : url,
                            'Status' : false,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Submitted Successfully!')));
                          // const start = '{';
                          // const end = ',';
                          // final startIndex = coordinates.indexOf(start);
                          // final endIndex = coordinates.indexOf(end, startIndex + start.length);
                          // print(coordinates.substring(startIndex + start.length, endIndex));

                          await FirebaseAuth.instance.signOut();
                          // Navigator.of(context).popUntil((route) => route.isFirst);
                          // Navigator.push(context,
                          //     new MaterialPageRoute(builder: (context) => new Login()));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        child: Text(
                          'Submit',
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
