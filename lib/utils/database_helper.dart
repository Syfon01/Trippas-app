import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tinsas_app/models/trip.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String tripTable = 'trip_table';
	String colId = 'id';
	String colType = 'type';
	String colDestination = 'destination';
	String colDeparture= 'departure';
	String colDepartDate = 'departDate';
	String colArriveDate= 'arriveDate';
	String colArriveTime= 'arriveTime';
	String colDepartTime= 'departTime';
	String colPriority = 'priority';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'trips.db';

		// Open/create the database at a given path
		var tripsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return tripsDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $tripTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colType TEXT, '
				'$colDestination TEXT,$colDeparture TEXT, $colPriority INTEGER, $colDepartDate TEXT, $colArriveDate TEXT, $colDepartTime TEXT,$colArriveTime TEXT)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getTripMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(tripTable, orderBy: '$colPriority ASC');
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertTrip(Trip trip) async {
		Database db = await this.database;
		var result = await db.insert(tripTable, trip.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateTrip(Trip trip) async {
		var db = await this.database;
		var result = await db.update(tripTable, trip.toMap(), where: '$colId = ?', whereArgs: [trip.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteTrip(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $tripTable WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tripTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Trip>> getTripList() async {

		var tripMapList = await getTripMapList(); // Get 'Map List' from database
		int count = tripMapList.length;         // Count the number of map entries in db table

		List<Trip> tripList = List<Trip>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			tripList.add(Trip.fromMapObject(tripMapList[i]));
		}

		return tripList;
	}

}


