// import 'package:flutter/material.dart';
// import 'crud.dart';

// class GetData extends StatefulWidget {
//   @override
//   _GetDataState createState() => _GetDataState();
// }

// class _GetDataState extends State<GetData> {
//   CrudMethods _crudMethods = new CrudMethods();
//   Stream mySnapshot;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _crudMethods.getMyData().then((result) {
//       print(mySnapshot.toString());
//       setState(() {
//         mySnapshot = result;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             mySnapshot != null
//                 ? StreamBuilder(
//                     stream: mySnapshot,
//                     builder: (context, snapshot) {
//                       return Container(
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: snapshot.data.docs.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               child: ListTile(
//                                 // title: Text(
//                                 //   snapshot.data.docs[index].get('userName')),
//                                 subtitle: Text(
//                                     snapshot.data.docs[index].get('userAge')),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   )
//                 : Center(
//                     child: CircularProgressIndicator(),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
