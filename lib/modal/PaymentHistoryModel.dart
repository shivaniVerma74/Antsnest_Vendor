/// response_code : "1"
/// msg : "Reported success"
/// data : [{"user_name":"Shiva Sharma","service_name":"Fashion Store","shipping_name":"New Address Name","shipping_mobile":"7896543211","price":"300","id":"221","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"136","size":" ggh","status":"Complete","a_status":"5","reason":null,"is_paid":"1","otp":"7829","amount":"300","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-06 05:11:44","subtotal":"300.00","tax_amt":"30.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":"","total":"330.00","updated_at":"2023-06-07 13:24:01"},{"user_name":"Shiva Sharma","service_name":"Fashion Store","shipping_name":"New Address Name","shipping_mobile":"7896543211","price":"300","id":"220","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"136","size":" ggh","status":"Cancelled by vendor","a_status":"4","reason":"Incorrect description Incorrect description\r\nIncorrect description\r\nIncorrect description\r\nIncorrect description\r\nIncorrect description","is_paid":"1","otp":"2698","amount":"300","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-06 05:11:09","subtotal":"300.00","tax_amt":"30.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"330.00","updated_at":"2023-06-07 13:24:01"},{"user_name":"Shiva Sharma","service_name":"WEDDING","shipping_name":"New Address Name","shipping_mobile":"7896543211","price":"900","id":"219","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"130","size":" vg","status":"Pending","a_status":"1","reason":null,"is_paid":"1","otp":"1749","amount":"900","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-05 13:34:34","subtotal":"900.00","tax_amt":"90.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"990.00","updated_at":"2023-06-07 13:24:01"}]

class PaymentHistoryModel {
  PaymentHistoryModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  PaymentHistoryModel.fromJson(dynamic json) {
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
PaymentHistoryModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => PaymentHistoryModel(  responseCode: responseCode ?? _responseCode,
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

/// user_name : "Shiva Sharma"
/// service_name : "Fashion Store"
/// shipping_name : "New Address Name"
/// shipping_mobile : "7896543211"
/// price : "300"
/// id : "221"
/// date : "2023-06-07"
/// slot : " 05:00 PM"
/// user_id : "31"
/// res_id : "136"
/// size : " ggh"
/// status : "Complete"
/// a_status : "5"
/// reason : null
/// is_paid : "1"
/// otp : "7829"
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
/// updated_at : "2023-06-07 13:24:01"

class Data {
  Data({
      String? userName, 
      String? serviceName, 
      String? shippingName, 
      String? shippingMobile, 
      String? price, 
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
      String? updatedAt,}){
    _userName = userName;
    _serviceName = serviceName;
    _shippingName = shippingName;
    _shippingMobile = shippingMobile;
    _price = price;
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
}

  Data.fromJson(dynamic json) {
    _userName = json['user_name'];
    _serviceName = json['service_name'];
    _shippingName = json['shipping_name'];
    _shippingMobile = json['shipping_mobile'];
    _price = json['price'];
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
  }
  String? _userName;
  String? _serviceName;
  String? _shippingName;
  String? _shippingMobile;
  String? _price;
  String? _id;
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
Data copyWith({  String? userName,
  String? serviceName,
  String? shippingName,
  String? shippingMobile,
  String? price,
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
}) => Data(  userName: userName ?? _userName,
  serviceName: serviceName ?? _serviceName,
  shippingName: shippingName ?? _shippingName,
  shippingMobile: shippingMobile ?? _shippingMobile,
  price: price ?? _price,
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
);
  String? get userName => _userName;
  String? get serviceName => _serviceName;
  String? get shippingName => _shippingName;
  String? get shippingMobile => _shippingMobile;
  String? get price => _price;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['service_name'] = _serviceName;
    map['shipping_name'] = _shippingName;
    map['shipping_mobile'] = _shippingMobile;
    map['price'] = _price;
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
    return map;
  }

}