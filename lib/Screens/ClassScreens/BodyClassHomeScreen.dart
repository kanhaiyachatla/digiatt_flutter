import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digiatt/methods/CLassModel.dart';

import '../../methods/UserModel.dart';

class BodyClassHomeScreen extends StatefulWidget {
  ClassModel classModel;

  BodyClassHomeScreen({Key? key, required this.classModel}) : super(key: key);

  @override
  State<BodyClassHomeScreen> createState() =>
      _BodyClassHomeScreenState(classModel);
}

class _BodyClassHomeScreenState extends State<BodyClassHomeScreen> {
  var classModel;
  var user = FirebaseAuth.instance.currentUser!;
  final FormKey = GlobalKey<FormState>();

  final subLists = [
    'Computer Graphics',
    'Analysis of Algorithm',
    'Maths',
    'Operating Systems',
    'Microprocessor',
    'Python'
  ];
  DateTime Date = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  var initialvalue;

  _BodyClassHomeScreenState(this.classModel);
  @override
  Widget build(BuildContext context) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder<UserModel?>(
        future: ReadUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            snackbarKey.currentState
                ?.showSnackBar(SnackBar(content: Text('Something went wrong')));
          } else if (snapshot.hasData) {
            var usermodel = snapshot.data;

            return usermodel == null
                ? Center(
                    child: Text('No user'),
                  )
                : Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height *0.05,),
                        Form(
                          key: FormKey,
                          child: DropdownButtonFormField(
                            validator: (value) => (value == null) ? 'Please Select Subject' : null,
                            hint: Text('Select Subjects'),
                            isExpanded: true,
                            value: initialvalue,
                            items: subLists
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                initialvalue = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: size.height *0.05,),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Date : ${Date.day}/${Date.month}/${Date.year}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(),
                              IconButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: Date,
                                    firstDate: DateTime(1999),
                                    lastDate: DateTime(2300),
                                  );

                                  if (newDate == null) return;

                                  setState(() {
                                    Date = newDate;
                                  });
                                },
                                icon: Icon(Icons.date_range_rounded),
                              ),
                            ],
                          ),
                        SizedBox(height: size.height *0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Time : ${hour} : ${minute}",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            IconButton(
                              onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: time,
                                );
                                if (newTime == null) return;

                                setState(() {
                                  time = newTime;
                                });
                              },
                              icon: Icon(Icons.access_time),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height *0.1,),
                        ElevatedButton(
                            onPressed: () {
                              if(FormKey.currentState!.validate()){
                                snackbarKey.currentState!.showSnackBar(SnackBar(content: Text('works')));
                              }
                            },
                            child: usermodel.role == 'teacher'
                                ? Text('Take Attendance')
                                : Text('Give Attendance'))
                      ],
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
