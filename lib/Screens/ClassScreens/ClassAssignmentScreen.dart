import 'package:flutter/material.dart';

class ClassAssignmentScreen extends StatefulWidget {
  const ClassAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<ClassAssignmentScreen> createState() => _ClassAssignmentScreenState();
}

class _ClassAssignmentScreenState extends State<ClassAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Assignments'),
    );
  }
}
