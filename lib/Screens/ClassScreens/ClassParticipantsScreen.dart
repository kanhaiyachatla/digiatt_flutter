import 'package:flutter/material.dart';

class ClassParticipantsScreen extends StatefulWidget {
  const ClassParticipantsScreen({Key? key}) : super(key: key);

  @override
  State<ClassParticipantsScreen> createState() => _ClassParticipantsScreenState();
}

class _ClassParticipantsScreenState extends State<ClassParticipantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Participants'),
    );
  }
}
