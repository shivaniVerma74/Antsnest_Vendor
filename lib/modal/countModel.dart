// To parse this JSON data, do
//
//     final countModel = countModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CountModel countModelFromJson(String str) =>
    CountModel.fromJson(json.decode(str));

String countModelToJson(CountModel data) => json.encode(data.toJson());

class CountModel {
  String responseCode;
  String status;
  Data data;

  CountModel({
    required this.responseCode,
    required this.status,
    required this.data,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) => CountModel(
        responseCode: json["response_code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Bookings bookings;
  Bookings services;
  Bookings notifications;
  bool is_active;

  Data(
      {required this.bookings,
      required this.services,
      required this.notifications,
      required this.is_active});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookings: Bookings.fromJson(json["bookings"]),
        services: Bookings.fromJson(json["services"]),
        notifications: Bookings.fromJson(json["notifications"]),
        is_active: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "bookings": bookings.toJson(),
        "services": services.toJson(),
        "notifications": notifications.toJson(),
        "is_active": is_active,
      };
}

class Bookings {
  String total;

  Bookings({
    required this.total,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
