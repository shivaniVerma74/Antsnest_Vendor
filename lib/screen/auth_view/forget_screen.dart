import 'package:animated_widgets/animated_widgets.dart';
import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/modal/request/forgot_password.dart';
import 'package:fixerking/modal/response/forgot_password_response.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/common.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/widget.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController emailController = new TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool status = false;
  bool selected = false, enabled = false, edit = false;
  bool buttonLogin = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    changePage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  width: 100.w,
                  height: 100.h,
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
                  // padding: MediaQuery.of(context).viewInsets,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 22.65.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(forgetBg),
                          fit: BoxFit.fill,
                        )),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                  width: 100.w,
                                  height: 4.0.h,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 5.w, top: 1.h),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(
                                        back,
                                        height: 4.0.h,
                                        width: 8.w,
                                      ))),
                              SizedBox(
                                height: 2.08.h,
                              ),
                              text(
                                "Forgot Password",
                                textColor: Color(0xffffffff),
                                fontSize: 22.sp,
                                fontFamily: fontMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(top: 16.h, bottom: 30),
                        width: 83.33.w,
                        height: 50.96.h,
                        decoration: boxDecoration(
                            radius: 50.0, bgColor: Color(0xffffffff)),
                        child: firstSign(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -30.h, 0.0),
                  // margin: EdgeInsets.only(top: 65.96.h, bottom: 8.h),
                  child: InkWell(
                    onTap: () {
                      if (_fromKey.currentState!.validate()) {
                        setState(() {
                          buttonLogin = true;
                        });
                        forgotMyPassword();
                      }
                    },
                    child: UtilityWidget.lodingButton(
                        buttonLogin: buttonLogin, btntext: 'Send'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstSign(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 4.32.h,
        ),
        Center(
          child: Image.asset(
            forgetIcon,
            height: 16.09.h,
            width: 29.72.w,
          ),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              child: text(
                  "Enter the Email associated with your account we will send you a email to reset your password.",
                  textColor: AppColor().colorTextPrimary(),
                  fontSize: 9.sp,
                  fontFamily: fontRegular,
                  isCentered: true,
                  maxLine: 3)),
        ),
        SizedBox(
          height: 1.87.h,
        ),
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidation.emailVeledetion,
                    controller: emailController,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Email',
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
                        padding: EdgeInsets.all(3.5.w),
                        child: Image.asset(
                          email,
                          width: 2.04.w,
                          height: 2.04.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      suffixIcon: emailController.text.length == 10
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.96.h,
        ),
      ],
    );
  }

  late ForgotPassResponse response;
  void forgotMyPassword() async {
    try {
      ForgotPasswordRequest request =
          ForgotPasswordRequest(email: emailController.text);
      response = await AuthApiHelper.forgotPassword(request);
      buttonLogin = false;
      Navigator.pop(context);
      setState(() {});
    } catch (e) {
      UtilityHlepar.getToast(ToastString.msgSomeWentWrong);
      Navigator.pop(context);
    }
  }
}
