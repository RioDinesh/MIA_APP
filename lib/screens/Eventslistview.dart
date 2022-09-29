import 'package:flutter/material.dart';

class Eventslist_view extends StatefulWidget {
  

  @override
  _Eventslist_viewState createState() => _Eventslist_viewState();
}

class _Eventslist_viewState extends State<Eventslist_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Events",style: TextStyle(fontFamily: "Nunito-Regular",color: Colors.black),),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No events available",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}