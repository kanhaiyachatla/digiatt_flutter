import 'package:digiatt/Screens/SignupScreen.dart';
import 'package:flutter/material.dart';

class SignupSelect extends StatefulWidget {
  const SignupSelect({Key? key}) : super(key: key);

  @override
  State<SignupSelect> createState() => _SignupSelectState();
}

class _SignupSelectState extends State<SignupSelect> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          )),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 10,
              ),
              Text(
                'DigiAtt',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: size.height / 4,
              ),
              ElevatedButton(
                onPressed: () {
                  //TODO create a nagivator which passes data to signup screen
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 14.0, bottom: 14, left: 30, right: 30),
                  child: Text(
                    'I am a Teacher',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  side: BorderSide(color: Colors.white, width: 2),

                ),
              ),
              SizedBox(
                height: size.height / 35,
              ),
              ElevatedButton(
                  onPressed: () {
                    //TODO create a navigator which passes data to signup screen
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 14.0, bottom: 14, left: 30, right: 30),
                    child: Text(
                      'I am a Student',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: BorderSide(color: Colors.white, width: 2),

                  )),
            ],
          ),
        ),
      ),
    );
  }
}
