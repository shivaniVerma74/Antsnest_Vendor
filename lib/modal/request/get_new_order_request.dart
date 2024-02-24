class GetNewOrderRequest {
  String userId;
  String ?bookingId;
  GetNewOrderRequest({required this.userId,this.bookingId});

  Map<String, dynamic> tojson() => {
        "user_id": this.userId,
    "booking_id":this.bookingId??""
      };
}
