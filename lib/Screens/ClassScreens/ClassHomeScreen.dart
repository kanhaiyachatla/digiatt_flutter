import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/Screens/HomeScreen.dart';
import 'package:digiatt/main.dart';
import 'package:digiatt/methods/CLassModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../methods/UserModel.dart';
import 'BodyClassHomeScreen.dart';
import 'ClassAssignmentScreen.dart';
import 'ClassParticipantsScreen.dart';

class ClassHomeScreen extends StatefulWidget {
  ClassModel classData;

  ClassHomeScreen({Key? key, required this.classData}) : super(key: key);

  @override
  State<ClassHomeScreen> createState() => _ClassHomeScreenState(classData);
}

class _ClassHomeScreenState extends State<ClassHomeScreen> {
  var classData;
  int index =0;

  _ClassHomeScreenState(this.classData);

  var cUser = FirebaseAuth.instance.currentUser!;
  var Screens = [
    BodyClassHomeScreen(),
    ClassAssignmentScreen(),
    ClassParticipantsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(classData.name),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.messenger_rounded)),
          ],
        ),

        body: Screens[index],
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: GNav(
              gap: 12,
              color: Colors.white,
              tabBackgroundColor: Colors.white,
              activeColor: Colors.black,
              padding: EdgeInsets.all(16),
              backgroundColor: Theme.of(context).colorScheme.primary,
              selectedIndex: index,
              onTabChange: (index) => setState(() {
                this.index = index;
              }),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.assignment,
                  text: 'Assignments',
                ),
                GButton(
                  icon: Icons.people_alt,
                  text: 'Participants',
                ),
              ],
            ),
          ),
        ));
  }
}
