class MessageChatModel {
  bool? status;
  List<Html>? html;
  int? count;

  MessageChatModel({this.status, this.html, this.count});

  MessageChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['html'] != null) {
      html = <Html>[];
      json['html'].forEach((v) {
        html!.add(new Html.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.html != null) {
      data['html'] = this.html!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Html {
  String? userName;
  String? id;
  String? message;
  String? messageType;
  String? senderId;
  String? senderType;
  String? bookingId;
  String? type;
  String? isRead;
  String? code;
  String? createdAt;
  String? updatedAt;

  Html(
      {this.userName,
        this.id,
        this.message,
        this.messageType,
        this.senderId,
        this.senderType,
        this.bookingId,
        this.type,
        this.isRead,
        this.code,
        this.createdAt,
        this.updatedAt});

  Html.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    id = json['id'];
    message = json['message'];
    messageType = json['message_type'];
    senderId = json['sender_id'];
    senderType = json['sender_type'];
    bookingId = json['booking_id'];
    type = json['type'];
    isRead = json['is_read'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['id'] = this.id;
    data['message'] = this.message;
    data['message_type'] = this.messageType;
    data['sender_id'] = this.senderId;
    data['sender_type'] = this.senderType;
    data['booking_id'] = this.bookingId;
    data['type'] = this.type;
    data['is_read'] = this.isRead;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
