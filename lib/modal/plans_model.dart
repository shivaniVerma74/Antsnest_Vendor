/// response_code : "1"
/// msg : "Membership plans"
/// data : [{"id":"1","title":"FREE SUBSCRIPTION","description":"FREE SUBSCRIPTION","price":0,"time":"6","type":"2","image":"https://developmentalphawizz.com/antsnest/uploads/6360fcc3c653a.jpg","json":[{"title":"Verified Status","is_true":"1"},{"title":"AN Choice Lable","is_true":"0"},{"title":"Boosted Visibilty","is_true":"0"},{"title":"Social Media Promotion","is_true":"1"},{"title":"Blog Post","is_true":"0"},{"title":"Moderate Reviews & Ratings","is_true":"0"},{"title":"Notification For Jobs","is_true":"1"},{"title":"Interview","is_true":"1"},{"title":"Job Recommedation","is_true":"1"}],"created_at":"2022-09-28 08:15:01","updated_at":"2023-06-12 10:42:58","time_text":"6 Months","plan_type":"Monthly"},{"id":"2","title":"ANBASIC","description":"ANBASIC","price":3100,"time":"1","type":"3","image":"https://developmentalphawizz.com/antsnest/uploads/63343112edf05.jpeg","json":[{"is_true":"1","title":"Verified Status"},{"is_true":"0","title":"AN Choice Lable"},{"is_true":"0","title":"Boosted Visibilty"},{"is_true":"1","title":"Social Media Promotion"},{"is_true":"0","title":"Blog Post"},{"is_true":"0","title":"Moderate Reviews & Ratings"},{"is_true":"1","title":"Notification For Jobs"},{"is_true":"0","title":"Interview"},{"is_true":"1","title":"Job Recommedation"}],"created_at":"2022-09-28 05:41:06","updated_at":"2023-06-16 08:08:39","time_text":"1 Year","plan_type":"Yearly"},{"id":"3","title":"ANPLUS","description":"ANPLUS","price":7999,"time":"1","type":"3","image":"https://developmentalphawizz.com/antsnest/uploads/633431231d7ad.jpeg","json":[{"is_true":"1","title":"Verified Status"},{"is_true":"1","title":"AN Choice Lable"},{"is_true":"1","title":"Boosted Visibilty"},{"is_true":"1","title":"Social Media Promotion"},{"is_true":"1","title":"Blog Post"},{"is_true":"1","title":"Moderate Reviews & Ratings"},{"is_true":"1","title":"Notification For Jobs"},{"is_true":"1","title":"Interview"},{"is_true":"1","title":"Job Recommedation"}],"created_at":"2022-09-28 05:41:06","updated_at":"2023-06-16 08:09:14","time_text":"1 Year","plan_type":"Yearly"}]

class PlansModel {
  PlansModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  PlansModel.fromJson(dynamic json) {
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
PlansModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => PlansModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "1"
/// title : "FREE SUBSCRIPTION"
/// description : "FREE SUBSCRIPTION"
/// price : 0
/// time : "6"
/// type : "2"
/// image : "https://developmentalphawizz.com/antsnest/uploads/6360fcc3c653a.jpg"
/// json : [{"title":"Verified Status","is_true":"1"},{"title":"AN Choice Lable","is_true":"0"},{"title":"Boosted Visibilty","is_true":"0"},{"title":"Social Media Promotion","is_true":"1"},{"title":"Blog Post","is_true":"0"},{"title":"Moderate Reviews & Ratings","is_true":"0"},{"title":"Notification For Jobs","is_true":"1"},{"title":"Interview","is_true":"1"},{"title":"Job Recommedation","is_true":"1"}]
/// created_at : "2022-09-28 08:15:01"
/// updated_at : "2023-06-12 10:42:58"
/// time_text : "6 Months"
/// plan_type : "Monthly"

class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      num? price, 
      String? time, 
      String? type, 
      String? image, 
      List<Json>? json, 
      String? createdAt, 
      String? updatedAt, 
      String? timeText, 
      String? planType,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _time = time;
    _type = type;
    _image = image;
    _json = json;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timeText = timeText;
    _planType = planType;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _time = json['time'];
    _type = json['type'];
    _image = json['image'];
    if (json['json'] != null) {
      _json = [];
      json['json'].forEach((v) {
        _json?.add(Json.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeText = json['time_text'];
    _planType = json['plan_type'];
  }
  String? _id;
  String? _title;
  String? _description;
  num? _price;
  String? _time;
  String? _type;
  String? _image;
  List<Json>? _json;
  String? _createdAt;
  String? _updatedAt;
  String? _timeText;
  String? _planType;
Data copyWith({  String? id,
  String? title,
  String? description,
  num? price,
  String? time,
  String? type,
  String? image,
  List<Json>? json,
  String? createdAt,
  String? updatedAt,
  String? timeText,
  String? planType,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  time: time ?? _time,
  type: type ?? _type,
  image: image ?? _image,
  json: json ?? _json,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timeText: timeText ?? _timeText,
  planType: planType ?? _planType,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
  String? get time => _time;
  String? get type => _type;
  String? get image => _image;
  List<Json>? get json => _json;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeText => _timeText;
  String? get planType => _planType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['time'] = _time;
    map['type'] = _type;
    map['image'] = _image;
    if (_json != null) {
      map['json'] = _json?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_text'] = _timeText;
    map['plan_type'] = _planType;
    return map;
  }

}

/// title : "Verified Status"
/// is_true : "1"

class Json {
  Json({
      String? title, 
      String? isTrue,}){
    _title = title;
    _isTrue = isTrue;
}

  Json.fromJson(dynamic json) {
    _title = json['title'];
    _isTrue = json['is_true'];
  }
  String? _title;
  String? _isTrue;
Json copyWith({  String? title,
  String? isTrue,
}) => Json(  title: title ?? _title,
  isTrue: isTrue ?? _isTrue,
);
  String? get title => _title;
  String? get isTrue => _isTrue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['is_true'] = _isTrue;
    return map;
  }

}