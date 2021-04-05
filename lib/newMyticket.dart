import 'package:flutter/material.dart';

class  newMyTicket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket'),
      ),
       body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.create),
            title: Text("Create Ticket",
              style: TextStyle(fontSize: 22.0),),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.image_outlined),
            title: Text("Add Media",
              style: TextStyle(fontSize: 22.0),),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}