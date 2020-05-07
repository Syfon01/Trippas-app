import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './screens/trip_list.dart';
import './screens/trip_details.dart';



void main(){
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('Trippas',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Colors.blueAccent
        ),
      ),
      
    );
  }
}


class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: 'Trippas App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch : Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => TripList(),
        '/createTrip': (context) => TripDetails(),
      },
    );
  }
}
