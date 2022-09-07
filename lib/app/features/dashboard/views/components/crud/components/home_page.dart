import 'package:flutter/material.dart';
import 'package:kidsadmin/app/features/dashboard/views/components/crud/components/add_student_page.dart';
import 'package:kidsadmin/app/features/dashboard/views/components/crud/components/list_student_page.dart';

import 'last_index.dart';

class HomePage extends StatefulWidget {
  String? dbName;
  HomePage({this.dbName, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Admin Data Manager'),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentPage(dbName: widget.dbName, ),
                  ),
                )
              },
              child: Text('Add', style: TextStyle(fontSize: 20.0)),
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            )
          ],
        ),
      ),
      body: ListStudentPage(dbName: widget.dbName,),
    );
  }
}
