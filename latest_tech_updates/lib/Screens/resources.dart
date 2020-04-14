import 'package:flutter/material.dart';

class Resources extends StatefulWidget {
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> with AutomaticKeepAliveClientMixin<Resources> {
  @override
  bool get wantKeepAlive=> true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
    );
  }
}
