/// response_code : "1"
/// msg : "My Bookings"
/// data : [{"email":"shivam15alphawizz@mailinator.com","mobile":"8319040004","username":"Shiva Sharma","id":"221","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"136","size":" ggh","status":"Confirm","a_status":"2","reason":null,"is_paid":"0","otp":"2196","amount":"300","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-06 05:11:44","subtotal":"300.00","tax_amt":"30.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":"","total":"330.00","updated_at":"2023-06-06 13:20:02","price":"300","res_name":"Fashion Store","res_desc":"We are providing good Service."},{"email":"shivam15alphawizz@mailinator.com","mobile":"8319040004","username":"Shiva Sharma","id":"220","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"136","size":" ggh","status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"2698","amount":"300","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-06 05:11:09","subtotal":"300.00","tax_amt":"30.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"330.00","updated_at":"2023-06-06 05:11:09","price":"300","res_name":"Fashion Store","res_desc":"We are providing good Service."},{"email":"shivam15alphawizz@mailinator.com","mobile":"8319040004","username":"Shiva Sharma","id":"219","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"130","size":" vg","status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"1749","amount":"900","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-05 13:34:34","subtotal":"900.00","tax_amt":"90.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"990.00","updated_at":"2023-06-06 05:12:24","price":"900","res_name":"WEDDING","res_desc":"Create timeless memories without the hassle. We’ll capture the moments you never want..."}]

class VendorOrderModel {
  VendorOrderModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  VendorOrderModel.fromJson(dynamic json) {
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
VendorOrderModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => VendorOrderModel(  responseCode: responseCode ?? _responseCode,
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

/// email : "shivam15alphawizz@mailinator.com"
/// mobile : "8319040004"
/// username : "Shiva Sharma"
/// id : "221"
/// date : "2023-06-07"
/// slot : " 05:00 PM"
/// user_id : "31"
/// res_id : "136"
/// size : " ggh"
/// status : "Confirm"
/// a_status : "2"
/// reason : null
/// is_paid : "0"
/// otp : "2196"
/// amount : "300"
/// txn_id : ""
/// p_date : null
/// address : " Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45"
/// address_id : "82"
/// payment_type : ""
/// created_at : "2023-06-06 05:11:44"
/// subtotal : "300.00"
/// tax_amt : "30.00"
/// tax : "0.00"
/// discount : "0.00"
/// addons : "0.00"
/// addon_service : ""
/// total : "330.00"
/// updated_at : "2023-06-06 13:20:02"
/// price : "300"
/// res_name : "Fashion Store"
/// res_desc : "We are providing good Service."

class Data {
  Data({
      String? email, 
      String? mobile, 
      String? username, 
      String? id, 
      String? date, 
      String? slot, 
      String? userId, 
      String? resId, 
      String? size, 
      String? status, 
      String? aStatus, 
      dynamic reason, 
      String? isPaid, 
      String? otp, 
      String? amount, 
      String? txnId, 
      dynamic pDate, 
      String? address, 
      String? addressId, 
      String? paymentType, 
      String? createdAt, 
      String? subtotal, 
      String? taxAmt, 
      String? tax, 
      String? discount, 
      String? addons, 
      String? addonService, 
      String? total, 
      String? currency,
      String? updatedAt,
      String? price, 
      String? resName, 
      String? resDesc,}){
    _email = email;
    currency =  currency;

    _mobile = mobile;
    _username = username;
    _id = id;
    _date = date;
    _slot = slot;
    _userId = userId;
    _resId = resId;
    _size = size;
    _status = status;
    _aStatus = aStatus;
    _reason = reason;
    _isPaid = isPaid;
    _otp = otp;
    _amount = amount;
    _txnId = txnId;
    _pDate = pDate;
    _address = address;
    _addressId = addressId;
    _paymentType = paymentType;
    _createdAt = createdAt;
    _subtotal = subtotal;
    _taxAmt = taxAmt;
    _tax = tax;
    _discount = discount;
    _addons = addons;
    _addonService = addonService;
    _total = total;
    _updatedAt = updatedAt;
    _price = price;
    _resName = resName;
    _resDesc = resDesc;
}

  Data.fromJson(dynamic json) {
    _email = json['email'];
    currency = json['currency'];
    _mobile = json['mobile'];
    _username = json['username'];
    _id = json['id'];
    _date = json['date'];
    _slot = json['slot'];
    _userId = json['user_id'];
    _resId = json['res_id'];
    _size = json['size'];
    _status = json['status'];
    _aStatus = json['a_status'];
    _reason = json['reason'];
    _isPaid = json['is_paid'];
    _otp = json['otp'];
    _amount = json['amount'];
    _txnId = json['txn_id'];
    _pDate = json['p_date'];
    _address = json['address'];
    _addressId = json['address_id'];
    _paymentType = json['payment_type'];
    _createdAt = json['created_at'];
    _subtotal = json['subtotal'];
    _taxAmt = json['tax_amt'];
    _tax = json['tax'];
    _discount = json['discount'];
    _addons = json['addons'];
    _addonService = json['addon_service'];
    _total = json['total'];
    _updatedAt = json['updated_at'];
    _price = json['price'].toString();
    _resName = json['res_name'];
    _resDesc = json['res_desc'];
  }
  String? _email;
  String? _mobile;
  String? _username;
  String? _id;
  String? currency ;
  String? _date;
  String? _slot;
  String? _userId;
  String? _resId;
  String? _size;
  String? _status;
  String? _aStatus;
  dynamic _reason;
  String? _isPaid;
  String? _otp;
  String? _amount;
  String? _txnId;
  dynamic _pDate;
  String? _address;
  String? _addressId;
  String? _paymentType;
  String? _createdAt;
  String? _subtotal;
  String? _taxAmt;
  String? _tax;
  String? _discount;
  String? _addons;
  String? _addonService;
  String? _total;
  String? _updatedAt;
  String? _price;
  String? _resName;
  String? _resDesc;
Data copyWith({  String? email,
  String? mobile,
  String? username,
  String? id,
  String? date,
  String? slot,
  String? userId,
  String? resId,
  String? size,
  String? status,
  String? aStatus,
  dynamic reason,
  String? isPaid,
  String? otp,
  String? amount,
  String? txnId,
  dynamic pDate,
  String? address,
  String? addressId,
  String? paymentType,
  String? createdAt,
  String? subtotal,
  String? taxAmt,
  String? tax,
  String? discount,
  String? addons,
  String? addonService,
  String? total,
  String? updatedAt,
  String? price,
  String? resName,
  String? resDesc,
}) => Data(  email: email ?? _email,
  mobile: mobile ?? _mobile,
  username: username ?? _username,
  id: id ?? _id,
  date: date ?? _date,
  slot: slot ?? _slot,
  userId: userId ?? _userId,
  resId: resId ?? _resId,
  size: size ?? _size,
  status: status ?? _status,
  aStatus: aStatus ?? _aStatus,
  reason: reason ?? _reason,
  isPaid: isPaid ?? _isPaid,
  otp: otp ?? _otp,
  amount: amount ?? _amount,
  txnId: txnId ?? _txnId,
  pDate: pDate ?? _pDate,
  address: address ?? _address,
  addressId: addressId ?? _addressId,
  paymentType: paymentType ?? _paymentType,
  createdAt: createdAt ?? _createdAt,
  subtotal: subtotal ?? _subtotal,
  taxAmt: taxAmt ?? _taxAmt,
  tax: tax ?? _tax,
  discount: discount ?? _discount,
  addons: addons ?? _addons,
  addonService: addonService ?? _addonService,
  total: total ?? _total,
  updatedAt: updatedAt ?? _updatedAt,
  price: price ?? _price,
  resName: resName ?? _resName,
  resDesc: resDesc ?? _resDesc,
);
  String? get email => _email;
  String? get mobile => _mobile;
  String? get username => _username;
  String? get id => _id;
  String? get date => _date;
  String? get slot => _slot;
  String? get userId => _userId;
  String? get resId => _resId;
  String? get size => _size;
  String? get status => _status;
  String? get aStatus => _aStatus;
  dynamic get reason => _reason;
  String? get isPaid => _isPaid;
  String? get otp => _otp;
  String? get amount => _amount;
  String? get txnId => _txnId;
  dynamic get pDate => _pDate;
  String? get address => _address;
  String? get addressId => _addressId;
  String? get paymentType => _paymentType;
  String? get createdAt => _createdAt;
  String? get subtotal => _subtotal;
  String? get taxAmt => _taxAmt;
  String? get tax => _tax;
  String? get discount => _discount;
  String? get addons => _addons;
  String? get addonService => _addonService;
  String? get total => _total;
  String? get updatedAt => _updatedAt;
  String? get price => _price;
  String? get resName => _resName;
  String? get resDesc => _resDesc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['currency']  = currency ;
    map['mobile'] = _mobile;
    map['username'] = _username;
    map['id'] = _id;
    map['date'] = _date;
    map['slot'] = _slot;
    map['user_id'] = _userId;
    map['res_id'] = _resId;
    map['size'] = _size;
    map['status'] = _status;
    map['a_status'] = _aStatus;
    map['reason'] = _reason;
    map['is_paid'] = _isPaid;
    map['otp'] = _otp;
    map['amount'] = _amount;
    map['txn_id'] = _txnId;
    map['p_date'] = _pDate;
    map['address'] = _address;
    map['address_id'] = _addressId;
    map['payment_type'] = _paymentType;
    map['created_at'] = _createdAt;
    map['subtotal'] = _subtotal;
    map['tax_amt'] = _taxAmt;
    map['tax'] = _tax;
    map['discount'] = _discount;
    map['addons'] = _addons;
    map['addon_service'] = _addonService;
    map['total'] = _total;
    map['updated_at'] = _updatedAt;
    map['price'] = _price;
    map['res_name'] = _resName;
    map['res_desc'] = _resDesc;
    return map;
  }

}