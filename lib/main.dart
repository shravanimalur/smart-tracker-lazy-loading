import 'package:flutter/material.dart';
import 'package:flutter_app3/tabBar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(MaterialApp(
    title: "Exploring UI",
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text("SMART TRACKER"),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.home),text: "Tickets",),
            Tab(icon: Icon(Icons.search),text: "Search Tickets",),
            Tab(icon: Icon(Icons.favorite),text: "My Tickets",),
          ]),
        ),
        body: tabBar(),
        // floatingActionButton: SpeedDial(
        //   // backgroundColor: Colors.lightGreen,
        //   closeManually: true,
        //   animatedIcon: AnimatedIcons.menu_close,
        //   onOpen: () => print("Opening"),
        //   onClose: () => print("Closing"),
        //   children: [
        //     SpeedDialChild(
        //         child: Icon(Icons.camera),
        //         label: "Camera",
        //         onTap: () => print("Camera")
        //     ),
        //     SpeedDialChild(
        //         child: Icon(Icons.image),
        //         label: "Gallery",
        //         onTap: () => print("Gallery")
        //     ),
        //   ],
        // ),
      ),
    ),
  ));
}
