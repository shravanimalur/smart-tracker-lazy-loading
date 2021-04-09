import 'package:flutter/material.dart';
import 'package:flutter_app3/chatScreen.dart';

class  teams extends StatelessWidget {
  // final int index;
  // teams(this.index);
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
}
