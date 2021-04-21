import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app3/forgotpassword.dart';
import 'package:flutter_app3/signup.dart';
import 'package:flutter_app3/main.dart';
//import 'package:smart_tracker/tickets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;

//const SERVER_IP = '65.1.98.12:5000';
String _host = InternetAddress.loopbackIPv4.host;
final storage = FlutterSecureStorage();
void main() {
  runApp(MaterialApp(home: Login()));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.45,
                child: Image.asset(
                  'assets/play.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Phone',
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Forgot Password',
                          style: TextStyle(color: Color(0xffEE7B23)),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () async {
                        var username = _usernameController.text;
                        var password = _passwordController.text;

                        var jwt = await attemptLogIn(username, password);
                        if (jwt != null) {
                          //storage.write(key: "jwt", value: jwt);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AfterSplash()));
                        } else {
                          displayDialog(context, "An Error Occurred", jwt);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text.rich(
                  TextSpan(text: 'Don\'t have an account? ', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(color: Color(0xffEE7B23)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
  Future<String> attemptLogIn(String username, String password) async {
    print("username:");
    print(username);
    print("password:");
    print(password);
    print("attempting to connect to server……");
    //var uri = Uri.http("$SERVER_IP", '/st/login');
    //print("connection established.");
    //print(uri);
    final msg = jsonEncode({"emailmobile": username, "password": password});

    var res = await http.post('http://65.1.98.12:5000/fw/login',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: msg);
    print(msg);
    Map<String, dynamic> user = jsonDecode(res.body);
    print(user);
    if (user["status"] == "success") return user["status"];

    return null;
  }

  String jsonEncode(Object object, {Object toEncodable(Object nonEncodable)}) =>
      json.encode(object, toEncodable: toEncodable);
}

dynamic jsonDecode(String source, {Object reviver(Object key, Object value)}) =>
    json.decode(source, reviver: reviver);
