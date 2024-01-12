class PrivacyModel {
  String? status;
  String? msg;
  Setting? setting;

  PrivacyModel({this.status, this.msg, this.setting});

  PrivacyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    setting =
    json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.setting != null) {
      data['setting'] = this.setting!.toJson();
    }
    return data;
  }
}

class Setting {
  String? id;
  String? data;
  String? description;

  Setting({this.id, this.data, this.description});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['description'] = this.description;
    return data;
  }
}
