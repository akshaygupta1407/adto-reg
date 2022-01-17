import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistrationHistory extends StatefulWidget {
  String mobileNumber = "";
  RegistrationHistory({required this.mobileNumber});

  @override
  _RegistrationHistoryState createState() => _RegistrationHistoryState(mobileNumber);
}

class _RegistrationHistoryState extends State<RegistrationHistory> {
  String mobileNumber;
  _RegistrationHistoryState(this.mobileNumber);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Activity'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //orderBy("text",descending: false).snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (!snapshot.hasData) {
            return LinearProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),backgroundColor: Colors.white,);
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder:(_, i) {
                final data = docs[i].data();
                return data['MobileNumber'] == mobileNumber ? Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: Card(
                    // elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    shadowColor: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child:
                        Container(
                          child: Column(
                            children: [
                              Text(data['BusinessName'],style: TextStyle(fontWeight: FontWeight.w500),),
                              Text(data['MobileNumber']),
                              Text(data['BusinessAddress']),
                              Text(data['Distance']),
                              Text(data['StartTime']),
                              Text(data['EndTime']),
                              Image(image: NetworkImage("${data['ImageUrl']}")),
                              data['Status']==false ? Text('Status : Pending') : Text('Status : Accepted'),
                            ],
                          ),
                        ),
                    ),
                  ),
                ) : Container();
              },
            );
          }
          return LinearProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),backgroundColor: Colors.white,);
        },
      ),
    ),);
  }
}
