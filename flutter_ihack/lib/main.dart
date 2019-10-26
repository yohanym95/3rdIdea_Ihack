import 'package:flutter/material.dart';
import 'package:flutter_ihack/app_screens/login.dart';
import 'package:flutter_ihack/app_screens/newsFeed.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future<void> main() async {
  //using shared preferences for login 
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





