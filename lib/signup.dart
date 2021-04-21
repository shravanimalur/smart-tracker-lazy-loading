import 'package:flutter/material.dart';
import 'package:flutter_app3/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

import 'package:flutter_app3/otp.dart';

class SignUp extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SIGN UP')),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    //labelText: '',
                    hintText: 'NAME',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (String name) {
                    Pattern pattern =
                        r'^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(name))
                      return 'Invalid name';
                    else
                      return null;
                  },
                ),
                TextFormField(
//                    keyboardType: TextInputType.emailAddress,
                    controller: _emailPhoneController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.contacts),

                      //labelText: 'EMAIL',
                      hintText: 'Phone / Email',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (String emailPhone) {
                      Pattern pattern =
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
                      RegExp regex = RegExp(pattern);
                      Pattern pattern2 = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//                          r'^.+(\.{0,1}[a-zA-Z]+)$';
                      RegExp regex2 = RegExp(pattern2);

                      if (regex.hasMatch(emailPhone) ||
                          regex2.hasMatch(emailPhone))
                        return null;
                      else
                        return 'INVALID EMAIL / MOBILE NUMBER';
                    }),
/*                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.call),
                    //labelText: 'PHONE',
                    hintText: '900000000',
                    prefixText: '+91',
                  ),
                  //textInputAction: TextInputAction.next,
                  validator: (String number) {
                    if (number.length != 10)
                      return 'Invalid mobile number';
                    else
                      return null;
                  },
                ),*/
                TextFormField(
                  controller: _passwordController,
                  // keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_open),
                    //labelText: 'Password',
                    hintText: 'P@ssword1',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (String password) {
                    Pattern pattern =
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%_*?&])[A-Za-z\d@$!%_*?&]{8,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(password))
                      return 'Must contain number, upper case and lower case and special characters';
                    else
                      return null;
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                    onPressed: () async {
                      var name = _nameController.text;
                      var password = _passwordController.text;
                      var emailPhone = _emailPhoneController.text;
                      var jwt = await attemptSignUp(name, emailPhone, password);
                      if (jwt != null) {
                      //storage.write(key: "jwt", value: jwt);
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>
                      Otp(name, emailPhone, password)));
                      } else {
                      displayDialog(context, "An Error Occurred", jwt);
                      }
                    },
                    child: Text('Submit')),
              ],
            ),
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

  Future<String> attemptSignUp(
      String name, String emailPhone, String password) async {
    print("name:");
    print(name);
    print("password:");
    print(password);
    print("attempting to connect to server……");
    //var uri = Uri.http("$SERVER_IP", '/st/login');
    //print("connection established.");
    //print(uri);
    final msg = jsonEncode(
        {"name": name, "emailmobile": emailPhone, "password": password});
    var res = await http.post('http://65.1.98.12:5000/fw/sendsignupotp',
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