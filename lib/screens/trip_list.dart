import 'package:flutter/material.dart';
import 'package:tinsas_app/screens/trip_details.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tinsas_app/models/trip.dart';
import 'package:tinsas_app/utils/database_helper.dart';

class TripList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripListState();
  }
}

class TripListState extends State<TripList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Trip> tripList;
  int count = 0;

  get position {
    var s = '';
    return s;
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Trip>> tripListFuture = databaseHelper.getTripList();
      tripListFuture.then((tripList) {
        setState(() {
          this.tripList = tripList;
          this.count = tripList.length;
        });
      });
    });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.blue;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.red;
        break;
      case 4:
        return Colors.green;
        break;

      default:
        return Colors.yellow;
    }
  }

  void navigateNext(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TripDetails(title);
    }));

    // if (result == true) {
    //   updateListView();
    // }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, Trip trip) async {
    int result = await databaseHelper.deleteTrip(trip.id);
    if (result != 0) {
      _showSnackBar(context, 'Trip Deleted Successfully');
      updateListView();
    }
  }

  ListView getTripList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.blue,
            elevation: 4.0,
            child: Container(
                child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                      child: Text(this.tripList[position].departure,
                          style: TextStyle(fontSize: 24.0))),
                  Expanded(
                    child: Icon(Icons.airplanemode_active),
                    // color: Colors.white,
                  ),
                  Expanded(
                      child: Text(this.tripList[position].destination,
                          style: TextStyle(fontSize: 24.0)))
                ]),
                Row(children: <Widget>[
                  Expanded(
                      child: Text(
                    this.tripList[position].departdate,
                  )),
                  Expanded(
                      child: Text(
                    this.tripList[position].arrivetime,
                  ))
                ]),
                Row(children: <Widget>[
                  Expanded(
                      child: Text(
                    this.tripList[position].departtime,
                  )),
                  Expanded(
                      child: Text(
                    this.tripList[position].arrivetime,
                  ))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      '',
                      // getPriorityText(this.tripList[position].priority),
                      style: TextStyle(
                          backgroundColor: getPriorityColor(
                              this.tripList[position].priority)),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      _showMyDialog();
                    },
                  ))
                ])
              ],
            )),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                new GestureDetector(
                  onTap: () {
                    navigateNext('Edit Trip');
                  },
                  child: new Text("Update"),
                ),
                new GestureDetector(
                  onTap: () {
                  _delete(context, tripList[position]);
                  },
                  child: new Text("Delete"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tripList == null) {
      tripList = List<Trip>();
    }
    updateListView();

    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 50.0, 20, 0),
          child: Column(children: <Widget>[
            Container(
                child: Row(children: <Widget>[
              Expanded(
                  child: Text(
                'Hello, Arthur',
                style: TextStyle(fontSize: 20.0),
              )),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,),
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Text(
                '20 trips',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  
                ),
              ))))
            ])),
            Container(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 200.0,
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                      child: Text(
                        'Create your trips with us',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.w800),
                      ),
                    ))),
            Container(
              height: 200.0,
              color: Colors.blue,
              child: getTripList(),
            )
          ])),
      // Container(child: getTripList())

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('This was clicked');
          navigateNext('Create Trip');
        },
        tooltip: "Add Trip",
        child: Icon(Icons.add),
      ),
    );
  }

  // import 'package:sqflite/sqflite.dart';
// Returns the priority color

  // Returns the priority text
  // Text getPriorityText(int priority) {
  //   switch (priority) {
  //     case 1:
  //       return Text('business');
  //       break;
  //     case 2:
  //       return Text('vacation');
  //       break;
  //     case 3:
  //       return Text('holiday');
  //       break;
  //     case 4:
  //       return Text('education');
  //       break;
  //     default:
  //       return Text('business');
  //   }
  // }

}
