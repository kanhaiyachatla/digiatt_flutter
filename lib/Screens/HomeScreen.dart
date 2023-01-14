import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/Screens/CreateGroup.dart';
import 'package:digiatt/Screens/ProfileScreen.dart';
import 'package:digiatt/main.dart';
import 'package:digiatt/methods/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'JoinClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser!;

  var _code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DigiAtt',
          style: TextStyle(fontFamily: 'Inter'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: Icon(Icons.person_outline))
        ],
      ),
      floatingActionButton: FutureBuilder<UserModel?>(
        future: ReadUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            snackbarKey.currentState
                ?.showSnackBar(SnackBar(content: Text('Something went wrong')));
          } else if (snapshot.hasData) {
            var user1 = snapshot.data;

            return user1 == null
                ? const Center(
                    child: Text('No user'),
                  )
                : SpeedDial(
                    overlayColor: Colors.black,
                    overlayOpacity: 0.4,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    icon: CupertinoIcons.add,
                    activeIcon: CupertinoIcons.multiply,
                    children: [
                      SpeedDialChild(
                        visible: (user1.role == 'teacher') ? true: false,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CreateGroup())),
                          child: Icon(Icons.group_add),
                          label: 'Create class'),
                      SpeedDialChild(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => JoinClass())),
                          child: Icon(Icons.group_add_outlined),
                          label: 'Join class')
                    ],
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<UserModel?> ReadUser() async {
    final Docid = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    final snapshot = await Docid.get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
  }
}
