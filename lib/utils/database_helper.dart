import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tinsas_app/models/trip.dart';

class TripDB{
  TripDB._();
  static final TripDB db = TripDB._();

  static Database _database;

  Future<Database> get database async{
    if(_database != null)
    return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory trDetDirectory = await getApplicationDocumentsDirectory();
    String path = trDetDirectory.path + "TripDB.db"; 
    return await openDatabase(path, version: 1, onOpen: (db){}, onCreate: 
    (Database db, int version)async{
      await db.execute("CREATE TABLE Trips ("
      "id INTEGER PRIMARY KEY,"
      "depature TEXT,"
      "departDate TEXT,"
      "departTime TEXT,"
      "destination TEXT,"
      "arriveDate TEXT,"
      "arriveTime TEXT,"
      "tripType TEXT"
      ")");
    });
  }

  newTrip(Trip newTrip)async{
    final db = await database;
    var res = await db.insert("Trips", newTrip.toJson());
    return res;
  }

  Future<List<Trip>>getTrips() async{
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Trips");
    List<Trip> trList = res.isNotEmpty ? res.map((trs) => Trip.fromMap(trs)).toList() : [];
    return trList;
  }

  updateTrip(Trip updateTrip)async{
    final db = await database;
    var res = await db.update("Trips", updateTrip.toJson(), where: "id = ?", whereArgs: [updateTrip.id]);
    return res;
  }

  deleteTrip(int id)async{
    final db = await database;
    var res = await db.delete("Trips", where: "id = ?", whereArgs: [id]);
    await getTrips();
    return res;
  }

  Future<int> getCount() async{
    final db = await database;
    var res = Sqflite.firstIntValue(
      await db.rawQuery("select count (*) from Trips")
    );
    return res.toInt();
  }

}