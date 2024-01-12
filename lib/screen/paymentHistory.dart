import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_path.dart';
import '../modal/PaymentHistoryModel.dart';
import '../token/app_token_data.dart';
import '../utils/colors.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {

  PaymentHistoryModel? paymentHistoryModel;

  getPaymentHistory()async{
    var userid = await MyToken.getUserID();
    var headers = {
      'Cookie': 'ci_session=5c0be2dcfdb80859af1a5e702f18beed806c9aa7'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}payments'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresult = await response.stream.bytesToString();
      final jsonresult = PaymentHistoryModel.fromJson(json.decode(finalresult));
      setState(() {
        paymentHistoryModel = jsonresult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200),(){
      return getPaymentHistory();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Payment History",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
        child:paymentHistoryModel == null ? Center(child: Image.asset(
          "images/icons/loader.gif")) : paymentHistoryModel!.data!.length ==  0 ? Center(child: Text("No data to show"),) : ListView.builder(
          shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: paymentHistoryModel!.data!.length,
            itemBuilder: (c,i){
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 5,
              child: Container(
              //  margin: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("User name"),
                        Text("${paymentHistoryModel!.data![i].userName}")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Service name"),
                        Text("${paymentHistoryModel!.data![i].serviceName}")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date"),
                        Text("${paymentHistoryModel!.data![i].date}")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Time Slot"),
                        Text("${paymentHistoryModel!.data![i].slot}")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("subTotal"),
                        Text("\u{20B9} ${double.parse(paymentHistoryModel!.data![i].price.toString()).toStringAsFixed(2)}")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax Amount"),
                        Text("\u{20B9} ${double.parse(paymentHistoryModel!.data![i].taxAmt.toString()).toStringAsFixed(2)}")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Final Total"),
                        Text("\u{20B9} ${double.parse(paymentHistoryModel!.data![i].total.toString()).toStringAsFixed(2)}"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status"),
                        Container(
                          height: 30,
                          width: 110,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor.PrimaryDark),
                            child: Center(child: Text("${paymentHistoryModel!.data![i].status}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)))
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
