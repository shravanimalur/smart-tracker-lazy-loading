import 'package:flutter/material.dart';

List<String> getListElements(){
  var items = List<String>.generate(5, (counter) => "Ticket ${counter+1}");
  return items;
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