import 'package:flutter/material.dart';
import 'package:tinsas_app/models/trip.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tinsas_app/utils/database_helper.dart';

class TripDetails extends StatefulWidget {
  @override
  _TripDetailsState createState() {
    return _TripDetailsState();
  }
}

class _TripDetailsState extends State<TripDetails> {
  _TripDetailsState();
  final departureController = TextEditingController();
  final destinationController = TextEditingController();
  var _value;
  String _departDate = "Enter Date";
  String _departTime = "Enter Time";
  String _arriveDate = "Enter Date";
  String _arriveTime = "Enter Time";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Create a trip',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.text,
                controller: departureController,
                decoration: InputDecoration(
                    hintText: 'Enter Depature',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(containerHeight: 210.0),
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime(2050, 12, 12), onConfirm: (date) {
                        _departDate =
                            '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      child: Text(
                        '$_departDate',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showTimePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                        _departTime =
                            '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      child: Text(
                        '$_departTime',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.text,
                controller: destinationController,
                decoration: InputDecoration(
                    hintText: 'Enter Destination',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(containerHeight: 210.0),
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime(2050, 12, 12), onConfirm: (date) {
                        _arriveDate =
                            '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      child: Text('$_arriveDate',
                          style: TextStyle(color: Colors.grey[500])),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showTimePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                        _arriveTime =
                            '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      child: Text(
                        '$_arriveTime',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    value: "1",
                    child: Text('Business'),
                  ),
                  DropdownMenuItem<String>(
                    value: "2",
                    child: Text('Education'),
                  ),
                  DropdownMenuItem<String>(
                    value: "3",
                    child: Text('Health'),
                  ),
                  DropdownMenuItem<String>(
                    value: "4",
                    child: Text('Vacation'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
                hint: Text(
                  'Trip Type',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                value: _value,
                isExpanded: true,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  TripDB.db.newTrip(Trip(
                      departure: departureController.text,
                      departDate: _departDate,
                      departTime: _departTime,
                      destination: destinationController.text,
                      arriveDate: _arriveDate,
                      arriveTime: _arriveTime,
                      tripType: _value));
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Add Trip',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
