import 'package:flutter/material.dart';
import 'package:flutter_app3/newMyticket.dart';

class MyTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("My Tickets", style: TextStyle(fontSize: 22.0),),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.menu),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => newMyTicket()));
          }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}

// class Button extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.menu),
//           onPressed: (){
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => newMyTicket()));
//           }
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//
//     );
//   }
// }