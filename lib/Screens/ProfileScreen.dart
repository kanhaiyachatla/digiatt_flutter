import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/Screens/LoginScreen.dart';
import 'package:digiatt/main.dart';
import 'package:digiatt/methods/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  final user1 = FirebaseAuth.instance.currentUser!;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Profile',
            style: TextStyle(fontFamily: 'Inter'),
          ),
        ),
        body: FutureBuilder<UserModel?>(
          future: ReadUser(),
          builder: (context, snap) {
            if (snap.hasError) {
              snackbarKey.currentState?.showSnackBar(
                  SnackBar(content: Text('Something went wrong')));
            } else if (snap.hasData) {
              final user = snap.data;

              return user == null
                  ? const Center(
                      child: Text('No user'),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ],
                      )),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height / 5,
                            ),
                            Center(
                              child: Material(
                                elevation: 4,
                                shape: CircleBorder(
                                  side: BorderSide.none,
                                ),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: user.photourl == ""
                                      ? null
                                      : NetworkImage(user.photourl),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 18,
                            ),
                            Container(
                              height: size.height/4,
                              child: Card(
                                elevation: 10,
                                margin: const EdgeInsets.only(left: 16,right: 16),
                                shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20), ),

                                child: Container(
                                  margin: EdgeInsets.only(left: 24,right: 24,top: 24,bottom: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                  Text(
                                  'Name : ' + user.name,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),

                                  Text(
                                    'Email : ' + user.email,
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),

                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        elevation: 5,

                                      ),
                                      onPressed: () => FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pop()),
                                      icon : const Icon(
                                        Icons.exit_to_app,
                                        color: Colors.white,
                                      ),
                                      label: Text('Log Out', style: Theme.of(context).textTheme.headline3,),
                                    ),
                                  ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
        ));
  }

  Future<UserModel?> ReadUser() async {
    final Docid = FirebaseFirestore.instance.collection("Users").doc(user1.uid);
    final snapshot = await Docid.get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
  }
}
