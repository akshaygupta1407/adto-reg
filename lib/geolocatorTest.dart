// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// class GeoLocator extends StatefulWidget {
//
//
//   @override
//   _GeoLocatorState createState() => _GeoLocatorState();
// }
//
// class _GeoLocatorState extends State<GeoLocator> {
//   String latitudeData = "";
//   String longitudeData = "";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCurrentLocation();
//   }
//
//   getCurrentLocation() async {
//       final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         latitudeData = '${geoPosition.latitude}';
//         longitudeData = '${geoPosition.longitude}';
//       });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('GeoLocator'),),
//       body: Column(
//         children: [
//           Text(latitudeData),
//           Text(longitudeData),
//         ],
//       ),
//     );
//   }
// }
