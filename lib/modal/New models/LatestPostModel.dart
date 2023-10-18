/// response_code : "1"
/// msg : "Latest posts"
/// data : [{"username":"Shivani ","last_login":"13 Oct 2023, 08:53 PM","id":"100","user_id":"252","cat_id":"45","sub_cat_id":"98","note":"dghhg","location":"vijay nagar, 777","currency":"","date":"2023-10-18","budget":"2580.00","status":"0","created_at":"2023-10-14 10:48:05","updated_at":"2023-10-14 10:48:05","rejected_by":null,"accepted_by":null,"currency_code":"3","country":"3","state":"1","city":"2"},{"username":"Shivani ","last_login":"13 Oct 2023, 08:53 PM","id":"90","user_id":"252","cat_id":"45","sub_cat_id":"98","note":"photographer","location":"vijay nagar, 777","currency":"","date":"2023-10-28","budget":"5000.00","status":"0","created_at":"2023-10-12 10:17:23","updated_at":"2023-10-12 11:33:37","rejected_by":null,"accepted_by":"206","currency_code":"3","country":"3","state":"1","city":"2"}]

class LatestPostModel {
  LatestPostModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  LatestPostModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
LatestPostModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => LatestPostModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// username : "Shivani "
/// last_login : "13 Oct 2023, 08:53 PM"
/// id : "100"
/// user_id : "252"
/// cat_id : "45"
/// sub_cat_id : "98"
/// note : "dghhg"
/// location : "vijay nagar, 777"
/// currency : ""
/// date : "2023-10-18"
/// budget : "2580.00"
/// status : "0"
/// created_at : "2023-10-14 10:48:05"
/// updated_at : "2023-10-14 10:48:05"
/// rejected_by : null
/// accepted_by : null
/// currency_code : "3"
/// country : "3"
/// state : "1"
/// city : "2"

class Data {
  Data({
      String? username, 
      String? lastLogin, 
      String? id, 
      String? userId, 
      String? catId, 
      String? subCatId, 
      String? note, 
      String? location, 
      String? currency, 
      String? date, 
      String? budget, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic rejectedBy, 
      dynamic acceptedBy, 
      String? currencyCode, 
      String? country, 
      String? state, 
      String? city,}){
    _username = username;
    _lastLogin = lastLogin;
    _id = id;
    _userId = userId;
    _catId = catId;
    _subCatId = subCatId;
    _note = note;
    _location = location;
    _currency = currency;
    _date = date;
    _budget = budget;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _rejectedBy = rejectedBy;
    _acceptedBy = acceptedBy;
    _currencyCode = currencyCode;
    _country = country;
    _state = state;
    _city = city;
}

  Data.fromJson(dynamic json) {
    _username = json['username'];
    _lastLogin = json['last_login'];
    _id = json['id'];
    _userId = json['user_id'];
    _catId = json['cat_id'];
    _subCatId = json['sub_cat_id'];
    _note = json['note'];
    _location = json['location'];
    _currency = json['currency'];
    _date = json['date'];
    _budget = json['budget'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _rejectedBy = json['rejected_by'];
    _acceptedBy = json['accepted_by'];
    _currencyCode = json['currency_code'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
  }
  String? _username;
  String? _lastLogin;
  String? _id;
  String? _userId;
  String? _catId;
  String? _subCatId;
  String? _note;
  String? _location;
  String? _currency;
  String? _date;
  String? _budget;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _rejectedBy;
  dynamic _acceptedBy;
  String? _currencyCode;
  String? _country;
  String? _state;
  String? _city;
Data copyWith({  String? username,
  String? lastLogin,
  String? id,
  String? userId,
  String? catId,
  String? subCatId,
  String? note,
  String? location,
  String? currency,
  String? date,
  String? budget,
  String? status,
  String? createdAt,
  String? updatedAt,
  dynamic rejectedBy,
  dynamic acceptedBy,
  String? currencyCode,
  String? country,
  String? state,
  String? city,
}) => Data(  username: username ?? _username,
  lastLogin: lastLogin ?? _lastLogin,
  id: id ?? _id,
  userId: userId ?? _userId,
  catId: catId ?? _catId,
  subCatId: subCatId ?? _subCatId,
  note: note ?? _note,
  location: location ?? _location,
  currency: currency ?? _currency,
  date: date ?? _date,
  budget: budget ?? _budget,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  rejectedBy: rejectedBy ?? _rejectedBy,
  acceptedBy: acceptedBy ?? _acceptedBy,
  currencyCode: currencyCode ?? _currencyCode,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
);
  String? get username => _username;
  String? get lastLogin => _lastLogin;
  String? get id => _id;
  String? get userId => _userId;
  String? get catId => _catId;
  String? get subCatId => _subCatId;
  String? get note => _note;
  String? get location => _location;
  String? get currency => _currency;
  String? get date => _date;
  String? get budget => _budget;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get rejectedBy => _rejectedBy;
  dynamic get acceptedBy => _acceptedBy;
  String? get currencyCode => _currencyCode;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['last_login'] = _lastLogin;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['cat_id'] = _catId;
    map['sub_cat_id'] = _subCatId;
    map['note'] = _note;
    map['location'] = _location;
    map['currency'] = _currency;
    map['date'] = _date;
    map['budget'] = _budget;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['rejected_by'] = _rejectedBy;
    map['accepted_by'] = _acceptedBy;
    map['currency_code'] = _currencyCode;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    return map;
  }

}