import 'dart:convert';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_ihack/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  // using Post request to signup with node
  Future<User> createUser(
      final String url,
      final String first,
      final String last,
      final String email,
      final String passwrod,
      final String pnumber) async {
    var body1 = {
      "fname": first,
      "lname": last,
      "email": email,
      "password": passwrod,
      "phnumber": pnumber
    };
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

  var _formKey = GlobalKey<FormState>();
  double _minimumPadding = 5.0;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String CREATE_POST_URL = 'http://192.168.1.102:3000/api/user/register';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          textDirection: TextDirection.ltr,
        ),
      ),
      body: signUpForm(),
    );
  }

  Widget signUpForm() {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(_minimumPadding * 3),
        child: ListView(
          children: <Widget>[
            //First Name
            nameFieldSet(firstNameController, 'Enter the First Name',
                'First Name', 'John'),

            // Last Name
            nameFieldSet(lastNameController, 'Enter the Last Name', 'Last Name',
                'Perera'),
            //E mail
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                controller: emailController,
                validator: validateEmail,
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

            //Phone Number
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                controller: phoneNumberController,
                validator: validateMobile,
                keyboardType: TextInputType.phone,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone_iphone),
                  labelStyle: Theme.of(context).textTheme.body1,
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15.0,
                  ),
                  hintText: "0123456789",
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
                validator: validatePassworrd,
                keyboardType: TextInputType.text,
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

            //submit
            RaisedButton(
              child: Text(
                'SignUp',
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
                  //get response from signup(node backend)
                  User user = await createUser(
                      CREATE_POST_URL,
                      firstNameController.text,
                      lastNameController.text,
                      emailController.text,
                      encrypted.base64,
                      phoneNumberController.text);
                  

                  _showMaterialDialog(user.msg);

                  //clear textfield after signup
                  firstNameController.clear();
                  lastNameController.clear();
                  emailController.clear();
                  passwordController.clear();
                  phoneNumberController.clear();
                  passwordController.clear();

                  print(user.msg);
                }
              },
            )
          ],
        ),
      ),
    );
  }

//show dialog after regsitration
  void _showMaterialDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration'),
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

  Widget nameFieldSet(
      TextEditingController txtController, String retEmpty, String lblText,
      [String hintTxt]) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Padding(
      padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
      child: TextFormField(
        controller: txtController,
        validator: (String value) {
          if (value.isEmpty) {
            return retEmpty;
          }
          return null;
        },
        keyboardType: TextInputType.text,
        style: textStyle,
        decoration: InputDecoration(
          labelText: lblText,
          prefixIcon: Icon(Icons.account_circle),
          labelStyle: Theme.of(context).textTheme.body1,
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontSize: 15.0,
          ),
          hintText: hintTxt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}

//validate email
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter Valid Email';
  }
  return null;
}

//validate password
String validatePassworrd(String value) {
  if (value.isEmpty) {
    return "Enter Your Password";
  }
  return null;
}

//validate mobile number
String validateMobile(String value) {
  if (value.length != 10) {
    return 'Mobile Number must be of 10 digit';
  } else if (value.isEmpty) {
    return "Enter Your Phone Number";
  }
  return null;
}
