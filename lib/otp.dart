import 'package:flutter/material.dart';
import 'package:flutter_app3/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

class Otp extends StatefulWidget {
  @override
  String name;
  String password;
  String emailPhone;
  Otp(this.name, this.emailPhone, this.password);
  _OtpState createState() =>
      _OtpState(this.name, this.emailPhone, this.password);
}

class _OtpState extends State<Otp> {
  @override
  String name;
  String password;
  String emailPhone;
  _OtpState(this.name, this.emailPhone, this.password);

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final TextEditingController _otpController = TextEditingController();
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
                      'OTP has been sent to $emailPhone',
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
                controller: _otpController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'OTP',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text('Enter OTP'),
                      color: Color(0xffEE7B23),
                      onPressed: () async {
                        var otp = _otpController.text;
                        var jwt = await attemptSignUp(
                            name, password, emailPhone, otp);
                        if (jwt != null) {
                          //storage.write(key: "jwt", value: jwt);
                          if (jwt == "success")
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          else
                            displayDialog(context, "Invalid OTP", null);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Otp(name, emailPhone, password)));
                        } else {
                          displayDialog(context, "An Error Occurred", jwt);
                        }
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

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

// url: fw/signup;
  Future<String> attemptSignUp(
      String name, String password, String emailPhone, String otp) async {
    print("name:");
    print(name);
    print("password:");
    print(password);
    print("otp:");
    print(otp);
    print("attempting to connect to server……");
    //var uri = Uri.http("$SERVER_IP", '/st/login');
    //print("connection established.");
    //print(uri);
    final msg = jsonEncode({
      "name": name,
      "emailmobile": emailPhone,
      "password": password,
      "otp": otp
    });

    var res = await http.post('http://65.1.98.12:5000/fw/signup',
    headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    },
    body: msg);
    print(msg);
    Map<String, dynamic> user = jsonDecode(res.body);
    print(user);
    //if (user["status"] == "success")
    return user["status"];

    // return null;
  }

  String jsonEncode(Object object, {Object toEncodable(Object nonEncodable)}) =>
      json.encode(object, toEncodable: toEncodable);
}

dynamic jsonDecode(String source, {Object reviver(Object key, Object value)}) =>
    json.decode(source, reviver: reviver);