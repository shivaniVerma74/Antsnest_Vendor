import 'dart:convert';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/api/api_helper/ApiList.dart';
import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/modal/New%20models/LoginModel.dart';
import 'package:fixerking/modal/request/login_with_email.dart';
import 'package:fixerking/modal/request/login_with_phone.dart';
import 'package:fixerking/modal/response/login_email_response.dart';
import 'package:fixerking/modal/response/login_phone_response.dart';
import 'package:fixerking/screen/OtpScreen.dart';
import 'package:fixerking/screen/bottom_bar.dart';
import 'package:fixerking/screen/auth_view/signup_screen.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../../utils/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool status = false;
  String token = '';
  bool selected = false, enabled = false, edit = false, buttonLogin = false;

  @override
  void initState() {
    super.initState();
    getToken();
    _controller = AnimationController(vsync: this);
    // changePage();
  }

  getToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = fcmToken.toString();
    });
    print("FCM ID=== $token");
  }

  changePage() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      status = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? otp;
  LoginApi()async{
    showDialog(context: context, builder: (context){
      return CustomLoader(text: "Login, please wait...",);
    });
    print({"mobile========":phoneController.text,"device_token======":"$token"});
    var response = await  http.post(Uri.parse(VendorLogin),
        body: {"mobile":phoneController.text,"device_token":"$token"});
    print("checking response here ${response.body}");
    final finalStr = LoginModel.fromJson(jsonDecode(response.body));
    if(finalStr.status == "success"){
      Navigator.of(context).pop();
     setState(() {
       otp = finalStr.otp.toString();
     });
     print("otp here ${otp}");
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(otp: otp,mobile: phoneController.text,) ));
      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Otp Send Successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "${finalStr.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorBg2(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            width: 100.w,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.5),
                colors: [
                  AppColor().colorBg1(),
                  AppColor().colorBg2(),
                ],
                radius: 0.8,
              ),
            ),
            padding: MediaQuery.of(context).viewInsets,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40.65.h,
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.PrimaryDark,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18))
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.08.h,
                        ),
                        appLogo(),
                        SizedBox(
                          height: 5.08.h,
                        ),
                        text(
                          "Login",
                          textColor: Color(0xffffffff),
                          fontSize: 22.sp,
                          fontFamily: fontMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.only(top: 30.h,left: 25,right: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        Container(
                            height: 55,
                            decoration: BoxDecoration(
                                color: Color(0xffF9F9F9),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: TextFormField(
                              controller: phoneController,
                              // maxLength: 10,
                              validator: (v){
                                if(v!.isEmpty){
                                  return "Please enter Email";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10, top: 8),
                                hintText: "Enter Email Id",
                                // counterText: '',
                                hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            )),
                        SizedBox(height: 30,),
                          InkWell(
                          onTap: (){
                           if(_formKey.currentState!.validate()){
                             LoginApi();
                           }
                           else{
                             // const snackBar = SnackBar(
                             //   backgroundColor: Colors.green,
                             //   content: Text('Something went wrong'),
                             // );
                             // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                           }

                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.PrimaryDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                edit = true;
                              });
                              await Future.delayed(Duration(milliseconds: 200));
                              setState(() {
                                edit = false;
                              });
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    child: SignUpScreen(),
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 500),
                                  ));
                            },
                            child: ScaleAnimatedWidget.tween(
                              enabled: edit,
                              duration: Duration(milliseconds: 200),
                              scaleDisabled: 1.0,
                              scaleEnabled: 0.8,
                              child: RichText(
                                text: new TextSpan(
                                  text: "Don't Have An Account? ",
                                  style: TextStyle(
                                    color: Color(0xff171717),
                                    fontSize: 10.sp,
                                    fontFamily: fontBold,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: 'SignUp',
                                      style: TextStyle(
                                        color: AppColor().colorPrimary(),
                                        fontSize: 10.sp,
                                        fontFamily: fontBold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  appLogo(){
    return Container(
      width: 190,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
       // color: Colors.white
      ),
      child: Image.asset("images/antsLogo.png",
        width: 140,
        height: 70,
      ),
    );
  }

  Widget firstSign(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 3.05.h,
        ),

             Column(
                children: [
                  Center(
                    child: Container(
                      width: 69.99.w,
                      // height: 9.46.h,
                      child: TextFormField(
                        cursorColor: Colors.red,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        validator: FormValidation.validateMobile,
                        style: TextStyle(
                          color: AppColor().colorTextFour(),
                          fontSize: 10.sp,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor().colorEdit(),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: AppColor().colorTextFour(),
                            fontSize: 10.sp,
                          ),
                          helperText: '',
                          counterText: '',
                          fillColor: AppColor().colorEdit(),
                          enabled: true,
                          filled: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(4.0.w),
                            child: Image.asset(
                              phone,
                              width: 2.04.w,
                              height: 2.04.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                          suffixIcon: phoneController.text.length == 10
                              ? Container(
                                  width: 10.w,
                                  alignment: Alignment.center,
                                  child: FaIcon(
                                    FontAwesomeIcons.check,
                                    color: AppColor().colorPrimary(),
                                    size: 10.sp,
                                  ))
                              : SizedBox(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor().colorEdit(), width: 5.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        SizedBox(
          height: 4.75.h,
        ),
        Center(
          child: InkWell(
            onTap: () async {
              print(selected.toString());
              if (_formKey.currentState!.validate()) {
                setState(() {
                  buttonLogin = true;
                });
                if (selected) {
                  loginWithPhone();
                } else {
                  loginWithEmail(context);
                }
              }
            },
            child: UtilityWidget.lodingButton(
                buttonLogin: buttonLogin, btntext: "Log In"),
          ),
        ),
        SizedBox(
          height: 6.53.h,
        ),
        Center(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //     width: 9.86.w,
                //     child: Divider(
                //       color: AppColor().colorTextSecondary(),
                //     )),
                // SizedBox(
                //   width: 1.w,
                // ),
                // text(
                //   "Login With",
                //   textColor: AppColor().colorTextSecondary(),
                //   fontSize: 10.sp,
                //   fontFamily: fontRegular,
                // ),
                // SizedBox(
                //   width: 1.w,
                // ),
                // Container(
                //     width: 9.86.w,
                //     child: Divider(
                //       color: AppColor().colorTextSecondary(),
                //     )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 6.61.h,
        ),
        // Center(
        //   child: Image.asset(
        //     fb,
        //     height: 5.79.h,
        //     width: 29.30.w,
        //   ),
        // ),
      ],
    );
  }

  void loginWithPhone() async {
    late LoginPhoneResponse response;
    PhoneLoginRequest request = PhoneLoginRequest(
        number: phoneController.text,
        password: passController.text,
        deviceToken: TokenString.deviceToken);
    print(request.tojson());
    response = await AuthApiHelper.loginPhone(request);
    if (response.responseCode == "1") {
      setTokenData(response.userId.toString(), context);
    }
    setState(() {
      buttonLogin = false;
    });
  }

  void loginWithEmail(context) async {
    late LoginEmailResponse response;
    EmailLoginRequest request = EmailLoginRequest(
        email: emailController.text,
        password: passController.text,
        deviceToken: TokenString.deviceToken);
    print(request.tojson().toString());
    response = await AuthApiHelper.loginEmail(request);
    if (response.responseCode == "1") {

      setTokenData(response.userId.toString(), context);
    }
    setState(() {
      buttonLogin = false;
    });
  }

  setTokenData(userid, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TokenString.userid, userid);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
  }
}


