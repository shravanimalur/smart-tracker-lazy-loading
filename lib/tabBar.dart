import 'package:flutter/material.dart';
import 'lazyloading.dart';
import 'main.dart';
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
