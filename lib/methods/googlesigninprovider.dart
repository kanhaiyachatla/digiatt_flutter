import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/Screens/HomeScreen.dart';
import 'package:digiatt/methods/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context, String role) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value)
        {
           FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set(
               {
                 'email' : _user!.email,
                 'name' : _user!.displayName,
                 'photourl' : _user!.photoUrl,
                 'role' : role
               }).then((value) => {
             Navigator.of(context).pushReplacement(
                 MaterialPageRoute(builder: (context) => HomeScreen()))
           });
        });
  }
}
