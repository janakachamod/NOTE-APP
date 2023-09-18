import 'package:crudstore/screens/Authenication/signup_page.dart';
import 'package:crudstore/screens/Home/home.dart';
import 'package:crudstore/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterApp',
        theme: ThemeData(brightness: Brightness.dark),
        home: StreamBuilder(
          stream: AuthServices().firebaseAuth.authStateChanges(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Home(snapshot.data);
            } else {
              return Register();
            }
          },
        ));
  }
}
