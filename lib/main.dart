import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_project/forgot.dart';
import 'package:mad_project/homepage.dart';
import 'package:mad_project/login.dart';
import 'package:mad_project/signup.dart';
import 'package:mad_project/splashscreen.dart';
import 'package:mad_project/wrapper.dart';



void main() async{
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
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/wrapper': (context) => const Wrapper(),
        '/home': (context) =>  HomePage(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/forgot': (context) => const Forgot(),
        
        
      },
    );
  }
}
