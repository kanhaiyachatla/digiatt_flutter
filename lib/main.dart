import 'package:digiatt/Screens/HomeScreen.dart';
import 'package:digiatt/Screens/LoginScreen.dart';
import 'package:digiatt/Screens/SignupScreen.dart';
import 'package:digiatt/Screens/SignupSelect.dart';
import 'package:digiatt/Screens/VerifyEmailScreen.dart';
import 'package:digiatt/methods/googlesigninprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final NavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create : (context) => GoogleSignInProvider(),
      child: MaterialApp(
        navigatorKey: NavigatorKey,
        scaffoldMessengerKey: snackbarKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF6450FF),
            secondary: const Color(0xFFFC79FC),

          ),

          // Define the default font family.

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            subtitle2: TextStyle(
                fontSize: 11,
                fontFamily: 'Inter',
                color: Colors.black,
                fontWeight: FontWeight.w600),
            headline2: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Colors.black,
                fontWeight: FontWeight.w600),
            headline4: TextStyle(
                fontSize: 56,
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.w600),
            headline3: TextStyle(
                fontSize: 17,
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return VerifyEmailScreen();
            }else{
              return SignupSelect();
            }
          },
        )


      ),
    );
  }
}
