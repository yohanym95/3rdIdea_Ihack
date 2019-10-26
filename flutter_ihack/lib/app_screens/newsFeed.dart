import 'package:flutter/material.dart';

class NewsFeed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsFeedState();
  }

}

class NewsFeedState extends State<NewsFeed>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("EDWN"),
      ),
    );
  }

}