import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../../servicelocator.dart';
import 'last_index.dart';

class AddStudentPage extends StatefulWidget {
  final String? dbName;

  const AddStudentPage({this.dbName, Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  static Indx get IndxService => ServiceLocator.get<Indx>();
  final _formKey = GlobalKey<FormState>();

  var title = "";
  String? videoLink;

  int? indx;
  String? imageUrl;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final titleController = TextEditingController();
  final videoLinkController = TextEditingController();
  final indxController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    videoLinkController.dispose();
    indxController.dispose();
    imageController.dispose();
    super.dispose();
  }

  clearText() {
    titleController.clear();
    videoLinkController.clear();
    indxController.clear();
    imageController.clear();
  }

  // Adding Student
  late CollectionReference category =
      FirebaseFirestore.instance.collection(widget.dbName.toString());

  Future<void> addUser() {
    return category
        .doc(indx.toString())
        .set({
          'title': title,
          'videoUrl': videoLink,
          'indx': indx,
          'imageUrl': imageUrl.toString()
        })
        .then((value) => print('Video Data Added'))
        .catchError((error) => print('Failed to Add Video Data: $error'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FlutterClipboard.paste().then((value) {
      setState(() {
        videoLinkController.text = value;
        indxController.text = IndxService.indx.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Video in ${widget.dbName}"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Title';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Video Link: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: videoLinkController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Video Link';
                    } else if (!value.contains('.com')) {
                      return 'Please Enter Valid Link';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'At Index: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: indxController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Index';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Image Url ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: imageController,
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
                          setState(() {
                            title = titleController.text;
                            videoLink = videoLinkController.text;
                            indx = (indxController.text.length > 0)
                                ? int.parse(indxController.text)
                                : IndxService.indx;
                            imageUrl = imageController.text;
                            addUser();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Reset',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
