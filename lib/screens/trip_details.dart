import 'package:flutter/material.dart';
import 'package:tinsas_app/models/trip.dart';
import 'package:tinsas_app/utils/database_helper.dart';

class TripDetails extends StatefulWidget {
  String appBarTitle;
  Trip trip;
  TripDetails(this.appBarTitle);
  @override
  _TripDetailsState createState() {
    return _TripDetailsState(this.appBarTitle);
  }
}

class _TripDetailsState extends State<TripDetails> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String appBarTitle;
  Trip trip;
  String result = '';
  final _priorities = ['Business', 'Education', 'Health', 'Vacation'];
  final double _formDistance = 5.0;
  String priority = 'Business';
  TextEditingController destinationController = TextEditingController();
  TextEditingController departureController = TextEditingController();
  TextEditingController arrivetimeController = TextEditingController();
  TextEditingController departtimeController = TextEditingController();
  TextEditingController arrivedateController = TextEditingController();
  TextEditingController departdateController = TextEditingController();

  _TripDetailsState(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    destinationController.text = trip.destination;
    departureController.text = trip.departure;
    arrivetimeController.text = trip.arrivetime;
    departtimeController.text = trip.departtime;
    arrivetimeController.text = trip.arrivedate;
    departdateController.text = trip.departdate;
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                    controller: departureController,
                    decoration: InputDecoration(
                      labelText: 'Enter Departure',
                      hintText: 'e.g Lagos',
                      labelStyle: textStyle,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      updateDeparture();
                    })),
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                          controller: departdateController,
                          decoration: InputDecoration(
                            labelText: 'Enter Date',
                            hintText: 'e.g Mon 23, April',
                            labelStyle: textStyle,
                          ),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            updateDepartDate();
                          })),
                  Container(width: _formDistance * 5),
                  Expanded(
                      child: TextField(
                          controller: departtimeController,
                          decoration: InputDecoration(
                            labelText: 'Enter Time',
                            hintText: 'e.g 12:00',
                            labelStyle: textStyle,
                          ),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            updateDepartTime();
                          })),
                ])),
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                    controller: destinationController,
                    decoration: InputDecoration(
                      labelText: 'Enter Destination',
                      hintText: 'e.g Lagos',
                      labelStyle: textStyle,
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      updateDestination();
                    })),
            Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                          controller: arrivedateController,
                          decoration: InputDecoration(
                            labelText: 'Enter Date',
                            hintText: 'e.g Mon 23, April',
                            labelStyle: textStyle,
                          ),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            updateArriveDate();
                          })),
                  Container(width: _formDistance * 5),
                  Expanded(
                      child: TextField(
                          controller: arrivetimeController,
                          decoration: InputDecoration(
                            labelText: 'Enter Time',
                            hintText: 'e.g 12:00',
                            labelStyle: textStyle,
                          ),
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            updateArrriveTime();
                          })),
                ])),
            Container(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                width: 500,
                child: DropdownButton<String>(
                    items: _priorities.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: getPriorityAsString(trip.priority),
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                        updatePriorityAsInt(valueSelectedByUser);
                      });
                    })),
            Container(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                width: 500,
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    _save();
                  },
                  child: Text(
                    'Add Trip',
                    textScaleFactor: 1.5,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // void _onDropdownChanged(String value) {
  //   setState(() {
  //     this._priority = value;
  //   });
  // }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Business':
        trip.priority = 1;
        break;
      case 'Education':
        trip.priority = 2;
        break;
      case 'Health':
        trip.priority = 3;
        break;
      case 'Vacation':
        trip.priority = 4;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; 
        break;
      case 2:
        priority = _priorities[1]; 
        break;
      case 3:
        priority = _priorities[2]; 
        break;
      case 4:
        priority = _priorities[4];
        break;
    }
    return priority;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of Note object
  void updateDestination() {
    trip.destination = destinationController.text;
  }

  // Update the description of Note object
  void updateDeparture() {
    trip.departure = departureController.text;
  }

  void updateArrriveTime() {
    trip.arriveTime = arrivetimeController.text;
  }

  void updateDepartTime() {
    trip.departTime = departtimeController.text;
  }

  void updateArriveDate() {
    trip.arriveDate = arrivedateController.text;
  }

  void updateDepartDate() {
    trip.departDate = departdateController.text;
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    // trip.type = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (trip.id != null) {
      // Case 1: Update operation
      result = await databaseHelper.updateTrip(trip);
    } else {
      // Case 2: Insert Operation
      result = await databaseHelper.insertTrip(trip);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Trip Booked Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem booking trip');
    }
  }

  // void _delete() async {
  //   moveToLastScreen();

  //   // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
  //   // the detail page by pressing the FAB of NoteList page.
  //   if (trip.id == null) {
  //     _showAlertDialog('Status', 'No Trip was deleted');
  //     return;
  //   }

    // Case 2: User is trying to delete the old note that already has a valid ID.
  //   int result = await helper.deleteTrip(trip.id);
  //   if (result != 0) {
  //     _showAlertDialog('Status', 'Trip Deleted Successfully');
  //   } else {
  //     _showAlertDialog('Status', 'Error Occured while Deleting Trip');
  //   }
  // }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
