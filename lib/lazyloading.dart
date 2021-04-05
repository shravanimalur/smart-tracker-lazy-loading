import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'details.dart';

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
}