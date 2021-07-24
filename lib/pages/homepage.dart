import 'package:flutter/material.dart';
import 'package:mynote/pages/addnote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddNote()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white70,
          ),
          backgroundColor: Colors.grey[700],
        ),
        body: Center(
          child: Text('Notes!'),
        ));
  }
}
