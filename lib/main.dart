import 'package:flutter/material.dart';
import 'package:piwc/pages/homepage.dart';
import 'package:piwc/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piwc/pages/registration.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:piwc/pages/generateqr.dart';

import 'model/Users.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Users>(
      create: (context) => Users(),
    ),






  ],child:MyApp()));

  await Firebase.initializeApp();
}
DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference Doctor = FirebaseDatabase.instance.ref().child("Admin");
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PIWC',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const login(),

        initialRoute: FirebaseAuth.instance.currentUser == null
            ? login.idScreen
            : homepage.idScreen,
        // : Doctorspage.idScreen,

        routes: {
          login.idScreen: (context) => login(),
          "/generateqr":(context)=>AttendanceQRCodeScreen(),
          homepage.idScreen:(context)=> homepage(),
         registration.idScreen: (context) => registration(),

        }
    );
  }
}



