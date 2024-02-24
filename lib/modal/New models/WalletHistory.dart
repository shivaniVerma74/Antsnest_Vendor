/// response_code : "1"
/// msg : "Wallet transactions"
/// data : [{"id":"80","user_id":"119","amount":"2500.00","convinience_fee":"0.00","final_payout":"0.00","transaction_id":"pay_M5GbbzZRtEBbH0","type":"wallet","credit_or_debit":"credit","status":"3","created_at":"2023-06-23 06:08:11","updated_at":"2023-06-23 06:08:11"},{"id":"81","user_id":"119","amount":"500.00","convinience_fee":"0.00","final_payout":"0.00","transaction_id":"812964838","type":"wallet","credit_or_debit":"debit","status":"1","created_at":"2023-06-23 06:09:16","updated_at":"2023-06-23 06:09:16"}]

class WalletHistory {
  WalletHistory({
      String? responseCode, 
      String? msg, 
      List<WalletHistoryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  WalletHistory.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WalletHistoryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<WalletHistoryData>? _data;
WalletHistory copyWith({  String? responseCode,
  String? msg,
  List<WalletHistoryData>? data,
}) => WalletHistory(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<WalletHistoryData>? get data => _data;

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

/// id : "80"
/// user_id : "119"
/// amount : "2500.00"
/// convinience_fee : "0.00"
/// final_payout : "0.00"
/// transaction_id : "pay_M5GbbzZRtEBbH0"
/// type : "wallet"
/// credit_or_debit : "credit"
/// status : "3"
/// created_at : "2023-06-23 06:08:11"
/// updated_at : "2023-06-23 06:08:11"

class WalletHistoryData {
  WalletHistoryData({
      String? id, 
      String? userId, 
      String? amount, 
      String? convinienceFee, 
      String? finalPayout, 
      String? transactionId, 
      String? type, 
      String? creditOrDebit, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _amount = amount;
    _convinienceFee = convinienceFee;
    _finalPayout = finalPayout;
    _transactionId = transactionId;
    _type = type;
    _creditOrDebit = creditOrDebit;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  WalletHistoryData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _amount = json['amount'];
    _convinienceFee = json['convinience_fee'];
    _finalPayout = json['final_payout'];
    _transactionId = json['transaction_id'];
    _type = json['type'];
    _creditOrDebit = json['credit_or_debit'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _amount;
  String? _convinienceFee;
  String? _finalPayout;
  String? _transactionId;
  String? _type;
  String? _creditOrDebit;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  WalletHistoryData copyWith({  String? id,
  String? userId,
  String? amount,
  String? convinienceFee,
  String? finalPayout,
  String? transactionId,
  String? type,
  String? creditOrDebit,
  String? status,
  String? createdAt,
  String? updatedAt,
}) => WalletHistoryData(  id: id ?? _id,
  userId: userId ?? _userId,
  amount: amount ?? _amount,
  convinienceFee: convinienceFee ?? _convinienceFee,
  finalPayout: finalPayout ?? _finalPayout,
  transactionId: transactionId ?? _transactionId,
  type: type ?? _type,
  creditOrDebit: creditOrDebit ?? _creditOrDebit,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get amount => _amount;
  String? get convinienceFee => _convinienceFee;
  String? get finalPayout => _finalPayout;
  String? get transactionId => _transactionId;
  String? get type => _type;
  String? get creditOrDebit => _creditOrDebit;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['amount'] = _amount;
    map['convinience_fee'] = _convinienceFee;
    map['final_payout'] = _finalPayout;
    map['transaction_id'] = _transactionId;
    map['type'] = _type;
    map['credit_or_debit'] = _creditOrDebit;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}