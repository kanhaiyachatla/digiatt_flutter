import 'package:digiatt/Screens/CreateGroup.dart';
import 'package:digiatt/Screens/LoginScreen.dart';
import 'package:digiatt/Screens/ProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser!;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('DigiAtt', style: TextStyle(fontFamily: 'Inter'),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
          }, icon: Icon(Icons.person_outline))
        ],
      ),
      body: Stack(
       children: [
         Align(
           alignment: Alignment.bottomRight,
           child: Container(
             margin: EdgeInsets.all(20),
             child: FloatingActionButton(
               backgroundColor: Theme.of(context).colorScheme.primary,
               onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateGroup()));
               },
               child: Icon(Icons.add,size: 35,),
             ),
           ),
         ),
       ],
      ),
    );
  }
}
