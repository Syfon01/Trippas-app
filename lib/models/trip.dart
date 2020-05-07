class Trip {
  int id;
  String departure;
  String destination;
  String departDate;
  String departTime;
  String arriveTime;
  String arriveDate;
  String tripType;

  
  Trip({this.id, this.departure, this.destination, this.departDate,
      this.departTime, this.arriveTime, this.arriveDate,this.tripType});

  

  
factory Trip.fromMap(Map <String, dynamic> data) => Trip(
    id: data["id"],
    departure: data["departure"],
    departDate: data["departDate"],
    departTime: data["departTime"],
    destination: data["destination"],
    arriveDate: data["arriveDate"],
    arriveTime: data["arriveTime"],
    tripType: data["tripType"],
  );
  


  Map<String,dynamic> toJson(){
    return{
      "id": id,
      "depature": departure,
      "departDate": departDate,
      "dapartTime": departTime,
      "destination": destination,
      "arriveDate": arriveDate,
      "arriveTime": arriveTime,
      "tripType": tripType
    };
  }
}
  