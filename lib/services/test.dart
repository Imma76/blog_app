// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'test2.dart';

// class Database extends StatefulWidget {
//   @override
//   _DatabaseState createState() => _DatabaseState();
// }

// class _DatabaseState extends State<Database> {
//   TextEditingController userTextEditingController = TextEditingController();
//   TextEditingController userAgeTextEditingController = TextEditingController();
//   TextEditingController userProfEditingController = TextEditingController();
//   bool upload = false;
//   uploadData() {
//     setState(() {
//       upload = true;
//     });
//     Map<String, dynamic> userData = {
//       'userName': userTextEditingController.text,
//       'userAge': userAgeTextEditingController.text,
//       'userprof': userProfEditingController.text,
//     };
//     final uploadData = FirebaseFirestore.instance
//         .collection('UserData')
//         .add(userData)
//         .then((value) {
//       print('done uploading');
//       setState(() {
//         upload = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white30,
//         body: upload
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(hintText: 'Name'),
//                       controller: userTextEditingController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(hintText: 'Age'),
//                       controller: userAgeTextEditingController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(hintText: 'Profession'),
//                       controller: userProfEditingController,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RaisedButton(
//                       onPressed: () {
//                         uploadData();
//                       },
//                       child: Text('Upload'),
//                       color: Colors.blue,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RaisedButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return GetData();
//                         }));
//                       },
//                       child: Text('See data Uploaded'),
//                       color: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
