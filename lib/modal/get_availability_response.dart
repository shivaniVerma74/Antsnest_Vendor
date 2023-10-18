class GetAvailabilityResponse {
  bool? status;
  String? message;
  List<AvailabilityData>? data;

  GetAvailabilityResponse({this.status, this.message, this.data});

  GetAvailabilityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AvailabilityData>[];
      json['data'].forEach((v) {
        data!.add(new AvailabilityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailabilityData {
  String? id;
  String? vId;
  String? fromTime;
  String? toTime;
  String? day;
  String? isSet;

  AvailabilityData({this.id, this.vId, this.fromTime, this.toTime, this.day, this.isSet});

  AvailabilityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vId = json['v_id'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    day = json['day'];
    isSet = json['is_set'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['v_id'] = this.vId;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['day'] = this.day;
    data['is_set'] = this.isSet;
    return data;
  }
}
