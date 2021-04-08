import 'package:flutter/material.dart';

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
            //   onTap: (){
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => chat()));
            //   },
             ),
            ListTile(
              title: Text("Team 2",
                  style: TextStyle(fontSize: 20,)),
              // onTap: (){
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => teams()));
              // },
            ),
            ListTile(
              title: Text("Team 3",
                  style: TextStyle(fontSize: 20,)),
              // onTap: (){
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => teams()));
              // },
            ),
          ],
        )
    );
  }
}
