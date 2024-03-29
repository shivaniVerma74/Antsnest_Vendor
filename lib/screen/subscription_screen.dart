import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../api/api_path.dart';
import '../modal/plans_model.dart';
import '../modal/purchase_plan_model.dart';
import '../token/app_token_data.dart';
import '../utils/colors.dart';
import 'dart:math' as math;

import '../utils/utility_hlepar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  Razorpay _razorpay = Razorpay();
  String? email;
  String? userId;
  String? phone;
  int? price;
  var amounts;
  var planT;
  var planI;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserDetails();
    //UNCOMMENT
    Future.delayed(Duration(milliseconds: 200), () {
      return getPlans();
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); //UNCOMMENT
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Subscription Plans"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // shrinkWrap: true,
          children: [
            SizedBox(
              height: 50,
            ),
            plansModel == null
                ? Center(child: Image.asset("images/icons/loader.gif"))
                : CarouselSlider(
                    options: CarouselOptions(
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlay: true,
                      aspectRatio: .5,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                    items: plansModel!.data!
                        .map<Widget>((item) => Container(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Card(
                                              elevation: 5,
                                              child: Column(
                                                children: [
                                                  // ListTile(
                                                  //   title: Center(
                                                  //     child: Text(
                                                  //       "${item.title}",
                                                  //       style: TextStyle(
                                                  //           fontWeight:
                                                  //           FontWeight.bold),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  item.price == 0
                                                      ? SizedBox.shrink()
                                                      : Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            height: 110,
                                                            width: 110,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            alignment: Alignment
                                                                .topRight,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                stops: [.5, .5],
                                                                begin: Alignment
                                                                    .bottomLeft,
                                                                end: Alignment
                                                                    .topRight,
                                                                colors: [
                                                                  Colors
                                                                      .transparent,
                                                                  Colors
                                                                      .red, // top Right part
                                                                ],
                                                              ),
                                                            ),
                                                            child: Transform.rotate(
                                                                angle: math.pi / 4,
                                                                // alignment: FractionalOffset.topRight,
                                                                // transform: new Matrix4.identity()..rotateZ(20 * 10.1415927 / 120),
                                                                child: Text(
                                                                  "AN\nRecommended",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "${item.title}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "₹ ${item.price.toString()}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24,
                                                        color: AppColor()
                                                            .colorPrimary()),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "${item.timeText}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  // Text(
                                                  //   "${item.planType}",
                                                  //   style: TextStyle(
                                                  //       fontWeight:
                                                  //       FontWeight.w600),
                                                  // ),
                                                  Divider(
                                                    color: AppColor()
                                                        .colorPrimary(),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 20,
                                                  // ),
                                                  // Container(
                                                  //   height: 200,
                                                  //   child: Image.network(item.image!,
                                                  //     fit: BoxFit.cover,
                                                  //   ),
                                                  // ),

                                                  ListView.builder(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 10),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          item.json?.length ??
                                                              0,
                                                      itemBuilder: (c, i) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          child: Row(
                                                            children: [
                                                              item.json![i]
                                                                          .isTrue ==
                                                                      "0"
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              border: Border.all(color: Colors.black)),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .clear,
                                                                        size:
                                                                            13,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              100),
                                                                          border:
                                                                              Border.all(color: Colors.black)),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                            13,
                                                                      ),
                                                                    ),
                                                              SizedBox(
                                                                width: 6,
                                                              ),
                                                              Text(
                                                                  "${item.json![i].title}")
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColor()
                                                                .colorPrimary())),
                                                onPressed: () async {
                                                  var userId =
                                                      await MyToken.getUserID();
                                                  planI = item.id.toString();
                                                  if (item.price == 0 ||
                                                      item.price == "0") {
                                                    // Fluttertoast.showToast(msg: "Plan amount is not valid");
                                                    purchasePlan(
                                                        "$userId", planI, "");
                                                  } else {
                                                    checkOut(item.price);
                                                  }
                                                  // var userId = await MyToken.getUserID();
                                                  // print("purchase Plan");
                                                  // // print("purchase Plan2 ==== $price");
                                                  // // price = int.parse(item.price.toString()) * 100;
                                                  // amounts = item.price;
                                                  // print("purchase Plan3 ==== $amounts");
                                                  // planI = item.id.toString();
                                                  // if(item.price.toString() == "0" || item.price == 0){
                                                  //   purchasePlan(userId.toString(),planI.toString(),"");
                                                  // }
                                                  // else{
                                                  //   checkOut(amounts);
                                                  // }
                                                },
                                                child: Text("Purchase"))
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
      // body: FutureBuilder(
      //     future: getPlans(),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       print("checking snapshot data  ${snapshot}");
      //       if (snapshot.hasData) {
      //         PlansModel data = snapshot.data;
      //         return SingleChildScrollView(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             // shrinkWrap: true,
      //             children: [
      //               SizedBox(height: 50,),
      //               CarouselSlider(
      //                 options: CarouselOptions(
      //                   autoPlayInterval: const Duration(seconds: 8),
      //                   autoPlay: true,
      //                   aspectRatio: .5,
      //                   enlargeCenterPage: true,
      //                   enlargeStrategy: CenterPageEnlargeStrategy.height,
      //                 ),
      //                 items: data.data!
      //                     .map<Widget>((item) => Container(
      //                   child: Container(
      //                     margin: EdgeInsets.all(5.0),
      //                     child: ClipRRect(
      //                         borderRadius:
      //                         BorderRadius.all(Radius.circular(5.0)),
      //                         child: Stack(
      //                           children: <Widget>[
      //                             Column(
      //                               children: [
      //                                 Card(
      //                                   elevation: 5,
      //                                   child: Column(
      //                                     children: [
      //                                       // ListTile(
      //                                       //   title: Center(
      //                                       //     child: Text(
      //                                       //       "${item.title}",
      //                                       //       style: TextStyle(
      //                                       //           fontWeight:
      //                                       //           FontWeight.bold),
      //                                       //     ),
      //                                       //   ),
      //                                       // ),
      //                                     item.price == 0 ? SizedBox.shrink() :  Align(
      //                                         alignment: Alignment.topRight,
      //                                         child: Container(
      //                                         height: 110,
      //                                         width: 110,
      //                                           padding: EdgeInsets.only(top: 15),
      //                                           alignment: Alignment.topRight,
      //                                             decoration: BoxDecoration(
      //                                               gradient: LinearGradient(
      //                                                 stops: [.5, .5],
      //                                                 begin: Alignment.bottomLeft,
      //                                                 end: Alignment.topRight,
      //                                                 colors: [
      //                                                   Colors.transparent,
      //                                                   Colors.red, // top Right part
      //                                                 ],
      //                                               ),
      //                                             ),
      //                                           child: Transform.rotate(
      //                                               angle: math.pi / 4,
      //                                               // alignment: FractionalOffset.topRight,
      //                                               // transform: new Matrix4.identity()..rotateZ(20 * 10.1415927 / 120),
      //                                               child: Text("AN\nRecommended",style: TextStyle(color: Colors.white,fontSize: 15,),textAlign: TextAlign.center,)),
      //                                         ),
      //                                       ),
      //                                       SizedBox(
      //                                         height: 20,
      //                                       ),
      //                                       Text(
      //                                         "${item.title}",
      //                                         style: TextStyle(
      //                                             fontWeight:
      //                                             FontWeight.bold),
      //                                       ),
      //                                       SizedBox(
      //                                         height: 10,
      //                                       ),
      //                                       Text("₹ ${item.price.toString()}" , style: TextStyle(
      //                                           fontWeight: FontWeight.bold , fontSize: 24,
      //                                           color: AppColor().colorPrimary()
      //                                       ),),
      //                                       SizedBox(
      //                                         height: 10,
      //                                       ),
      //                                       Text(
      //                                         "${item.timeText}",
      //                                         style: TextStyle(
      //                                             fontWeight:
      //                                             FontWeight.w600),
      //                                       ),
      //                                       // SizedBox(
      //                                       //   height: 10,
      //                                       // ),
      //                                       // Text(
      //                                       //   "${item.planType}",
      //                                       //   style: TextStyle(
      //                                       //       fontWeight:
      //                                       //       FontWeight.w600),
      //                                       // ),
      //                                       Divider(
      //                                         color: AppColor()
      //                                             .colorPrimary(),
      //                                       ),
      //                                       // SizedBox(
      //                                       //   height: 20,
      //                                       // ),
      //                                       // Container(
      //                                       //   height: 200,
      //                                       //   child: Image.network(item.image!,
      //                                       //     fit: BoxFit.cover,
      //                                       //   ),
      //                                       // ),
      //
      //                                       ListView.builder(
      //                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      //                                           shrinkWrap: true,
      //                                           itemCount: item.json!.length,
      //                                           itemBuilder: (c,i){
      //                                         return Padding(
      //                                           padding: EdgeInsets.only(bottom: 5),
      //                                           child: Row(
      //                                             children: [
      //                                              item.json![i].isTrue == 0 ? Container(
      //                                                 decoration:BoxDecoration(
      //                                                   border: Border.all(color: Colors.black)
      //                                                 ),
      //                                                 child: Icon(Icons.clear,size: 13,),) :
      //                                                  Container(
      //                                                    decoration:BoxDecoration(
      //                                                      borderRadius: BorderRadius.circular(100),
      //                                                      border: Border.all(color: Colors.black)
      //                                                    ),
      //                                                    child: Icon(Icons.check,size: 13,),
      //                                                  ),
      //                                               SizedBox(width: 6,),
      //                                               Text("${item.json![i].title}")
      //                                             ],
      //                                           ),
      //                                         );
      //                                       }),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 ElevatedButton(
      //                                     style: ButtonStyle(
      //                                         backgroundColor:
      //                                         MaterialStateProperty
      //                                             .all(AppColor()
      //                                             .colorPrimary())),
      //                                     onPressed: ()async{
      //                                       if(item.price == 0 || item.price == "0" ){
      //                                        // Fluttertoast.showToast(msg: "Plan amount is not valid");
      //                                         purchasePlan("$userId", planI,"");
      //                                       }
      //                                       else{
      //                                         checkOut(item.price);
      //                                       }
      //                                       // var userId = await MyToken.getUserID();
      //                                       // print("purchase Plan");
      //                                       // // print("purchase Plan2 ==== $price");
      //                                       // // price = int.parse(item.price.toString()) * 100;
      //                                       // amounts = item.price;
      //                                       // print("purchase Plan3 ==== $amounts");
      //                                       // planI = item.id.toString();
      //                                       // if(item.price.toString() == "0" || item.price == 0){
      //                                       //   purchasePlan(userId.toString(),planI.toString(),"");
      //                                       // }
      //                                       // else{
      //                                       //   checkOut(amounts);
      //                                       // }
      //                                     },
      //                                     child: Text("Purchase"))
      //                               ],
      //                             )
      //                           ],
      //                         )),
      //                   ),
      //                 ))
      //                     .toList(),
      //               ),
      //             ],
      //           ),
      //         );
      //       } else if (snapshot.hasError) {
      //         print("ERROR ==== ${snapshot.error}");
      //         return Center(child: Icon(Icons.error_outline));
      //       } else {
      //         return Center(child: Image.asset("images/icons/loader.gif"));
      //       }
      //     }),
    );
  }

  PlansModel? plansModel;

  getPlans() async {
    var request =
        http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_plans'));
    http.StreamedResponse response = await request.send();
    print("sfsfsfs${request}");
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      var finalResponse = PlansModel.fromJson(json.decode(str));
      setState(() {
        plansModel = finalResponse;
      });
      log(finalResponse.toString());
      //return PlansModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  checkOut(price) {
    print(price);
    var options = {
      'key': "rzp_test_CpvP0qcfS4CSJD",
      'amount': price * 100,
      'currency': 'INR',
      'name': 'Antsnest',
      'description': '',
      // 'prefill': {'contact': userMobile, 'email': userEmail},
    };
    print("OPTIONS ===== $options");
    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var userId = await MyToken.getUserID();
    UtilityHlepar.getToast("Payment Successful");
    purchasePlan("$userId", planI, "${response.paymentId}");
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("FAILURE === ${response.message}");
    // UtilityHlepar.getToast("${response.message}");
    UtilityHlepar.getToast("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  Future purchasePlan(userId, planId, txnId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}purchase_plan'));
    request.fields.addAll({
      'user_id': '$userId',
      'plan_id': '$planId',
      'transaction_id': '$txnId'
    });

    print(request);
    print("PURCHACE PLAN PARAM" + request.fields.toString());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = PurchasePlanModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        UtilityHlepar.getToast("Plan Purchases Successfully!");
        Navigator.pop(context, true);
      }
      return PurchasePlanModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
}
