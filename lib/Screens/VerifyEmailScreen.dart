import 'dart:async';

import 'package:digiatt/Screens/HomeScreen.dart';
import 'package:digiatt/Screens/LoginScreen.dart';
import 'package:digiatt/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResend = false;
  Timer? timer1,timer2;
  int Timeleft = 120;

  void starttimer() {
    timer2 =Timer.periodic(Duration(seconds: 1), (timer) {
      if(Timeleft>0){
        setState(() {
          Timeleft--;
        });
      }else{
        timer2?.cancel();
        canResend = true;
      }
    });
  }

  Future sendVerificationlink() async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      await user.sendEmailVerification().then((value) => {
        snackbarKey.currentState?.showSnackBar(SnackBar(content: Text('Verification mail sent')))
      });
      setState(() => canResend = false);
      Timeleft = 120;
      starttimer();
    } on FirebaseAuthException catch (e) {
      snackbarKey.currentState
          ?.showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer1?.cancel();
  }

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationlink();

      timer1 = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer1?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (isEmailVerified) {
      return HomeScreen();
    } else {
      return Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 5,
              ),
              Text(
                'Email verification',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: size.height / 7,
              ),
              Text(
                'An email verification link was sent to your inbox. \n Please verify to sign in',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, fontFamily: 'Inter', color: Colors.white),
              ),
                 Container(
                height: 45,
                margin: EdgeInsets.only(top: 30,left: 30,right: 30,bottom: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canResend ? sendVerificationlink : null,
                  child: Text(
                    'Send Link Again',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(width: 2, color: Colors.white)),
                ),
              ),
              Container( width: 300,child: TextButton(onPressed: () => FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()))), child: Text('Cancel',style: TextStyle(color: Colors.white, fontSize: 18,),))),
              SizedBox(height: size.height/15,),
              Text('Please wait to try again : '+ Timeleft.toString(), style: TextStyle(color: Colors.white,fontSize: 25),),
            ],
          ),
        ),
      );
    }
  }
}
