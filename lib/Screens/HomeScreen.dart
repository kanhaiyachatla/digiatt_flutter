import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/Screens/ClassScreens/ClassHomeScreen.dart';
import 'package:digiatt/Screens/CreateGroup.dart';
import 'package:digiatt/Screens/ProfileScreen.dart';
import 'package:digiatt/main.dart';
import 'package:digiatt/methods/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../methods/CLassModel.dart';
import 'JoinClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser!;

  var _code = TextEditingController();
  var snap;

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

      body: StreamBuilder(
        stream: readClass(),
        builder: (context,snapshot)   {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
        }else if (snapshot.hasError){
            return Container(child: Center(child: Text('Something went wrong'),),);
          } else if(snapshot.hasData){
            final users = snapshot.data!;

            return ListView(children: users.map(buildClass).toList());
          }else{
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }


  Widget buildClass(ClassModel user) => ListTile(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClassHomeScreen(classData: user))),
    leading: user.photourl == '' ? CircleAvatar(backgroundColor: Colors.grey.withOpacity(0.5),child: Icon(Icons.group, color: Colors.grey.shade700,),) :CircleAvatar(backgroundImage: NetworkImage(user.photourl),),
    title: Text(user.name),
    subtitle: Text(user.description),
  );
  
  
  Stream<List<ClassModel>> readClass() => FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('inGroup').snapshots().map((snapshot) => snapshot.docs.map((doc) => ClassModel.fromJson(doc.data())).toList());

  Future<UserModel?> ReadUser() async {
    final Docid = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    final snapshot = await Docid.get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
  }
}
