import 'dart:convert';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_ihack/app_screens/newsFeed.dart';
import 'package:flutter_ihack/app_screens/signup.dart';
import 'package:flutter_ihack/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  // using Post request to login with node
  Future<User> createUser(String url, String email, String password) {
    var body1 = {"email": email, "password": password};
    final header = {'Content-Type': 'application/json'};

    final encoding = Encoding.getByName('utf-8');
    return http
        .post(url,
            headers: header, body: json.encode(body1), encoding: encoding)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fecthing data");
      }
      return User.fromJson(json.decode(response.body));
    });
  }

  static final CREATE_POST_URL = 'http://192.168.137.130:3000/api/user/login';

  var _formKey = GlobalKey<FormState>();
  double _minimumPadding = 5.0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          textDirection: TextDirection.ltr,
        ),
        backgroundColor: Colors.purple,
      ),
      body: signUpForm(),
    );
  }

  Widget signUpForm() {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Container(
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
              right: _minimumPadding * 3,
              left: _minimumPadding * 3,
              top: _minimumPadding * 5),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                    top: _minimumPadding,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 300,
                    color: Colors.purple[600],
                  )),

              //E mail
              Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding),
                child: TextFormField(
                  controller: emailController,
                  validator: validateEmail1,
                  keyboardType: TextInputType.emailAddress,
                  style: textStyle,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    labelStyle: Theme.of(context).textTheme.body1,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    hintText: "Johnperera@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              //Password
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  controller: passwordController,
                  validator: validatePassworrd1,
                  keyboardType: TextInputType.visiblePassword,
                  style: textStyle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: "Password",
                    labelStyle: Theme.of(context).textTheme.body1,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  obscureText: true,
                ),
              ),

              //forgot password
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: GestureDetector(
                    child: Text(
                      "Forgot your Password?",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  )),

              RaisedButton(
                child: Text(
                  'Login',
                  textScaleFactor: 1.2,
                ),
                textColor: Colors.white,
                color: Color(0xFF9400D3),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                  
                    // encrypt password
                  final key = Key.fromUtf8('my 32 length key................');
                  final iv = IV.fromLength(16);
                  final encrypter = Encrypter(AES(key));
                  final encrypted = encrypter.encrypt(passwordController.text, iv: iv);

                    //get repsonse from login
                    User user = await createUser(CREATE_POST_URL,
                        emailController.text, encrypted.base64);
                    print(user.msg);
                    if (user.msg == "true") {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', emailController.text);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => NewsFeed()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      _showMaterialDialog(user.msg);
                    }
                  }
                },
              ),
              //link to signup
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "New Here ? ",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show dialog after invalid login
  void _showMaterialDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  //email validation
  String validateEmail1(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  //password validation
  String validatePassworrd1(String value) {
    if (value.isEmpty) {
      return "Enter Your Password";
    }
    return null;
  }
}
