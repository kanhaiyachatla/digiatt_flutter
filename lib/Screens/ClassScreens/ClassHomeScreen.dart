import 'package:digiatt/methods/CLassModel.dart';
import 'package:flutter/material.dart';

class ClassHomeScreen extends StatefulWidget {

  ClassModel classData;
  ClassHomeScreen({Key? key,required this.classData}) : super(key: key);

  @override
  State<ClassHomeScreen> createState() => _ClassHomeScreenState(classData);
}

class _ClassHomeScreenState extends State<ClassHomeScreen> {

  var classData;

  _ClassHomeScreenState(
      this.classData
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classData.name),
      ),
      bottomNavigationBar: Bott,
    );
  }
}
