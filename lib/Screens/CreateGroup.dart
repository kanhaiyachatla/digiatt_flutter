import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiatt/main.dart';
import 'package:digiatt/methods/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? ImageFile;
  var cuser = FirebaseAuth.instance.currentUser!;
  final FormKey = GlobalKey<FormState>();
  var _name = TextEditingController();
  var _description = TextEditingController();
  var Urldownload;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Class',
          style: TextStyle(fontFamily: 'Inter'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      getImagefromGallery();
                    },
                    child: CircleAvatar(
                      radius: size.width * 0.20,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: ImageFile == null
                          ? null
                          : FileImage(File(ImageFile!.path)),
                      child: ImageFile == null
                          ? Icon(
                              Icons.add_photo_alternate_outlined,
                              size: size.width * 0.18,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: FormKey,
              child: Container(
                margin: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: _name,
                        validator: (value) => _name.text.isEmpty ? 'Enter Class Name' : null,
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.primary,
                          hintStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(),
                          labelText: 'Class Name',
                        ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _description,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusColor: Theme.of(context).colorScheme.primary,
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                        labelText: 'Description (optional)',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        width: size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              if (FormKey.currentState!.validate()) {
                                createClass(_name.text.trim(), _description.text.trim());
                              }
                            },
                            child: Text(
                              'Create Class',
                            )))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getImagefromGallery() async {
    ImageFile = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50);

    setState(() {
      ImageFile;
    });
  }

  createClass(String name, String description) async{
    await uploadFile();

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    final docRef = FirebaseFirestore.instance.collection('Classes').doc(id);

    docRef.set({
      'id' : id,
      'photourl' : Urldownload,
      'name' : name,
      'description' : description
    }).then((value) async{
      var snap = await FirebaseFirestore.instance.collection('Users').doc(cuser.uid).get();
      var map = snap.data()!;

      try {
        await FirebaseFirestore.instance.collection('Classes').doc(id).collection('members').doc(cuser.uid).set(map);
          var classSnap = await docRef.get();
          await FirebaseFirestore.instance.collection('Users').doc(cuser.uid).collection('inGroup').doc(id).set(classSnap.data()!);
          snackbarKey.currentState!.showSnackBar(SnackBar(content: Text('Group Created')));
          Navigator.of(context).pop();
          Navigator.of(context).pop();

      } on Exception catch (e) {
        snackbarKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString())));
      }
    });

  }
  uploadFile() async {
    showDialog(
        context: NavigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ));

    if(ImageFile == null){
     Urldownload = '';
    }else {
      final path = 'groupImages/${ImageFile!.name}';
      final file = File(ImageFile!.path);

      final ref = FirebaseStorage.instance.ref().child(path);

      UploadTask? uploadtask = ref.putFile(file);
      final snapshot = await uploadtask!.whenComplete(() => {});

      Urldownload = await snapshot.ref.getDownloadURL();
    }
  }
}


