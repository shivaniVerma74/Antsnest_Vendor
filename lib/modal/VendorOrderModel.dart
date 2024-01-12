/// response_code : "1"
/// msg : "My Bookings"
/// data : [{"email":"shivam15alphawizz@mailinator.com","mobile":"8319040004","username":"Shiva Sharma","id":"221","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"136","size":" ggh","status":"Confirm","a_status":"2","reason":null,"is_paid":"0","otp":"2196","amount":"300","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-06 05:11:44","subtotal":"300.00","tax_amt":"30.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":"","total":"330.00","updated_at":"2023-06-06 13:20:02","price":"300","res_name":"Fashion Store","res_desc":"We are providing good Service."},{"email":"shivam15alphawizz@mailinator.com","mobile":"8319040004","username":"Shiva Sharma","id":"220","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"136","size":" ggh","status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"2698","amount":"300","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-06 05:11:09","subtotal":"300.00","tax_amt":"30.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"330.00","updated_at":"2023-06-06 05:11:09","price":"300","res_name":"Fashion Store","res_desc":"We are providing good Service."},{"email":"shivam15alphawizz@mailinator.com","mobile":"8319040004","username":"Shiva Sharma","id":"219","date":"2023-06-07","slot":" 05:00 PM","user_id":"31","res_id":"130","size":" vg","status":"Pending","a_status":"1","reason":null,"is_paid":"0","otp":"1749","amount":"900","txn_id":"","p_date":null,"address":" Vijay Nagar, Indore, Madhya Pradesh 452010, India, 45","address_id":"82","payment_type":"","created_at":"2023-06-05 13:34:34","subtotal":"900.00","tax_amt":"90.00","tax":"0.00","discount":"0.00","addons":"0.00","addon_service":null,"total":"990.00","updated_at":"2023-06-06 05:12:24","price":"900","res_name":"WEDDING","res_desc":"Create timeless memories without the hassle. We’ll capture the moments you never want..."}]

class VendorOrderModel {
  String? responseCode;
  String? msg;
  List<Data>? data;

  VendorOrderModel({this.responseCode, this.msg, this.data});

  VendorOrderModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? email;
  String? profilePic;
  String? mobile;
  String? username;
  String? id;
  String? date;
  String? slot;
  String? userId;
  String? resId;
  String? size;
  String? status;
  String? aStatus;
  Null? reason;
  String? isPaid;
  String? otp;
  String? amount;
  String? txnId;
  String? pDate;
  String? address;
  String? addressId;
  String? paymentType;
  String? subtotal;
  String? taxAmt;
  String? tax;
  String? discount;
  String? addons;
  String? addonService;
  String? total;
  String? currency;
  String? createdAt;
  String? updatedAt;
  String? price;
  String? resName;
  String? resDesc;

  Data(
      {this.email,
        this.profilePic,
        this.mobile,
        this.username,
        this.id,
        this.date,
        this.slot,
        this.userId,
        this.resId,
        this.size,
        this.status,
        this.aStatus,
        this.reason,
        this.isPaid,
        this.otp,
        this.amount,
        this.txnId,
        this.pDate,
        this.address,
        this.addressId,
        this.paymentType,
        this.subtotal,
        this.taxAmt,
        this.tax,
        this.discount,
        this.addons,
        this.addonService,
        this.total,
        this.currency,
        this.createdAt,
        this.updatedAt,
        this.price,
        this.resName,
        this.resDesc});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    profilePic = json['profile_pic'];
    mobile = json['mobile'];
    username = json['username'];
    id = json['id'];
    date = json['date'];
    slot = json['slot'];
    userId = json['user_id'];
    resId = json['res_id'];
    size = json['size'];
    status = json['status'];
    aStatus = json['a_status'];
    reason = json['reason'];
    isPaid = json['is_paid'];
    otp = json['otp'];
    amount = json['amount'];
    txnId = json['txn_id'];
    pDate = json['p_date'];
    address = json['address'];
    addressId = json['address_id'];
    paymentType = json['payment_type'];
    subtotal = json['subtotal'];
    taxAmt = json['tax_amt'];
    tax = json['tax'];
    discount = json['discount'];
    addons = json['addons'];
    addonService = json['addon_service'];
    total = json['total'];
    currency = json['currency'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    resName = json['res_name'];
    resDesc = json['res_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['profile_pic'] = this.profilePic;
    data['mobile'] = this.mobile;
    data['username'] = this.username;
    data['id'] = this.id;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['user_id'] = this.userId;
    data['res_id'] = this.resId;
    data['size'] = this.size;
    data['status'] = this.status;
    data['a_status'] = this.aStatus;
    data['reason'] = this.reason;
    data['is_paid'] = this.isPaid;
    data['otp'] = this.otp;
    data['amount'] = this.amount;
    data['txn_id'] = this.txnId;
    data['p_date'] = this.pDate;
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    data['payment_type'] = this.paymentType;
    data['subtotal'] = this.subtotal;
    data['tax_amt'] = this.taxAmt;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['addons'] = this.addons;
    data['addon_service'] = this.addonService;
    data['total'] = this.total;
    data['currency'] = this.currency;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['res_name'] = this.resName;
    data['res_desc'] = this.resDesc;
    return data;
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
