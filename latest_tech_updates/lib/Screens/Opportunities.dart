import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:latest_tech_updates/detailPages/OpportunityDetail.dart';

class Opportunity extends StatefulWidget {
  @override
  _OpportunityState createState() => _OpportunityState();
}

class _OpportunityState extends State<Opportunity> {
  @override
  void initState() {
    getData();
    _myData = getData();
    super.initState();
  }

  Future _myData;

  Future getData() async {
    QuerySnapshot qn = await Firestore.instance
        .collection("ML")
        .orderBy('datetime', descending: true)
        .getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot ml) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => mlDetail(
                  ml: ml,
                )));
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));

    setState(() {
      getData();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Opportunities',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: this._myData,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text('Loading...'));
                } else {
                  return RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 15),
                            child: Text(
                              'Welcome,',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 38),
                          child: Text(
                            'Here are your Updates',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () =>
                                      navigateToDetail(snapshot.data[index]),
                                  child: Container(
                                    height: 330,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 10),
                                          child: Container(
                                            height: 220,
                                            width: 320,
                                            decoration:
                                                BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[100],
                                                  blurRadius: 8,
                                                  spreadRadius: 5,
                                                  offset: Offset(-3, 3))
                                            ]),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                snapshot.data[index]
                                                            .data['image1'] !=
                                                        null
                                                    ? snapshot.data[index]
                                                        .data['image1']
                                                    : 'https://abc.com',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 25, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    snapshot.data[index]
                                                        .data["technology"],
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.6)),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 10,
                                              top: 8,
                                              bottom: 5),
                                          child: snapshot.data[index]
                                                      .data['title'] !=
                                                  null
                                              ? Text(
                                                  snapshot.data[index]
                                                      .data['title'],
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )
                                              : Text('Latest Update',
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
