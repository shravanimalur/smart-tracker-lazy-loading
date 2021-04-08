import 'package:flutter/material.dart';
import 'package:flutter_app3/main.dart';
import 'package:flutter_app3/teams.dart';
import 'lazyloading.dart';
import 'myTicket.dart';
import 'searchTicket.dart';

class tabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            children: [
              teams(),
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
    );
  }
}
