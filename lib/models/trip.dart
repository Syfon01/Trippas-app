class Trip {
  int _id;
  String _departure;
  String _destination;
  String _departDate;
  String _departTime;
  String _arriveTime;
  String _arriveDate;
  String _type;
  int _priority;

  Trip(this._departure, this._destination, this._departDate, this._departTime,
      this._arriveTime, this._arriveDate, this._priority,
      [this._type]);
  Trip.withId(this._id, this._departure, this._destination, this._departDate,
      this._departTime, this._arriveTime, this._arriveDate, this._priority,
      [this._type]);

  int get id => _id;
  String get destination => _destination;
  String get departure => _departure;
  String get departdate => _departDate;
  String get arrivedate => _arriveDate;
  String get departtime => _departTime;
  String get arrivetime => _arriveTime;
  String get type => _type;
  int get priority => _priority;

  set type(String newtype) {
    if (newtype.length <= 255) {
      _type = newtype;
    }
  }

  set priority(int newPriority) {
    if (newPriority > 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  set destination(String newDestination) {
    if (newDestination.length <= 255) {
      _destination = newDestination;
    }
  }

  set departure(String newDeparture) {
    if (newDeparture.length <= 255) {
      _departure = newDeparture;
    }
  }

  set departDate(String newDepartDate) {
    _departDate = newDepartDate;
  }

  set arriveDate(String newArriveDate) {
    _arriveDate = newArriveDate;
  }


set departTime(String newDepartTime) {
    _departTime = newDepartTime;
  }
set arriveTime(String newArriveTime) {
    _arriveTime = newArriveTime;
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['type'] = _type;
    map['destination'] = _destination;
    map['departure'] = _departure;
    map['priority'] = _priority;
    map['departDate'] = _departDate;
    map['arriveDate'] = _arriveDate;
    map['departTime'] = _departTime;
    map['arriveTime'] = _arriveTime;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }

  Trip.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._type = map['type'];
    this._destination = map['destination'];
    this._departure = map['departure'];
    this._priority = map['priority'];
    this._departDate = map['departDate'];
    this._arriveTime = map['arriveTime'];
    this._departTime = map['departTime'];
    this._arriveDate = map['arriveDate'];

  }

  
}
