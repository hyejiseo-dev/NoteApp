import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mynote/pages/homepage.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

FirebaseAuth auth = FirebaseAuth.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');

void signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      final User? user = authResult.user;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email
      };

      //uid
      users.doc(user!.uid).get().then((doc) {
        if (doc.exists) {
          // old user
          doc.reference.update(userData);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        } else {
          // new user
          users.doc(user.uid).set(userData);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      });
    }
  } catch (PlatformException) {
    print(PlatformException);
    print("Sign in not Successful!!");
  }
}
