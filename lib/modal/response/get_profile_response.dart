/// response_code : "1"
/// message : "Vendor Found"
/// user : {"country":"India","state":"Himachal Pradesh","id":"34","fname":"Sawan","lname":"","email":"sawan1232@mailinator.com","country_code":"+91","mobile":"7897899877","address":"Indore mp","country_id":"3","state_id":"6","city_id":"9","dob":"2014-02-01","category_id":"43","subcategory_id":"87","postal_code":"46666","payment_details":{"account_holder_name":"Rohit Jhariya","acc_no":"1000000420","bank_name":"PNB ","bank_addr":"Mulund ","ifsc_code":"PNB0000988","pancard_no":"AHQPT4583Q","sort_code":"1111","routing_number":"1111","paypal_email_id":"pt.quanticteq@gmail.com","contact_number":"9867990355","mode":"NEFT","purpose":"Payout","razorpay_id":"12345687897654231"},"lat":"0","lang":"0","uname":"Sawan","password":"","profile_image":"https://developmentalphawizz.com/antsnest/uploads/633a97a1251e9.png","device_token":"coiJLbMuQb-HHtBQSbaWvd:APA91bFwk1orrbC9lxYrkcUgj_MnrxiCmi-AU3Ne4AbjI-Qc9WeDeOJLzixkrkukMTy1CwbaByEJdEc-PrpAi8IQMialSG1FKH4cZC-AFRmdCKuGAdHyEqwb98aB32GDK3b6gyWYYA9o","otp":"9448","status":"1","wallet":"16308.50","balance":"2700.00","json_data":{"can_travel":"Nationwide","service_cities":"[]","website":"sbsbbzb","t_link":"sbshsjdjfjfllloo","i_link":"lllkllllll","l_link":"iiioooouuy","equipments":"qqaasswwww","birthday":"21/10/2022","provide_services":"eueieiwkwk","join_antsnest":"ssbbsnsnsn","cat":"42","sub_cat":"58","amount":"9497","hrs_day":"Hour","language":"Italian"},"last_login":null,"created_at":"2022-10-10 13:30:35","updated_at":"2023-06-07 10:04:29"}
/// active_plan : "1"
/// status : "success"

class GetProfileResponse {
  GetProfileResponse({
      String? responseCode, 
      String? message, 
      User? user, 
      String? activePlan, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _user = user;
    _activePlan = activePlan;
    _status = status;
}

  GetProfileResponse.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _activePlan = json['active_plan'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  User? _user;
  String? _activePlan;
  String? _status;
GetProfileResponse copyWith({  String? responseCode,
  String? message,
  User? user,
  String? activePlan,
  String? status,
}) => GetProfileResponse(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  user: user ?? _user,
  activePlan: activePlan ?? _activePlan,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  User? get user => _user;
  String? get activePlan => _activePlan;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['active_plan'] = _activePlan;
    map['status'] = _status;
    return map;
  }

}

/// country : "India"
/// state : "Himachal Pradesh"
/// id : "34"
/// fname : "Sawan"
/// lname : ""
/// email : "sawan1232@mailinator.com"
/// country_code : "+91"
/// mobile : "7897899877"
/// address : "Indore mp"
/// country_id : "3"
/// state_id : "6"
/// city_id : "9"
/// dob : "2014-02-01"
/// category_id : "43"
/// subcategory_id : "87"
/// postal_code : "46666"
/// payment_details : {"account_holder_name":"Rohit Jhariya","acc_no":"1000000420","bank_name":"PNB ","bank_addr":"Mulund ","ifsc_code":"PNB0000988","pancard_no":"AHQPT4583Q","sort_code":"1111","routing_number":"1111","paypal_email_id":"pt.quanticteq@gmail.com","contact_number":"9867990355","mode":"NEFT","purpose":"Payout","razorpay_id":"12345687897654231"}
/// lat : "0"
/// lang : "0"
/// uname : "Sawan"
/// password : ""
/// profile_image : "https://developmentalphawizz.com/antsnest/uploads/633a97a1251e9.png"
/// device_token : "coiJLbMuQb-HHtBQSbaWvd:APA91bFwk1orrbC9lxYrkcUgj_MnrxiCmi-AU3Ne4AbjI-Qc9WeDeOJLzixkrkukMTy1CwbaByEJdEc-PrpAi8IQMialSG1FKH4cZC-AFRmdCKuGAdHyEqwb98aB32GDK3b6gyWYYA9o"
/// otp : "9448"
/// status : "1"
/// wallet : "16308.50"
/// balance : "2700.00"
/// json_data : {"can_travel":"Nationwide","service_cities":"[]","website":"sbsbbzb","t_link":"sbshsjdjfjfllloo","i_link":"lllkllllll","l_link":"iiioooouuy","equipments":"qqaasswwww","birthday":"21/10/2022","provide_services":"eueieiwkwk","join_antsnest":"ssbbsnsnsn","cat":"42","sub_cat":"58","amount":"9497","hrs_day":"Hour","language":"Italian"}
/// last_login : null
/// created_at : "2022-10-10 13:30:35"
/// updated_at : "2023-06-07 10:04:29"

class User {
  User({
      String? country, 
      String? state, 
      String? id, 
      String? fname, 
      String? lname, 
      String? email, 
      String? countryCode, 
      String? mobile, 
      String? address, 
      String? countryId, 
      String? stateId, 
      String? cityId, 
      String? dob, 
      String? categoryId, 
      String? subcategoryId, 
      String? postalCode, 
      PaymentDetails? paymentDetails, 
      String? lat, 
      String? lang, 
      String? uname, 
      String? password, 
      String? profileImage, 
      String? deviceToken, 
      String? otp, 
      String? status, 
      String? wallet, 
      String? balance, 
      JsonData? jsonData, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt,}){
    _country = country;
    _state = state;
    _id = id;
    _fname = fname;
    _lname = lname;
    _email = email;
    _countryCode = countryCode;
    _mobile = mobile;
    _address = address;
    _countryId = countryId;
    _stateId = stateId;
    _cityId = cityId;
    _dob = dob;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _postalCode = postalCode;
    _paymentDetails = paymentDetails;
    _lat = lat;
    _lang = lang;
    _uname = uname;
    _password = password;
    _profileImage = profileImage;
    _deviceToken = deviceToken;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _balance = balance;
    _jsonData = jsonData;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _country = json['country'];
    _state = json['state'];
    _id = json['id'];
    _fname = json['fname'];
    _lname = json['lname'];
    _email = json['email'];
    _countryCode = json['country_code'] == null ?  "+91" : json['country_code'];
    _mobile = json['mobile'];
    _address = json['address'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _dob = json['dob'];
    _categoryId = json['category_id'];
    _subcategoryId = json['subcategory_id'];
    _postalCode = json['postal_code'];
    _paymentDetails = json['payment_details'] != null ? PaymentDetails.fromJson(json['payment_details']) : null;
    _lat = json['lat'];
    _lang = json['lang'];
    _uname = json['uname'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _balance = json['balance'];
    _jsonData = json['json_data'] != null ? JsonData.fromJson(json['json_data']) : null;
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _country;
  String? _state;
  String? _id;
  String? _fname;
  String? _lname;
  String? _email;
  String? _countryCode;
  String? _mobile;
  String? _address;
  String? _countryId;
  String? _stateId;
  String? _cityId;
  String? _dob;
  String? _categoryId;
  String? _subcategoryId;
  String? _postalCode;
  PaymentDetails? _paymentDetails;
  String? _lat;
  String? _lang;
  String? _uname;
  String? _password;
  String? _profileImage;
  String? _deviceToken;
  String? _otp;
  String? _status;
  String? _wallet;
  String? _balance;
  JsonData? _jsonData;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
User copyWith({  String? country,
  String? state,
  String? id,
  String? fname,
  String? lname,
  String? email,
  String? countryCode,
  String? mobile,
  String? address,
  String? countryId,
  String? stateId,
  String? cityId,
  String? dob,
  String? categoryId,
  String? subcategoryId,
  String? postalCode,
  PaymentDetails? paymentDetails,
  String? lat,
  String? lang,
  String? uname,
  String? password,
  String? profileImage,
  String? deviceToken,
  String? otp,
  String? status,
  String? wallet,
  String? balance,
  JsonData? jsonData,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
}) => User(  country: country ?? _country,
  state: state ?? _state,
  id: id ?? _id,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  email: email ?? _email,
  countryCode: countryCode ?? _countryCode,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  dob: dob ?? _dob,
  categoryId: categoryId ?? _categoryId,
  subcategoryId: subcategoryId ?? _subcategoryId,
  postalCode: postalCode ?? _postalCode,
  paymentDetails: paymentDetails ?? _paymentDetails,
  lat: lat ?? _lat,
  lang: lang ?? _lang,
  uname: uname ?? _uname,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  deviceToken: deviceToken ?? _deviceToken,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  balance: balance ?? _balance,
  jsonData: jsonData ?? _jsonData,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get country => _country;
  String? get state => _state;
  String? get id => _id;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get email => _email;
  String? get countryCode => _countryCode;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get dob => _dob;
  String? get categoryId => _categoryId;
  String? get subcategoryId => _subcategoryId;
  String? get postalCode => _postalCode;
  PaymentDetails? get paymentDetails => _paymentDetails;
  String? get lat => _lat;
  String? get lang => _lang;
  String? get uname => _uname;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get deviceToken => _deviceToken;
  String? get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  String? get balance => _balance;
  JsonData? get jsonData => _jsonData;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = _country;
    map['state'] = _state;
    map['id'] = _id;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['email'] = _email;
    map['country_code'] = _countryCode;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['dob'] = _dob;
    map['category_id'] = _categoryId;
    map['subcategory_id'] = _subcategoryId;
    map['postal_code'] = _postalCode;
    if (_paymentDetails != null) {
      map['payment_details'] = _paymentDetails?.toJson();
    }
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['uname'] = _uname;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    if (_jsonData != null) {
      map['json_data'] = _jsonData?.toJson();
    }
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// can_travel : "Nationwide"
/// service_cities : "[]"
/// website : "sbsbbzb"
/// t_link : "sbshsjdjfjfllloo"
/// i_link : "lllkllllll"
/// l_link : "iiioooouuy"
/// equipments : "qqaasswwww"
/// birthday : "21/10/2022"
/// provide_services : "eueieiwkwk"
/// join_antsnest : "ssbbsnsnsn"
/// cat : "42"
/// sub_cat : "58"
/// amount : "9497"
/// hrs_day : "Hour"
/// language : "Italian"

class JsonData {
  JsonData({
      String? canTravel, 
      String? serviceCities, 
      String? website, 
      String? tLink, 
      String? iLink, 
      String? lLink, 
      String? equipments, 
      String? birthday, 
      String? provideServices, 
      String? joinAntsnest, 
      String? cat, 
      String? subCat, 
      String? amount, 
      String? hrsDay, 
      String? language,}){
    _canTravel = canTravel;
    _serviceCities = serviceCities;
    _website = website;
    _tLink = tLink;
    _iLink = iLink;
    _lLink = lLink;
    _equipments = equipments;
    _birthday = birthday;
    _provideServices = provideServices;
    _joinAntsnest = joinAntsnest;
    _cat = cat;
    _subCat = subCat;
    _amount = amount;
    _hrsDay = hrsDay;
    _language = language;
}

  JsonData.fromJson(dynamic json) {
    _canTravel = json['can_travel'];
    _serviceCities = json['service_cities'];
    _website = json['website'];
    _tLink = json['t_link'];
    _iLink = json['i_link'];
    _lLink = json['l_link'];
    _equipments = json['equipments'];
    _birthday = json['birthday'];
    _provideServices = json['provide_services'];
    _joinAntsnest = json['join_antsnest'];
    _cat = json['cat'];
    _subCat = json['sub_cat'];
    _amount = json['amount'];
    _hrsDay = json['hrs_day'];
    _language = json['language'];
  }
  String? _canTravel;
  String? _serviceCities;
  String? _website;
  String? _tLink;
  String? _iLink;
  String? _lLink;
  String? _equipments;
  String? _birthday;
  String? _provideServices;
  String? _joinAntsnest;
  String? _cat;
  String? _subCat;
  String? _amount;
  String? _hrsDay;
  String? _language;
JsonData copyWith({  String? canTravel,
  String? serviceCities,
  String? website,
  String? tLink,
  String? iLink,
  String? lLink,
  String? equipments,
  String? birthday,
  String? provideServices,
  String? joinAntsnest,
  String? cat,
  String? subCat,
  String? amount,
  String? hrsDay,
  String? language,
}) => JsonData(  canTravel: canTravel ?? _canTravel,
  serviceCities: serviceCities ?? _serviceCities,
  website: website ?? _website,
  tLink: tLink ?? _tLink,
  iLink: iLink ?? _iLink,
  lLink: lLink ?? _lLink,
  equipments: equipments ?? _equipments,
  birthday: birthday ?? _birthday,
  provideServices: provideServices ?? _provideServices,
  joinAntsnest: joinAntsnest ?? _joinAntsnest,
  cat: cat ?? _cat,
  subCat: subCat ?? _subCat,
  amount: amount ?? _amount,
  hrsDay: hrsDay ?? _hrsDay,
  language: language ?? _language,
);
  String? get canTravel => _canTravel;
  String? get serviceCities => _serviceCities;
  String? get website => _website;
  String? get tLink => _tLink;
  String? get iLink => _iLink;
  String? get lLink => _lLink;
  String? get equipments => _equipments;
  String? get birthday => _birthday;
  String? get provideServices => _provideServices;
  String? get joinAntsnest => _joinAntsnest;
  String? get cat => _cat;
  String? get subCat => _subCat;
  String? get amount => _amount;
  String? get hrsDay => _hrsDay;
  String? get language => _language;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_travel'] = _canTravel;
    map['service_cities'] = _serviceCities;
    map['website'] = _website;
    map['t_link'] = _tLink;
    map['i_link'] = _iLink;
    map['l_link'] = _lLink;
    map['equipments'] = _equipments;
    map['birthday'] = _birthday;
    map['provide_services'] = _provideServices;
    map['join_antsnest'] = _joinAntsnest;
    map['cat'] = _cat;
    map['sub_cat'] = _subCat;
    map['amount'] = _amount;
    map['hrs_day'] = _hrsDay;
    map['language'] = _language;
    return map;
  }

}

/// account_holder_name : "Rohit Jhariya"
/// acc_no : "1000000420"
/// bank_name : "PNB "
/// bank_addr : "Mulund "
/// ifsc_code : "PNB0000988"
/// pancard_no : "AHQPT4583Q"
/// sort_code : "1111"
/// routing_number : "1111"
/// paypal_email_id : "pt.quanticteq@gmail.com"
/// contact_number : "9867990355"
/// mode : "NEFT"
/// purpose : "Payout"
/// razorpay_id : "12345687897654231"

class PaymentDetails {
  PaymentDetails({
      String? accountHolderName, 
      String? accNo, 
      String? bankName, 
      String? bankAddr, 
      String? ifscCode, 
      String? pancardNo, 
      String? sortCode, 
      String? routingNumber, 
      String? paypalEmailId, 
      String? contactNumber, 
      String? mode, 
      String? purpose, 
      String? razorpayId,}){
    _accountHolderName = accountHolderName;
    _accNo = accNo;
    _bankName = bankName;
    _bankAddr = bankAddr;
    _ifscCode = ifscCode;
    _pancardNo = pancardNo;
    _sortCode = sortCode;
    _routingNumber = routingNumber;
    _paypalEmailId = paypalEmailId;
    _contactNumber = contactNumber;
    _mode = mode;
    _purpose = purpose;
    _razorpayId = razorpayId;
}

  PaymentDetails.fromJson(dynamic json) {
    _accountHolderName = json['account_holder_name'];
    _accNo = json['acc_no'];
    _bankName = json['bank_name'];
    _bankAddr = json['bank_addr'];
    _ifscCode = json['ifsc_code'];
    _pancardNo = json['pancard_no'];
    _sortCode = json['sort_code'];
    _routingNumber = json['routing_number'];
    _paypalEmailId = json['paypal_email_id'];
    _contactNumber = json['contact_number'];
    _mode = json['mode'];
    _purpose = json['purpose'];
    _razorpayId = json['razorpay_id'];
  }
  String? _accountHolderName;
  String? _accNo;
  String? _bankName;
  String? _bankAddr;
  String? _ifscCode;
  String? _pancardNo;
  String? _sortCode;
  String? _routingNumber;
  String? _paypalEmailId;
  String? _contactNumber;
  String? _mode;
  String? _purpose;
  String? _razorpayId;
PaymentDetails copyWith({  String? accountHolderName,
  String? accNo,
  String? bankName,
  String? bankAddr,
  String? ifscCode,
  String? pancardNo,
  String? sortCode,
  String? routingNumber,
  String? paypalEmailId,
  String? contactNumber,
  String? mode,
  String? purpose,
  String? razorpayId,
}) => PaymentDetails(  accountHolderName: accountHolderName ?? _accountHolderName,
  accNo: accNo ?? _accNo,
  bankName: bankName ?? _bankName,
  bankAddr: bankAddr ?? _bankAddr,
  ifscCode: ifscCode ?? _ifscCode,
  pancardNo: pancardNo ?? _pancardNo,
  sortCode: sortCode ?? _sortCode,
  routingNumber: routingNumber ?? _routingNumber,
  paypalEmailId: paypalEmailId ?? _paypalEmailId,
  contactNumber: contactNumber ?? _contactNumber,
  mode: mode ?? _mode,
  purpose: purpose ?? _purpose,
  razorpayId: razorpayId ?? _razorpayId,
);
  String? get accountHolderName => _accountHolderName;
  String? get accNo => _accNo;
  String? get bankName => _bankName;
  String? get bankAddr => _bankAddr;
  String? get ifscCode => _ifscCode;
  String? get pancardNo => _pancardNo;
  String? get sortCode => _sortCode;
  String? get routingNumber => _routingNumber;
  String? get paypalEmailId => _paypalEmailId;
  String? get contactNumber => _contactNumber;
  String? get mode => _mode;
  String? get purpose => _purpose;
  String? get razorpayId => _razorpayId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_holder_name'] = _accountHolderName;
    map['acc_no'] = _accNo;
    map['bank_name'] = _bankName;
    map['bank_addr'] = _bankAddr;
    map['ifsc_code'] = _ifscCode;
    map['pancard_no'] = _pancardNo;
    map['sort_code'] = _sortCode;
    map['routing_number'] = _routingNumber;
    map['paypal_email_id'] = _paypalEmailId;
    map['contact_number'] = _contactNumber;
    map['mode'] = _mode;
    map['purpose'] = _purpose;
    map['razorpay_id'] = _razorpayId;
    return map;
  }

}