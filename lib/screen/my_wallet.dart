import 'dart:async';
import 'dart:convert';
import 'package:fixerking/screen/testScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../api/api_helper/ApiList.dart';
import '../api/api_helper/auth_helper.dart';
import '../api/api_path.dart';
import '../api/api_services.dart';
import '../modal/CurrencyModel.dart';
import '../modal/New models/WalletHistory.dart';
import '../modal/purchase_plan_model.dart';
import '../modal/request/get_profile_request.dart';
import '../modal/response/get_profile_response.dart';
import '../token/app_token_data.dart';
import '../utility_widget/utility_widget.dart';
import '../utils/colors.dart';
import '../utils/toast_string.dart';
import '../utils/utility_hlepar.dart';
import 'package:http/http.dart' as http;

class WalletScreen extends StatefulWidget {
  String walletAmount;

  WalletScreen({required this.walletAmount, Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamController<GetProfileResponse> profileResponseStram =
      StreamController();
  Razorpay _razorpay = Razorpay();
  bool buttonLogin = false;
  StateSetter? dialogState;
  TextEditingController amtC = TextEditingController();
  TextEditingController accountNoC = TextEditingController();
  TextEditingController bankNameC = TextEditingController();
  TextEditingController accountNameC = TextEditingController();
  TextEditingController ifscC = TextEditingController();
  TextEditingController msgC = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var planI;
  List<WalletHistoryData> walletHistory = [];

  String? validateField(String value, String? msg) {
    if (value.length == 0)
      return msg;
    else
      return null;
  }

  _showDialog() async {
    bool payWarn = false;
    await dialogAnimate(context, StatefulBuilder(
        builder: (BuildContext context1, StateSetter setStater) {
      dialogState = setStater;
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                child: Text(
                  "Add Money",
                  // getTranslated(context, 'ADD_MONEY')!,
                  style: Theme.of(this.context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColor().colorTextPrimary()),
                  //  Theme.of(context).colorScheme.fontColor),
                ),
              ),
              Divider(color: AppColor().colorTextSecondary()),
              Form(
                key: _formKey,
                child: Flexible(
                  child: SingleChildScrollView(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Amount",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: amtC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Account Name",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: accountNameC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Account No.",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: accountNoC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Bank Name",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: bankNameC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "IFSC Coe",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: ifscC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: new InputDecoration(
                                hintText: "Message",
                                //(context, 'MSG'),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        // Theme.of(context)
                                        //     .colorScheme
                                        //     .lightBlack,
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: msgC,
                            )),
                        //Divider(),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                        //   child: Text("Select Payment Method",
                        //     //getTranslated(context, 'SELECT_PAYMENT')!,
                        //     style: Theme.of(context).textTheme.subtitle2,
                        //   ),
                        // ),
                        Divider(),
                        payWarn
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "Please Select Payment Method..!!",
                                  //  getTranslated(context, 'payWarning')!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            : Container(),

                        // paypal == null
                        //     ? Center(child: CircularProgressIndicator())
                        //     : Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: getPayList()),
                      ])),
                ),
              )
            ]),
        actions: <Widget>[
          new ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: AppColor().colorPrimary()),
              child: Text(
                "Cancel",
                // getTranslated(context, 'CANCEL')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    // color: AppColor().colorTextSecondary(),
                    // Theme.of(context).colorScheme.lightBlack,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // amtC.clear();
                msgC.clear();
                Navigator.pop(context1);
              }),
          new ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: AppColor().colorPrimary()),
              child: Text(
                "Send",
                // getTranslated(context, 'SEND')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    color: AppColor().colorTextPrimary(),
                    //Theme.of(context).colorScheme.fontColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                final form = _formKey.currentState!;
                if (form.validate() && amtC.text != '0') {
                  form.save();
                  print("purchase Plan");
                  // print("purchase Plan2 ==== $price");
                  // price = int.parse(item.price.toString()) * 100;
                  checkOut();
                  // amtC.clear();
                  msgC.clear();
                  // if (payMethod == null) {
                  //   dialogState!(() {
                  //     payWarn = true;
                  //   });
                  // } else {
                  //   if (payMethod!.trim() ==
                  //       getTranslated(context, 'STRIPE_LBL')!.trim()) {
                  //     stripePayment(int.parse(amtC.text));
                  //   } else if (payMethod!.trim() ==
                  //       getTranslated(context, 'RAZORPAY_LBL')!.trim())
                  //     razorpayPayment(double.parse(amtC.text));
                  //   else if (payMethod!.trim() ==
                  //       "Pay Now"){
                  //     CashFreeHelper cashFreeHelper = new CashFreeHelper(amtC.text.toString(), context, (result){
                  //       print(result['txMsg']);
                  //       // setSnackbar(result['txMsg'], _checkscaffoldKey);
                  //       if(result['txStatus']=="SUCCESS"){
                  //         sendRequest(result['signature'], "CashFree");
                  //       }else{
                  //         setSnackbar1("Transaction cancelled and failed",context );
                  //       }
                  //       //placeOrder(result.paymentId);
                  //     });
                  //
                  //     cashFreeHelper.init();
                  //   }
                  //   else if (payMethod!.trim() ==
                  //       getTranslated(context, 'PAYSTACK_LBL')!.trim())
                  //     paystackPayment(context, int.parse(amtC.text));
                  //   else if (payMethod == getTranslated(context, 'PAYTM_LBL'))
                  //     paytmPayment(double.parse(amtC.text));
                  //   else if (payMethod ==
                  //       getTranslated(context, 'PAYPAL_LBL')) {
                  //     paypalPayment((amtC.text).toString());
                  //   } else if (payMethod ==
                  //       getTranslated(context, 'FLUTTERWAVE_LBL'))
                  //     flutterwavePayment(amtC.text);
                  Navigator.pop(context1);
                }
              }
              // }
              )
        ],
      );
    }));
  }

  void showAlertDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: AppColor.PrimaryDark, width: 5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  size: 50,
                  color: Colors.green,
                ),
                SizedBox(
                    height:
                        10), // Provides spacing between the icon and the text.
                Text(
                  "Alert",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColor.PrimaryDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height:
                        20), // Provides spacing between the warning text and the message.
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: AppColor.PrimaryDark.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: AppColor.PrimaryDark)),
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: AppColor.PrimaryDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                // ElevatedButton(
                //   onPressed: () => Navigator.of(context).pop(),
                //   child: Text('OK'),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.red, // Button color
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showDialog1() async {
    bool payWarn = false;
    await dialogAnimate(context, StatefulBuilder(
        builder: (BuildContext context1, StateSetter setStater) {
      dialogState = setStater;
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                child: Text(
                  "Withdrawal Money",
                  // getTranslated(context, 'ADD_MONEY')!,
                  style: Theme.of(this.context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColor().colorTextPrimary()),
                  //  Theme.of(context).colorScheme.fontColor),
                ),
              ),
              Divider(color: AppColor().colorTextSecondary()),
              Form(
                key: _formKey,
                child: Flexible(
                  child: SingleChildScrollView(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Amount",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: amountController,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Account Holder Name",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: accountNameC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Account No.",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: accountNoC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "Bank Name",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: bankNameC,
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  validateField(val!, "This Field is Required"
                                      //getTranslated(context, 'FIELD_REQUIRED')
                                      ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: AppColor().colorTextPrimary(),
                              ),
                              decoration: InputDecoration(
                                hintText: "IFSC Code",
                                // getTranslated(context, "AMOUNT"),
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: AppColor().colorTextSecondary(),
                                        fontWeight: FontWeight.normal),
                              ),
                              controller: ifscC,
                            )),
                        //Divider(),
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
                        //   child: Text("Select Payment Method",
                        //     //getTranslated(context, 'SELECT_PAYMENT')!,
                        //     style: Theme.of(context).textTheme.subtitle2,
                        //   ),
                        // ),
                        Divider(),
                        payWarn
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "Please Select Payment Method..!!",
                                  //  getTranslated(context, 'payWarning')!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            : Container(),
                        // paypal == null
                        //     ? Center(child: CircularProgressIndicator())
                        //     : Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: getPayList()),
                      ])),
                ),
              )
            ]),
        actions: <Widget>[
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: AppColor().colorPrimary()),
              child: Text(
                "Cancel",
                // getTranslated(context, 'CANCEL')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    // color: AppColor().colorTextSecondary(),
                    // Theme.of(context).colorScheme.lightBlack,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                amountController.clear();
                msgC.clear();
                Navigator.pop(context1);
              }),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(primary: AppColor().colorPrimary()),
              child: Text(
                "Send",
                // getTranslated(context, 'SEND')!,
                style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                    color: AppColor().colorTextPrimary(),
                    //Theme.of(context).colorScheme.fontColor,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                final form = _formKey.currentState!;
                if (form.validate() && amtC.text != '0') {
                  form.save();
                  print("purchase Plan");
                  //  checkout1();
                  withdrawelRequest();
                  //sendMoeny();
                  //   amtC.clear();
                  // if (payMethod == null) {
                  //   dialogState!(() {
                  //     payWarn = true;
                  //   });
                  // } else {
                  //   if (payMethod!.trim() ==
                  //       getTranslated(context, 'STRIPE_LBL')!.trim()) {
                  //     stripePayment(int.parse(amtC.text));
                  //   } else if (payMethod!.trim() ==
                  //       getTranslated(context, 'RAZORPAY_LBL')!.trim())
                  //     razorpayPayment(double.parse(amtC.text));
                  //   else if (payMethod!.trim() ==
                  //       "Pay Now"){
                  //     CashFreeHelper cashFreeHelper = new CashFreeHelper(amtC.text.toString(), context, (result){
                  //       print(result['txMsg']);
                  //       // setSnackbar(result['txMsg'], _checkscaffoldKey);
                  //       if(result['txStatus']=="SUCCESS"){
                  //         sendRequest(result['signature'], "CashFree");
                  //       }else{
                  //         setSnackbar1("Transaction cancelled and failed",context );
                  //       }
                  //       //placeOrder(result.paymentId);
                  //     });
                  //
                  //     cashFreeHelper.init();
                  //   }
                  //   else if (payMethod!.trim() ==
                  //       getTranslated(context, 'PAYSTACK_LBL')!.trim())
                  //     paystackPayment(context, int.parse(amtC.text));
                  //   else if (payMethod == getTranslated(context, 'PAYTM_LBL'))
                  //     paytmPayment(double.parse(amtC.text));
                  //   else if (payMethod ==
                  //       getTranslated(context, 'PAYPAL_LBL')) {
                  //     paypalPayment((amtC.text).toString());
                  //   } else if (payMethod ==
                  //       getTranslated(context, 'FLUTTERWAVE_LBL'))
                  //     flutterwavePayment(amtC.text);
                }
              }
              // }
              )
        ],
      );
    }));
  }

  checkOut() {
    int amount = int.parse(amtC.text.toString()) * 100;
    var options = {
      'key': "rzp_test_CpvP0qcfS4CSJD",
      'amount': amount,
      'currency': 'INR',
      'name': 'Antsnest',
      'description': 'Add money to wallet payment here',
      // 'prefill': {'contact': userMobile, 'email': userEmail},
    };
    print("OPTIONS ===== $options");
    _razorpay.open(options);
  }

  checkout1() {
    int amount = int.parse(amountController.text.toString()) * 100;
    var options = {
      'key': "rzp_test_CpvP0qcfS4CSJD",
      'amount': amount,
      'currency': 'INR',
      'name': 'Antsnest',
      'description': '',
      // 'prefill': {'contact': userMobile, 'email': userEmail},
    };
    print("OPTIONS ===== $options");
    _razorpay.open(options);
  }

  withdrawelRequest() async {
    var userId = await MyToken.getUserID();
    var headers = {
      'Cookie': 'ci_session=463b55af4ff8ddb1f92ec1e0b22ad27ce424605d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}wallet_request'));
    request.fields.addAll(
        {'user_id': '${userId}', 'wallet_withdraw_amt': amountController.text});
    request.headers.addAll(headers);

    print('==============${request.fields}===============');
    print('==============${request.url}===============');
    http.StreamedResponse response = await request.send();
    Navigator.pop(context);

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final result = json.decode(finalResult);

      showAlertDialog(context, result['message']);
      // setState(() {
      //   var snackBar = SnackBar(
      //     content: Text('${result['message']}'),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // });

      getWalletHistory();
      getProfile();
    } else {
      showAlertDialog(context, "Something went wrong");

      print(response.reasonPhrase);
    }
  }

  sendMoeny() async {
    var userId = await MyToken.getUserID();
    var headers = {
      'Cookie': 'ci_session=7713bb602a8c2cce687579a7da752323b75eb53e'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${BaseUrl}wallet_request'));
    request.fields.addAll({
      'user_id': '${userId}',
      'wallet_withdraw_amt': '${amountController.text}'
    });
    print("checking values here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("checking response here ${jsonResponse}");
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // var userId = await MyToken.getUserID();
    UtilityHlepar.getToast("Payment Successful");
    //purchasePlan("$userId", planI,"${response.paymentId}");
    if (amtC.text.isNotEmpty) {
      print("yes here");
      addWalletMoney(response.paymentId);
    }
    if (amountController.text.isNotEmpty) {
      print("ssssss");
      sendMoeny();
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWalletHistory();
    // getUserDetails();
    //UNCOMMENT
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration(milliseconds: 200), () {
      return getProfile();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    msgC.clear();
    _razorpay.clear(); //UNCOMMENT
  }

  late GetProfileResponse profileResponse;

  var walletAmount;

  getProfile() async {
    // try {
    print("sdsds");
    var vendorId = await MyToken.getUserID();
    // var vendorId = "31";
    GetProfileRequest request = GetProfileRequest(vendorId: vendorId);
    print("profile request here" + request.toString());
    profileResponse = await AuthApiHelper.getProfile(request);
    print(
        "response here ${profileResponse.responseCode} and here ${profileResponse.status}");
    if (profileResponse.status == ToastString.success) {
      profileResponseStram.sink.add(profileResponse);
      setState(() {
        walletAmount = profileResponse.user!.wallet.toString();
      });
    } else {
      profileResponseStram.sink.addError(profileResponse.message.toString());
    }
    //}
    // catch (e) {
    //   UtilityHlepar.getToast(e.toString());
    //   profileResponseStram.sink.addError(ToastString.msgSomeWentWrong);
    // }
  }

  addWalletMoney(txnId) async {
    var userId = await MyToken.getUserID();
    var parameter = {
      "transaction_id": txnId,
      "amount": amtC.text.toString(),
      "user_id": userId,
    };
    print("add wallet money" +
        parameter.toString() +
        Apipath.addMoneyToWallet.toString());
    var response = await ApiService.postAPI(
        path: Apipath.addMoneyToWallet, parameters: parameter);

    if (response.statusCode == 200) {
      var getData = json.decode(response.body);
      String? msg = getData["msg"];
      final snackBar = SnackBar(
        content: Text(msg!),
        backgroundColor: AppColor().colorPrimary(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
      getWalletHistory();
      getProfile();
    } else {
      final snackBar = SnackBar(
        content: Text("Something went wrong!"),
        backgroundColor: AppColor().colorPrimary(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<WalletHistory> getWalletHistory() async {
    var userId = await MyToken.getUserID();
    var parameter = {
      "user_id": userId,
    };
    print(parameter.toString());
    var response = await ApiService.postAPI(
        path: Apipath.getWalletHistory, parameters: parameter);

    if (response.statusCode == 200) {
      var data = WalletHistory.fromJson(json.decode(response.body));
      //jsonDecode(response.body);
      walletHistory = data.data!;
      // print(walletHistory.toString());
      // String? msg = getData["msg"];
      // final snackBar = SnackBar(
      //   content:  Text(msg!),
      //   backgroundColor: AppColor().colorPrimary(),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar)
    } else {
      final snackBar = SnackBar(
        content: Text("Something went wrong!"),
        backgroundColor: AppColor().colorPrimary(),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return WalletHistory.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TestScreen()));
            },
            child: Text("Wallet")),
      ),
      body: Container(
        child: Stack(
          children: [
            showContent(),
          ],
        ),
      ),
    );
  }

  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
        barrierColor: AppColor().colorTextPrimary().withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: dialge),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // pageBuilder: null
        pageBuilder: (context, animation1, animation2) {
          return Container();
        } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
        );
  }

  showContent() {
    return SingleChildScrollView(
      // controller: controller,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        // color: Theme.of(context).colorScheme.fontColor,
                      ),
                      Text(
                        "Current Balance ",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  walletAmount == null || walletAmount == ""
                      ? SizedBox()
                      : Container(
                          child: Text(
                            // "₹ ${widget.walletAmount}",
                            "₹ ${walletAmount}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                  /*Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          _showDialog();
                        },
                        child: UtilityWidget.lodingButton(
                            buttonLogin: buttonLogin, btntext: 'Add Money'),
                      )),*/
                  Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: InkWell(
                        onTap: () {
                          _showDialog1();
                        },
                        child: UtilityWidget.lodingButton(
                            buttonLogin: buttonLogin,
                            btntext: 'Withdrawal Money'),
                      )),
                ],
              ),
            ),
          ),
        ),
        FutureBuilder<WalletHistory>(
            future: getWalletHistory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: ListView.builder(
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      reverse: false,
                      itemCount: walletHistory.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.white,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.asset(
                                            "images/wallet_icon.png",
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 200,
                                          )),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text.rich(TextSpan(
                                            text: 'Amount',
                                            style: TextStyle(
                                              color: walletHistory[index]
                                                          .creditOrDebit ==
                                                      "credit"
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(text: " "),
                                              TextSpan(
                                                text:
                                                    '${walletHistory[index].creditOrDebit}',
                                                style: TextStyle(
                                                  color: walletHistory[index]
                                                              .creditOrDebit ==
                                                          "credit"
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ])),

                                        // Text(
                                        //   "Amount ${walletHistory[index].creditOrDebit}",
                                        //   //  ['amount'].toString(),
                                        //   style: TextStyle(
                                        //     color: Colors.green,
                                        //     fontSize: 15,
                                        //     fontWeight: FontWeight.w500,
                                        //
                                        //   ),
                                        // ),
                                        Text(
                                          walletHistory[index]
                                              .createdAt
                                              .toString(),
                                          //  ['amount'].toString(),
                                          style: TextStyle(
                                            color:
                                                AppColor().colorTextPrimary(),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                walletHistory[index].finalPayout == "0.00"
                                    ? Text(
                                        "₹ " +
                                            walletHistory[index]
                                                .amount
                                                .toString(),
                                        //  ['amount'].toString(),
                                        style: TextStyle(
                                          color: walletHistory[index]
                                                      .creditOrDebit ==
                                                  "credit"
                                              ? Colors.green
                                              : AppColor().colorPrimary(),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        "₹ " +
                                            walletHistory[index]
                                                .finalPayout
                                                .toString(),
                                        //  ['amount'].toString(),
                                        style: TextStyle(
                                          color: walletHistory[index]
                                                      .creditOrDebit ==
                                                  "credit"
                                              ? Colors.green
                                              : AppColor().colorPrimary(),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              return Container(
                child: Center(
                  child: Image.asset("images/icons/loader.gif"),
                ),
              );
            })
      ]),
    );
  }
}
