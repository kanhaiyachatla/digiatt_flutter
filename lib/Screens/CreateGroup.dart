import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
              child: CircleAvatar(
                radius: 70,
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Form(
              child: Container(
                margin: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                      focusColor: Theme.of(context).colorScheme.primary,
                      hintStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(),
                      labelText: 'Class Name',
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusColor: Theme.of(context).colorScheme.primary,
                        hintStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: size.width,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Create Class',)))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
