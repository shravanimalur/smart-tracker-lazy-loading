import 'package:flutter/material.dart';
import 'package:flutter_app3/tabBar.dart';
import 'package:flutter_app3/teams.dart';
import 'package:splashscreen/splashscreen.dart';


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
  final img = Text("By");
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      // title: Text(
      //   'Smart Tracker',
      //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      // ),
      image: new Image.asset(
          'assets/snoo.png'),
      seconds: 8,
      navigateAfterSeconds: AfterSplash(),
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.black,
      photoSize: 200.0,
      loadingText: Text("BY IVIS LABS",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)
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
          body: tabBar(),
        ),
      ),
    );
  }
}


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


