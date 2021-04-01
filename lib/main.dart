import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'details.dart';
import 'package:flutter/cupertino.dart';

//var mainColor = Color(0xff1B3954);
//var accentColor = Color(0xff16ADE1);
//var whiteText = Color(0xffF5F5F5);

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
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      Expanded(child: LazyLoading()),
                      Container(
                        padding: EdgeInsets.all(16),
                        //child: buildButton(),
                      ),
                    ],
                  ),
                  //getListView(),
                  SearchState(),
                  MyTickets(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}

// Widget buildButton() => ElevatedButton(
//   child: Text("Show More"),
//   onPressed: (){},
// );

List<String> getListElements(){
  var items = List<String>.generate(5, (counter) => "Ticket ${counter+1}");
  return items;
}

// Widget getListView(){
//   var listItems = getListElements();
//
//   var listView = ListView.builder(
//       //itemExtent: 60,
//
//       itemBuilder: (context, index){
//
//         return ListTile(
//
//             leading: Icon(Icons.arrow_right),
//             title: Text(listItems[index],
//               style: TextStyle(fontSize: 22.0),),
//             trailing: Text("abc"),
//             onTap: (){
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DetailsPage(index)));
//             }
//         );
//       }
//   );
//   return listView;
// }

class LazyLoading extends StatefulWidget {
  @override
  _LazyLoadingState createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> {

  ScrollController _scrollController = ScrollController();
  int _currentMax=10;
  List items;

  void initState(){
    super.initState();
    items = List.generate(10, (counter) => "Ticket $counter");

    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        _getMoreData();
      }
    });
  }

  _getMoreData(){
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
          itemExtent: 80,
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
}

class SearchState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            forceElevated: true,
            elevation: 4,
            floating: true,
            snap: true,
            title: Text(
              "Search Ticket",
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      //drawer: Drawer(),
    );
  }
}
class CustomSearchDelegate extends SearchDelegate {
  var listItems = getListElements();
  final recent = ["Ticket 0","Ticket 1","Ticket 2","Ticket 3"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    listItems.clear();
    listItems =
        listItems.where((p) => p.startsWith(query)).toList();
    return Container(
      child: Center(
          child: Text(
            'The details page #$query',
            style: TextStyle(fontSize: 32.0),
          )
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    final suggestionList = query.isEmpty
        ? recent
        : listItems.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // if (query.isEmpty) {
          //   query = recent[index];
          // }
          showResults(context);
        },
        leading: Icon(query.isEmpty ? Icons.history : Icons.search),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey),
                  )
                ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}

class MyTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        // backgroundColor: Colors.lightGreen,
        closeManually: true,
        animatedIcon: AnimatedIcons.menu_close,
        onOpen: () => print("Opening"),
        onClose: () => print("Closing"),
        children: [
          SpeedDialChild(
              child: Icon(Icons.camera),
              label: "Camera",
              onTap: () => print("Camera")
          ),
          SpeedDialChild(
              child: Icon(Icons.image),
              label: "Gallery",
              onTap: () => print("Gallery")
          ),
        ],
      ),
    );
  }
}

