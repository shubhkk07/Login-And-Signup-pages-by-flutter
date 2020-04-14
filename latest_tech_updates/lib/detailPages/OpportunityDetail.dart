import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latest_tech_updates/Screens/Opportunities.dart';

class mlDetail extends StatelessWidget {
  final DocumentSnapshot ml;

  mlDetail({this.ml});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         Padding(
           padding: const EdgeInsets.only(top: 25),
           child: Container(
              height: 285,
              width: 400,

              child: ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Image(image: NetworkImage('${ml['image1']}'),
                fit: BoxFit.fill,),
              )),
         ),
         Container(
          child: Column(

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10.0,left: 15),
                child: Text(
                  '${ml['title']}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 15),
                child: Text('${ml['long_d']}',textAlign: TextAlign.left,),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
