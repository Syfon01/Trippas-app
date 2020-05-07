import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:tinsas_app/screens/trip_details.dart';
import 'package:sqflite/sqflite.dart';
// import 'dart:async';
import 'package:tinsas_app/models/trip.dart';
import 'package:tinsas_app/utils/database_helper.dart';

class TripList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripListState();
  }
}

class TripListState extends State<TripList> {
  List<Trip> tr = List<Trip>();
  final depatureController = TextEditingController();
  final destinationController = TextEditingController();
  var _value;
  String _departDate = "Enter Date";
  String _departTime = "Enter Time";
  String _arriveDate = "Enter Date";
  String _arriveTime = "Enter Time";



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.pushNamed(context, '/createTrip');},
        backgroundColor: Colors.blue,child: Icon(Icons.add),),
        backgroundColor: Colors.grey[50],
        
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 10),
          child: Container(
            child: Column(
              children: <Widget>[
                  Row(
                  children: <Widget>
                  [
                    Text('Hello, Syfon',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    SizedBox(width: 150,),
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      
                      child: Center(
                        child:Text('20 Trips', 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,))),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  width: 400,
                  alignment: Alignment.topLeft,
                  child:Text('Create your trips', style:TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 15,),
                Expanded(
                   child: FutureBuilder(
                    future: TripDB.db.getTrips() ,
                    builder: (context, AsyncSnapshot<List<Trip>>snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                      height: 140,
                      width: 400,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                              Container(
                                child: Column(children: <Widget>[
                                  Text('${snapshot.data[index].departure}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                  SizedBox(height: 5,),
                                  Text('${snapshot.data[index].departDate.toString()}',style: TextStyle(color: Colors.grey[400])),
                                  SizedBox(height: 5,),
                                  Text('${snapshot.data[index].departTime.toString()}' , style: TextStyle(color: Colors.grey[400])),
                                  SizedBox(height: 35,),
                                  Container(height: 20,width: 70, 
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text('${snapshot.data[index].tripType}', 
                                      style: TextStyle(color: Colors.white),)),
                                  ), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: getColor(snapshot.data[index].tripType,),
                                  ))],),
                              ),
                              SizedBox(width: 10,),
                              Container(child: Icon(Icons.flight_takeoff)),
                              SizedBox(width: 10,),
                              Container(child: Column(
                                children: <Widget>[
                                  Text('${snapshot.data[index].destination}' , 
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                  SizedBox(height: 5,),
                                  Text('${snapshot.data[index].arriveDate.toString()}' , 
                                  style: TextStyle(color: Colors.grey[400])),
                                  SizedBox(height: 5,),
                                  Text('${snapshot.data[index].arriveTime.toString()}', 
                                  style: TextStyle(color: Colors.grey[400])),
                                  SizedBox(height: 19,),
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Text('Update'),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Text('Delete'),
                                      ),
                                    ],
                                    onSelected: (value)async{
                                      if(value == 2){
                                         await TripDB.db.deleteTrip(snapshot.data[index].id);
                                      }
                                      else if(value == 1){
                                        setState(() async{
                                          TripDB.db.updateTrip(
                                            Trip(
                                              departure: depatureController.text,
                                              departDate: _departDate,
                                              departTime: _departTime,
                                              destination: destinationController.text,
                                              arriveDate: _arriveDate,
                                              arriveTime: _arriveTime,
                                              tripType: _value 
                                            )
                                          );
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ))
                          ],),
                        ],),
                          ),
                            );
                          }
                        );
                      }
                      return SpinKitRotatingCircle(color: Colors.blue[400], size: 50,);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Color getColor(String trs){
  switch(trs){
    case '1':
      return Colors.blue;
    break;
    case '2':
      return Colors.cyan;
    break;
    case '3':
      return Colors.pinkAccent;
    break;
    case '4':
      return Colors.amber;
    break;
    default:
      return Colors.blue;
      break;
    }
  }

//  String getPriorityText(String priority) {
//     switch (priority) {
//       case 1:
//         return 'business';
//         break;
//       case 2:
//         return 'vacation';
//         break;
//       case 3:
//         return 'holiday';
//         break;
//       case 4:
//         return 'education';
//         break;
//       default:
//         return 'business';
//     }
//   }
  String getText(String trs){
  switch(trs){
    case "1":
      return "Business";
    break;
    case "2":
      return "Education";
    break;
    case "3":
      return "Vacation";
    break;
    case "4":
      return "Health";
    break;
    default:
      return "Business";
      break;
    }
  }
}

//   void updateListView() {
//     final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//     dbFuture.then((database) {
//       Future<List<Trip>> tripListFuture = databaseHelper.getTripList();
//       tripListFuture.then((tripList) {
//         setState(() {
//           this.tripList = tripList;
//           this.count = tripList.length;
//         });
//       });
//     });
//   }

//   Color getPriorityColor(int priority) {
//     switch (priority) {
//       case 1:
//         return Colors.blue;
//         break;
//       case 2:
//         return Colors.yellow;
//         break;
//       case 3:
//         return Colors.red;
//         break;
//       case 4:
//         return Colors.green;
//         break;

//       default:
//         return Colors.yellow;
//     }
//   }

//   void navigateNext(String title) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return TripDetails(title);
//     }));

//     // if (result == true) {
//     //   updateListView();
//     // }
//   }

//   void _showSnackBar(BuildContext context, String message) {
//     final snackBar = SnackBar(content: Text(message));
//     Scaffold.of(context).showSnackBar(snackBar);
//   }

//   void _delete(BuildContext context, Trip trip) async {
//     int result = await databaseHelper.deleteTrip(trip.id);
//     if (result != 0) {
//       _showSnackBar(context, 'Trip Deleted Successfully');
//       updateListView();
//     }
//   }

//   ListView getTripList() {
//     return ListView.builder(
//         itemCount: count,
//         itemBuilder: (BuildContext context, int position) {
//           return Card(
//             color: Colors.blue,
//             elevation: 4.0,
//             child: Container(
//                 child: Column(
//               children: <Widget>[
//                 Row(children: <Widget>[
//                   Expanded(
//                       child: Text(this.tripList[position].departure,
//                           style: TextStyle(fontSize: 24.0))),
//                   Expanded(
//                     child: Icon(Icons.airplanemode_active),
//                     // color: Colors.white,
//                   ),
//                   Expanded(
//                       child: Text(this.tripList[position].destination,
//                           style: TextStyle(fontSize: 24.0)))
//                 ]),
//                 Row(children: <Widget>[
//                   Expanded(
//                       child: Text(
//                     this.tripList[position].departdate,
//                   )),
//                   Expanded(
//                       child: Text(
//                     this.tripList[position].arrivetime,
//                   ))
//                 ]),
//                 Row(children: <Widget>[
//                   Expanded(
//                       child: Text(
//                     this.tripList[position].departtime,
//                   )),
//                   Expanded(
//                       child: Text(
//                     this.tripList[position].arrivetime,
//                   ))
//                 ]),
//                 Row(children: <Widget>[
//                   Expanded(
//                     child: Text(
//                       '',
//                       // getPriorityText(this.tripList[position].priority),
//                       style: TextStyle(
//                           backgroundColor: getPriorityColor(
//                               this.tripList[position].priority)),
//                     ),
//                   ),
//                   Expanded(
//                       child: GestureDetector(
//                     child: Icon(
//                       Icons.more_vert,
//                       color: Colors.grey,
//                     ),
//                     onTap: () {
//                       _showMyDialog();
//                     },
//                   ))
//                 ])
//               ],
//             )),
//           );
//         });
//   }

//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: AlertDialog Title'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[

//                 new GestureDetector(
//                   onTap: () {
//                     navigateNext('Edit Trip');
//                   },
//                   child: new Text("Update"),
//                 ),
//                 new GestureDetector(
//                   onTap: () {
//                   _delete(context, tripList[position]);
//                   },
//                   child: new Text("Delete"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (tripList == null) {
//       tripList = List<Trip>();
//     }
//     updateListView();

//     return Scaffold(
//       body: Container(
//           padding: EdgeInsets.fromLTRB(20, 50.0, 20, 0),
//           child: Column(children: <Widget>[
//             Container(
//                 child: Row(children: <Widget>[
//               Expanded(
//                   child: Text(
//                 'Hello, Arthur',
//                 style: TextStyle(fontSize: 20.0),
//               )),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   color: Colors.blueAccent),
//                   padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
//                     child: Text(
//                 '20 trips',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   color: Colors.white,
                  
//                 ),
//               ))))
//             ])),
//             Container(
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Container(
//                       width: 200.0,
//                       padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
//                       child: Text(
//                         'Create your trips with us',
//                         textDirection: TextDirection.ltr,
//                         style: TextStyle(
//                             fontSize: 36.0, fontWeight: FontWeight.w800),
//                       ),
//                     ))),
//             Container(
//               height: 200.0,
//               color: Colors.blue,
//               child: getTripList(),
//             )
//           ])),
//       // Container(child: getTripList())

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           debugPrint('This was clicked');
//           navigateNext('Create Trip');
//         },
//         tooltip: "Add Trip",
//         child: Icon(Icons.add),
//         // color: Colors.blueAccent,
//       ),
//     );
//   }

//   // import 'package:sqflite/sqflite.dart';
// // Returns the priority color

//   Returns the priority text
//   Text getPriorityText(int priority) {
//     switch (priority) {
//       case 1:
//         return business');
//         break;
//       case 2:
//         return vacation');
//         break;
//       case 3:
//         return holiday');
//         break;
//       case 4:
//         return education');
//         break;
//       default:
//         return business');
//     }
//   }

// }
