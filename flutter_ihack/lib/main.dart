import 'package:flutter/material.dart';
import 'package:flutter_ihack/app_screens/login.dart';
import 'package:flutter_ihack/app_screens/newsFeed.dart';
import 'package:shared_preferences/shared_preferences.dart';


//void main() => runApp(MyApp());

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'EDWS',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    home: email == null ? Login() : NewsFeed()));
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EDWS',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Login(),
    );
  }
}

