import 'dart:io';

import 'package:atdoreg/Registeration/details4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';

class ImageUpload extends StatefulWidget {
  String businessName = '';
  String mobileNumber = '';
  String businessAddress = '';
  String coordinates = '';
  ImageUpload(
      {required this.businessName,
      required this.mobileNumber,
      required this.businessAddress,
      required this.coordinates});
  @override
  _ImageUploadState createState() => _ImageUploadState(
      businessName, mobileNumber, businessAddress, coordinates);
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;
  String businessName;
  String mobileNumber;
  String businessAddress;
  String coordinates;
  _ImageUploadState(this.businessName, this.mobileNumber, this.businessAddress,
      this.coordinates);
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick Image: $e');
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              image != null
                  ? Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  : FlutterLogo(
                      size: 160,
                    ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: Icon(
                  Icons.image_outlined,
                  color: Colors.green,
                  size: 30.0,
                ),
                label: Text('Pick Image from Gallery'),
                onPressed: () => pickImage(),
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 30.0,
                ),
                label: Text('Next'),
                onPressed: () {
                  if (image != null) {
                    print(businessName);
                    print(businessAddress);
                    print(mobileNumber);
                    print(coordinates);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AskDistance(
                                  businessName: businessName,
                                  mobileNumber: mobileNumber,
                                  businessAddress: businessAddress,
                                  image: image,
                                  coordinates: coordinates,
                                )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Pick Image from Gallery first!')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
