import 'package:flutter/material.dart';

class BodyClassHomeScreen extends StatefulWidget {
  const BodyClassHomeScreen({Key? key}) : super(key: key);

  @override
  State<BodyClassHomeScreen> createState() => _BodyClassHomeScreenState();
}

class _BodyClassHomeScreenState extends State<BodyClassHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home'),
    );
  }
}
