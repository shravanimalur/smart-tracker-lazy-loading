import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app3/teams.dart';
import 'package:flutter_app3/login.dart';
import 'details.dart';
import 'dart:convert' show json, base64, ascii;
import 'package:http/http.dart' as http;

class LazyLoading extends StatefulWidget {
  @override
  _LazyLoadingState createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> {
  ScrollController _scrollController = ScrollController();
  int _currentMax=10;
  List items;

  void initState() {
    super.initState();
    // final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoxMSwiZXhwIjoxNjIwNDAwMTYwfQ.gvF3wyNpLGVUsEGuYVtjResllWlDIus7lz19dIwltAo';
    // var jwt = await getTickets(token);
    items = List.generate(10, (counter) => "Ticket $counter");

    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        _getMoreData();
      }
    });
  }
  _getMoreData() async{
    final abc = "ivis_token "+"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoxMSwiZXhwIjoxNjIwNDAzMDc3fQ.dXNUc77W0RoN-OsvtWc0K4Psoqw8uxxXoldeJuFo6C0";
    var jwt = await getTickets(abc);
    //var item = getListElements();
    print("get more");
    for(int i = _currentMax; i < _currentMax + 10; i++){
      items.add("Ticket $i");
    }

    _currentMax = _currentMax + 10;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    //var listItems = getListElements();
    var listView = ListView.builder(
        itemCount: items.length+1,//.compareTo(0),
        controller: _scrollController,
        itemExtent: 60,
        itemBuilder: (context, index){
          if(index == items.length){
            return CupertinoActivityIndicator();
          }
          return ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(items[index],
                style: TextStyle(fontSize: 22.0),),
              trailing: Text("abc"),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage(index)));
              }
          );
        }
    );
    return listView;
  }
  Future<String> getTickets(String abc) async {
    print("attempting to connect to server……");
    //var uri = Uri.http("$SERVER_IP", '/st/login');
    //print("connection established.");
    print(abc);
    final msg = jsonEncode({"Authorization": abc});

    var res = await http.post('https://backend.ivislabs.com/st/tickets',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'token'
        },
        );

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
