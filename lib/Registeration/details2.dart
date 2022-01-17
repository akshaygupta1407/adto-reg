import 'package:atdoreg/Registeration/details3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:geocoder/geocoder.dart';

class Details2 extends StatefulWidget {
  String businessName = "";
  String mobileNumber = "";
  Details2({required this.businessName, required this.mobileNumber});
  @override
  _Details2State createState() => _Details2State(businessName, mobileNumber);
}

class _Details2State extends State<Details2> {
  TextEditingController address = TextEditingController();
  String businessName;
  String mobileNumber;
  String coordinates = '';
  _Details2State(this.businessName, this.mobileNumber);
  String businessAddress = '';
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
                  'Tell us where people go after they see your ad',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: "Your Business Address"),
                    onChanged: (value) {
                      businessAddress = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    // color: Colors.black,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          final query = businessAddress;
                          var addresses = await Geocoder.local
                              .findAddressesFromQuery(query);
                          var first = addresses.first;
                          setState(() {
                            coordinates = first.coordinates.toString();


                          });
                          //address + coordinates
                          print("${first.featureName} : ${first.coordinates}");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageUpload(
                                      businessName: businessName,
                                      mobileNumber: mobileNumber,
                                      businessAddress: businessAddress,
                                    coordinates: coordinates,
                                  )));
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
