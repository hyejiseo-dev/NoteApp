//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String description;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24.0,
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[700]),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0))),
                    ),
                    ElevatedButton(
                      onPressed: add,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: "lato",
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[700]),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                      ),
                      style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      onChanged: (_val) {
                        title = _val;
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Note Description",
                          ),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "lato",
                              color: Colors.grey),
                          onChanged: (_val) {
                            description = _val;
                          },
                          maxLines: 20,
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': description,
      'created': DateTime.now(),
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}
