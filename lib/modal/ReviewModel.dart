/// data : [{"profile_pic":"647f09745579e.jpg","res_name":"WEDDING","username":"Shiva Sharma","rev_id":"262","rev_user":"31","rev_res":"130","rev_stars":"2","rev_text":"test\r\n","rev_date":"","created_at":"2023-05-20 15:23:37"},{"profile_pic":"","res_name":"Fashion Store","username":"Test","rev_id":"243","rev_user":"82","rev_res":"136","rev_stars":"5","rev_text":"exillent ","rev_date":"1667405133","created_at":"2022-11-02 16:05:33"},{"profile_pic":"647f09745579e.jpg","res_name":"WEDDING","username":"Shiva Sharma","rev_id":"248","rev_user":"31","rev_res":"130","rev_stars":"4","rev_text":"test review please check","rev_date":"","created_at":"2023-01-04 09:36:17"},{"profile_pic":"647f09745579e.jpg","res_name":"WEDDING","username":"Shiva Sharma","rev_id":"249","rev_user":"31","rev_res":"130","rev_stars":"2","rev_text":"test","rev_date":"","created_at":"2023-01-12 08:13:02"},{"profile_pic":"647f09745579e.jpg","res_name":"WEDDING","username":"Shiva Sharma","rev_id":"250","rev_user":"31","rev_res":"130","rev_stars":"3","rev_text":"test test","rev_date":"","created_at":"2023-01-12 08:15:39"},{"profile_pic":"647f09745579e.jpg","res_name":"WEDDING","username":"Shiva Sharma","rev_id":"260","rev_user":"31","rev_res":"130","rev_stars":"4","rev_text":"This is review for booking","rev_date":"","created_at":"2023-02-27 07:30:02"},{"profile_pic":"647f09745579e.jpg","res_name":"WEDDING","username":"Shiva Sharma","rev_id":"261","rev_user":"31","rev_res":"130","rev_stars":"4","rev_text":"test","rev_date":"","created_at":"2023-03-06 13:57:37"}]
/// status : 1
/// msg : "Reviews Found"

class ReviewModel {
  ReviewModel({
      List<Data>? data, 
      num? status, 
      String? msg,}){
    _data = data;
    _status = status;
    _msg = msg;
}

  ReviewModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _status = json['status'];
    _msg = json['msg'];
  }
  List<Data>? _data;
  num? _status;
  String? _msg;
ReviewModel copyWith({  List<Data>? data,
  num? status,
  String? msg,
}) => ReviewModel(  data: data ?? _data,
  status: status ?? _status,
  msg: msg ?? _msg,
);
  List<Data>? get data => _data;
  num? get status => _status;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['msg'] = _msg;
    return map;
  }

}

/// profile_pic : "647f09745579e.jpg"
/// res_name : "WEDDING"
/// username : "Shiva Sharma"
/// rev_id : "262"
/// rev_user : "31"
/// rev_res : "130"
/// rev_stars : "2"
/// rev_text : "test\r\n"
/// rev_date : ""
/// created_at : "2023-05-20 15:23:37"

class Data {
  Data({
      String? profilePic, 
      String? resName, 
      String? username, 
      String? revId, 
      String? revUser, 
      String? revRes, 
      String? revStars, 
      String? revText, 
      String? revDate, 
      String? createdAt,}){
    _profilePic = profilePic;
    _resName = resName;
    _username = username;
    _revId = revId;
    _revUser = revUser;
    _revRes = revRes;
    _revStars = revStars;
    _revText = revText;
    _revDate = revDate;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _profilePic = json['profile_pic'];
    _resName = json['res_name'];
    _username = json['username'];
    _revId = json['rev_id'];
    _revUser = json['rev_user'];
    _revRes = json['rev_res'];
    _revStars = json['rev_stars'];
    _revText = json['rev_text'];
    _revDate = json['rev_date'];
    _createdAt = json['created_at'];
  }
  String? _profilePic;
  String? _resName;
  String? _username;
  String? _revId;
  String? _revUser;
  String? _revRes;
  String? _revStars;
  String? _revText;
  String? _revDate;
  String? _createdAt;
Data copyWith({  String? profilePic,
  String? resName,
  String? username,
  String? revId,
  String? revUser,
  String? revRes,
  String? revStars,
  String? revText,
  String? revDate,
  String? createdAt,
}) => Data(  profilePic: profilePic ?? _profilePic,
  resName: resName ?? _resName,
  username: username ?? _username,
  revId: revId ?? _revId,
  revUser: revUser ?? _revUser,
  revRes: revRes ?? _revRes,
  revStars: revStars ?? _revStars,
  revText: revText ?? _revText,
  revDate: revDate ?? _revDate,
  createdAt: createdAt ?? _createdAt,
);
  String? get profilePic => _profilePic;
  String? get resName => _resName;
  String? get username => _username;
  String? get revId => _revId;
  String? get revUser => _revUser;
  String? get revRes => _revRes;
  String? get revStars => _revStars;
  String? get revText => _revText;
  String? get revDate => _revDate;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile_pic'] = _profilePic;
    map['res_name'] = _resName;
    map['username'] = _username;
    map['rev_id'] = _revId;
    map['rev_user'] = _revUser;
    map['rev_res'] = _revRes;
    map['rev_stars'] = _revStars;
    map['rev_text'] = _revText;
    map['rev_date'] = _revDate;
    map['created_at'] = _createdAt;
    return map;
  }

}