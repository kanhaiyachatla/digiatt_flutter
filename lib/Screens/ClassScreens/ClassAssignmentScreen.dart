import 'package:flutter/material.dart';

import '../../methods/CLassModel.dart';

class ClassAssignmentScreen extends StatefulWidget {
  ClassModel classModel;
  ClassAssignmentScreen({Key? key,required this.classModel}) : super(key: key);

  @override
  State<ClassAssignmentScreen> createState() => _ClassAssignmentScreenState(classModel);
}

class _ClassAssignmentScreenState extends State<ClassAssignmentScreen> {
  var classModel;

  _ClassAssignmentScreenState(this.classModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Assignments'),
    );
  }
}
