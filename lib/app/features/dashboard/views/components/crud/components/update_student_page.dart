// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class UpdateDataPage extends StatefulWidget {
//   String? dbName;
//   String? docId;
//   UpdateDataPage({this.dbName, this.docId, super.key});

//   @override
//   State<UpdateDataPage> createState() => _UpdateDataPageState();
// }

// class _UpdateDataPageState extends State<UpdateDataPage> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection(widget.dbName!)
//             .doc(widget.docId.toString())
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
           
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//               child: ListView(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 10.0),
//                     child: TextFormField(
//                       initialValue: ['title'],
//                       autofocus: false,
//                       onChanged: (value) => title = value,
//                       decoration: InputDecoration(
//                         labelText: 'Title: ',
//                         labelStyle: TextStyle(fontSize: 20.0),
//                         border: OutlineInputBorder(),
//                         errorStyle:
//                             TextStyle(color: Colors.redAccent, fontSize: 15),
//                       ),
//                       validator: (value) {
//                         return null;
//                       },
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 10.0),
//                     child: TextFormField(
//                       initialValue: videoUrl,
//                       autofocus: false,
//                       onChanged: (value) => videoUrl = value,
//                       decoration: InputDecoration(
//                         labelText: 'videoUrl: ',
//                         labelStyle: TextStyle(fontSize: 20.0),
//                         border: OutlineInputBorder(),
//                         errorStyle:
//                             TextStyle(color: Colors.redAccent, fontSize: 15),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please Enter Email';
//                         } else if (!value.contains('@')) {
//                           return 'Please Enter Valid Email';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 10.0),
//                     child: TextFormField(
//                       initialValue: password,
//                       autofocus: false,
//                       onChanged: (value) => password = value,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Password: ',
//                         labelStyle: TextStyle(fontSize: 20.0),
//                         border: OutlineInputBorder(),
//                         errorStyle:
//                             TextStyle(color: Colors.redAccent, fontSize: 15),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please Enter Password';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Validate returns true if the form is valid, otherwise false.
//                             if (_formKey.currentState!.validate()) {
//                               updateUser(widget.docId, name, email, password);
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: Text(
//                             'Update',
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => {},
//                           child: Text(
//                             'Reset',
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                               primary: Colors.blueGrey),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             );
//           } else {
//             return Text("Unable To Get");
//           }
//         });
//   }
// }
