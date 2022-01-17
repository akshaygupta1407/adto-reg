import 'package:atdoreg/Registeration/Login.dart';
import 'package:atdoreg/Registeration/RegHistory.dart';
import 'package:atdoreg/Registeration/details2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
class Home extends StatefulWidget {
  String mobileNumber = "";
  Home({required this.mobileNumber});
  @override
  _HomeState createState() => _HomeState(mobileNumber);
}

class _HomeState extends State<Home> {
  String mobileNumber;
  String businessName = '';
  _HomeState(this.mobileNumber);
  TextEditingController businessNameController = TextEditingController();
  final query = "Near 4, Delhi - Jaipur Expy, Sector 15 Part -2 Sector 15, Gurugram, Haryana 122001";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("ADTO"),
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
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(mobileNumber),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  // image: DecorationImage(
                  //     image: AssetImage("assets/logo.jpg"),
                  //     fit: BoxFit.cover
                  // ),
                ),
              ),
              ListTile(
                title: Text('Registration History'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationHistory(mobileNumber: mobileNumber)));
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "New Campaign",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Okay give us your Business name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: TextField(
                    controller: businessNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: "Your Business name"),
                    onChanged: (value){
                      businessName = value;
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
                        //async
                        {
                          print(mobileNumber);
                          // var addresses = await Geocoder.local.findAddressesFromQuery(query);
                          // var first = addresses.first;
                          // print("${first.featureName} : ${first.coordinates}");
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => Details2(businessName)));
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details2(businessName: businessName,mobileNumber: mobileNumber)));
                        }, child: Text('Next',style: TextStyle(color: Colors.white),))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
