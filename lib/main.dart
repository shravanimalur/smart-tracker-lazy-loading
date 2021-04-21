import 'package:flutter/material.dart';
import 'package:flutter_app3/tabBar.dart';
import 'package:flutter_app3/teams.dart';
import 'package:flutter_app3/login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 10),
        () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=>Login(),
          )
        );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(child: Image.asset('assets/both.png',)),
      body: Column(
        children: [
          Spacer(),
          Image.asset('assets/st_logo.png'),
          Spacer(),
          //Spacer(),
          Text("BY",style: TextStyle(fontSize: 20.0),),
          Image.asset('assets/Ivis Labs.png', width: 150, height: 150,)
        ],
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exploring UI",
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: Drawer(
            //child: DrawerItems(),
          ),
          appBar: AppBar(
            title: Text("SMART TRACKER"),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.group),text: "My Teams",),
              Tab(icon: Icon(Icons.home),text: "Tickets",),
              Tab(icon: Icon(Icons.search),text: "Search Tickets",),
              Tab(icon: Icon(Icons.favorite),text: "My Tickets",),
            ]),
          ),
          // body: Column(
          //   children: [
          //     tabBar(),
          //     buildButton()
          //   ],
          body: tabBar(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

Widget buildButton() => ElevatedButton(
  child: Text("Button"),
  onPressed: (){},
);


class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final drawerHeader = DrawerHeader(
    //   child: Center(child: Text('Chat Application',
    //     style: TextStyle(
    //       fontSize: 27,),)),
    //   decoration: BoxDecoration(
    //     color: Colors.blue,
    //   ),
    // );

    return ListView(
      children: [
        //drawerHeader,
        ListTile(
          title: Text("Chat Application",
              style: TextStyle(fontSize: 20,)),

          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => teams()));
          },
        ),
      ],
    );
  }
}


