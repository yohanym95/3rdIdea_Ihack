import 'package:flutter/material.dart';
import 'package:flutter_ihack/app_screens/login.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsFeedState();
  }
}

//const String URI = "http://192.168.137.120:3000/";

class NewsFeedState extends State<NewsFeed> {
  // Future<List<Item>> fetchItem() async {
  //   final response =
  //       await http.get('http://192.168.8.101/flutterphp/v/getItem.php');

  //   if (response.statusCode == 200) {
  //     List itemss = json.decode(response.body);
  //     List<Item> i = itemss.map((item) => new Item.fromJson(item)).toList();
  //     return i;
  //     // return Item.fromJson(itemss[0]);
  //   } else {
  //     throw Exception('Failed to load Users');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //news feed tab bar
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    tooltip: "Logout",
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      //Remove String
                      prefs.remove("email");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
                backgroundColor: Colors.purple,
                bottom: TabBar(
                  indicatorColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(
                      text: "Recent",
                      
                    ),
                    Tab(
                      text: "All",
                    ),
                  ],
                ),
                title: Text("EDWN",),
              ),
              body: TabBarView(
                children: [
                  list(),
                  allPost(),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.live_help),
                tooltip: "Help",
                onPressed: (){

                },
              ),
            )
            ));
  }

  //recent post ui
  Widget recent() {
    return Container(
      
      child: ListView(
        children: <Widget>[
          Card(
            
            child: ListTile(
              title: Text(
                "Land Slide",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.red),
              ),
              leading: Icon(
                Icons.landscape,
                color: Colors.red,
              ),
              subtitle: Text("Landscape Early morning .. [details]"),
            ),
          )
        ],
      ),
    );
  }

  // all post ui
  Widget allPost(){
    return ListView.builder(
      
      itemCount: 1,
      itemBuilder: (context,snapshot){
        return Card(
          margin: EdgeInsets.all(10),
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.landscape,size: 50,),
                    SizedBox(width: 12,),
                    Text("Land Slide",style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                    SizedBox(width: 70,),
                    RaisedButton(
                      child: Text("Help Me"),
                      onPressed: (){
                        print("Help Me");
                      },
                      color: Colors.yellow,
                    )
                    
                    
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text("Date",style: TextStyle(fontSize: 18),),
                    SizedBox(width:25.0),
                    Text("2019/07/08",style: TextStyle(fontSize: 18),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text("Area",style: TextStyle(fontSize: 18)),
                    SizedBox(width: 25.0,),
                    Text("Ratmalana Area, Kalutara Area",style: TextStyle(fontSize: 18))
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text("Guides",style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10,),
                    Text("There are some rescue places",style: TextStyle(fontSize: 18))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget list(){
    return ListView.builder(
      
      itemCount: 1,
      itemBuilder: (context,snapshot){
        return Card(
          margin: EdgeInsets.all(10),
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.landscape,size: 50,),
                    SizedBox(width: 12,),
                    Text("Land Slide",style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                    RaisedButton(
                      child: Text("Help Me"),
                      onPressed: (){
                        print("Help Me");
                      },
                      color: Colors.yellow,
                    )+
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text("Date",style: TextStyle(fontSize: 18),),
                    SizedBox(width:25.0),
                    Text("2019/07/08",style: TextStyle(fontSize: 18),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text("Area",style: TextStyle(fontSize: 18)),
                    SizedBox(width: 25.0,),
                    Text("Ratmalana Area, Kalutara Area",style: TextStyle(fontSize: 18))
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text("Guides",style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10,),
                    Text("There are some rescue places",style: TextStyle(fontSize: 18))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
