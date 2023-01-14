import 'package:digiatt/Screens/HomeScreen.dart';
import 'package:digiatt/Screens/ForgotPasswordScreen.dart';
import 'package:digiatt/Screens/SignupSelect.dart';
import 'package:digiatt/Screens/VerifyEmailScreen.dart';
import 'package:digiatt/main.dart';
import 'package:digiatt/methods/googlesigninprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  var _email = TextEditingController();
  var _password = TextEditingController();
  bool isVisible = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
  }

  @override
  void initState() {
    isVisible = false;
  }

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
              Theme.of(context).colorScheme.secondary
            ],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height / 10,
              ),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: size.height / 10,
              ),
              Container(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 7, left: 10.0),
                              child: Text(
                                'Username',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              decoration: InputDecoration(
                                  focusColor:
                                      Theme.of(context).colorScheme.primary,
                                  hintText: 'Enter Email',
                                  prefixIcon: Icon(Icons.email_rounded),
                                  hintStyle: TextStyle(fontSize: 12)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 13, left: 10.0),
                              child: Text(
                                'Password',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            TextField(
                                controller: _password,
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  focusColor:
                                      Theme.of(context).colorScheme.primary,
                                  hintText: 'Enter your password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  hintStyle: TextStyle(fontSize: 12),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: Icon(!isVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // TODO Create password reset page
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(6),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),

                                  ),
                                  onPressed: () {
                                    Login(_email.text.trim(),
                                        _password.text.trim());
                                  },
                                  child: Text(
                                    'Login',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New User? ',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupSelect()));
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height / 70,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: size.height / 15,
              ),


            ],
          ),
        ),
      ),
    );
  }
  Future Login(String email, String password) async {
    showDialog(
        context: NavigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) => {
      Navigator.of(context).pop(),
        NavigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context)=> VerifyEmailScreen()))
      });
    } on FirebaseAuthException catch (e) {
      snackbarKey.currentState?.showSnackBar(SnackBar(content: Text(e.message!)));
      Navigator.of(context).pop();
    }

  }
}
