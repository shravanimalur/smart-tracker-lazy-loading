import 'package:flutter/material.dart';
import 'package:flutter_app3/chatScreen.dart';
import 'package:flutter_app3/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

class teams extends StatefulWidget {
  @override
  _teamsState createState() => _teamsState();
}

class _teamsState extends State<teams> {
  final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjo3LCJleHAiOjE2MTkwOTk2MTZ9.f0qWUWurV9uHbRUcrtT-_YxwJb36XmsBmZ--RNpoeOA";
  @override
  void initState() {
    super.initState();
    asyncMethod();
  }
  void asyncMethod() async {
    var jwt = await fetchTeams(token);
    print("jwt");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Chat Application'),
      // ),
        body: ListView(
          children: [
            ListTile(
              title: Text("Team 1",
                  style: TextStyle(fontSize: 20,)),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Team 1')));
              },
            ),
            ListTile(
              title: Text("Team 2",
                  style: TextStyle(fontSize: 20,)),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Team 2')));
              },
            ),
            ListTile(
              title: Text("Team 3",
                  style: TextStyle(fontSize: 20,)),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Team 3')));
              },
            ),
          ],
        )
    );
  }
  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
  Future<String> fetchTeams(String token) async {
    print("token:");
    print(token);
    print("attempting to connect to server……");
    //var uri = Uri.http("$SERVER_IP", '/st/login');
    //print("connection established.");
    //print(uri);
    final msg = jsonEncode({"ivis_token": token});

    var res = await http.post('http://65.1.98.12:5000/st/teams',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization':'ivis_token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoxMSwiZXhwIjoxNjIwNDAzMDc3fQ.dXNUc77W0RoN-OsvtWc0K4Psoqw8uxxXoldeJuFo6C0'
        }
        //body: msg
    );
    print(msg);
    Map<String, dynamic> user = jsonDecode(res.body);
    print(user);
    //print(user["data"]);
    if (user["status"] == "success") return user["status"];

    return null;
  }

  String jsonEncode(Object object, {Object toEncodable(Object nonEncodable)}) =>
      json.encode(object, toEncodable: toEncodable);
}

dynamic jsonDecode(String source, {Object reviver(Object key, Object value)}) =>
    json.decode(source, reviver: reviver);