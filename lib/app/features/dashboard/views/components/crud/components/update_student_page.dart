import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String indx;
  String? dbName;
  //add more
  UpdateStudentPage({Key? key, this.dbName, required this.indx})
      : super(key: key);

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  late CollectionReference data =
      FirebaseFirestore.instance.collection(widget.dbName!);

  Future<void> updateUser(
      {String? title, String? videoUrl, int? indx, String? imageUrl}) {
    return data
        .doc(indx.toString())
        .update({
          'title': title,
          'videoUrl': videoUrl,
          'indx': indx,
          'imageUrl': imageUrl
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Video Data"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection(widget.dbName!)
                .doc(widget.indx.toString())
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var title = data!['title'];
              var videoUrl = data['videoUrl'];
              var indx = data['indx'];
              var imageUrl = data['imageUrl'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: title,
                        
                        onChanged: (value) => title = value,
                        decoration: InputDecoration(
                          labelText: 'title: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: videoUrl,
                       
                        onChanged: (value) => videoUrl = value,
                        decoration: InputDecoration(
                          labelText: 'videoUrl: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter videoUrl';
                          } else if (!value.contains('.com')) {
                            return 'Please Enter Valid videoUrl';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: indx,
                        
                        onChanged: (value) => indx = value,
                       
                        decoration: InputDecoration(
                          labelText: 'indx: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter indx';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: imageUrl,
                        onChanged: (value) => title = value,
                        decoration: InputDecoration(
                          labelText: 'ImageUrl: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(
                                    title: title,
                                    videoUrl: videoUrl,
                                    indx: indx,
                                    imageUrl: imageUrl);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
