import 'dart:ui';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../utils/constant.dart';
import '../utils/widget.dart';
import 'auth_view/login_screen.dart';
import 'auth_view/signup_screen.dart';

bool isIamOnline = true;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController phoneController = new TextEditingController();
  bool status = false;
  bool selected = false, enabled = false, edit = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    changePage();
  }

  changePage() async {
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
        body:
            // SafeArea(
            //     child: SingleChildScrollView(
            //    physics: NeverScrollableScrollPhysics(),
            //    child: Container(
            //       child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //       AnimatedContainer(
            //         duration: Duration(milliseconds: 1000),
            //         curve: Curves.easeInOut,
            //         height: status ? 0.h : 98.h,
            //         width: 100.w,
            //         alignment: status ? Alignment.topCenter : Alignment.topCenter,
            //         decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: AssetImage(splashBg), fit: BoxFit.fill),
            //         ),
            //         child: Padding(
            //             padding: EdgeInsets.only(top: 31.h),
            //             child: Image.asset(
            //               splashLogo,
            //               height: 36.w,
            //               width: 36.w,
            //             ),
            //         ),
            //       ),
            //       AnimatedContainer(
            //         duration: Duration(milliseconds: 1000),
            //         curve: Curves.easeInOut,
            //         width: 100.w,
            //         height: 100.h,
            //         decoration: BoxDecoration(
            //           gradient: RadialGradient(
            //             center: Alignment(0.0, -0.1),
            //             colors: [
            //               AppColor().colorBg1(),
            //               AppColor().colorBg2(),
            //             ],
            //             radius: 0.8,
            //           ),
            //         ),
            //         padding: MediaQuery.of(context).viewInsets,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             SizedBox(
            //               height: 2.5.h,
            //             ),
            //             Center(
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(10),
            //                 child: Image.asset(
            //                   "images/getstarted.png",
            //                   height: 25.57.h,
            //                   width: 39.72.w,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: 1.25.h,
            //             ),
            //             Center(
            //               child: Image.asset(
            //                 welcomeIcon,
            //                 height: 25.72.h,
            //                 width: 80.47.w,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 3.64.h,
            //             ),
            //             Center(
            //               child: text(
            //                 "Welcome To AntsNest \n  Service Provider",
            //                 textColor: AppColor.PrimaryDark,
            //                 fontSize: 14.5.sp,
            //                 fontFamily: fontBold,
            //                 isCentered: true,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 2.26.h,
            //             ),
            //             // Center(
            //             //   child: Container(
            //             //       margin: EdgeInsets.symmetric(horizontal: 20.sp),
            //             //       child: text(
            //             //           "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod Lorem ipsum dolor sit amet, consetetur sadipscing elitr.",
            //             //           textColor: AppColor().colorTextPrimary(),
            //             //           fontSize: 10.5.sp,
            //             //           fontFamily: fontRegular,
            //             //           isCentered: true,
            //             //           maxLine: 3)),
            //             // ),
            //             SizedBox(
            //               height: 6.01.h,
            //             ),
            //             Center(
            //               child: InkWell(
            //                 onTap: () async {
            //                   setState(() {
            //                     edit = true;
            //                   });
            //                   await Future.delayed(Duration(milliseconds: 200));
            //                   setState(() {
            //                     edit = false;
            //                   });
            //                   Navigator.push(
            //                       context,
            //                       PageTransition(
            //                         child: LoginScreen(),
            //                         type: PageTransitionType.rightToLeft,
            //                         duration: Duration(milliseconds: 500),
            //                       ));
            //                 },
            //                 child: ScaleAnimatedWidget.tween(
            //                   enabled: edit,
            //                   duration: Duration(milliseconds: 200),
            //                   scaleDisabled: 1.0,
            //                   scaleEnabled: 0.9,
            //                   child: Container(
            //                     height: 6.5.h,
            //                     width: 42.63.w,
            //                     decoration: boxDecoration(
            //                         radius: 15.0,
            //                         bgColor: AppColor.PrimaryDark),
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         text(
            //                           "Get started",
            //                           textColor: Color(0xffffffff),
            //                           fontSize: 14.sp,
            //                           fontFamily: fontRegular,
            //                         ),
            //                         // Center(
            //                         //   child: Image.asset(
            //                         //     arrowIcon,
            //                         //     width: 12.78.w,
            //                         //     height: 12.78.w,
            //                         //     fit: BoxFit.fill,
            //                         //   ),
            //                         // ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   )),
            // )),

            Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/introduction.png"),
                  fit: BoxFit.cover)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      width: 250,
                      child: Image.asset(
                        "images/appnewlogo.png",
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: text(
                      "Get started",
                      textColor: Colors.black,
                      fontSize: 25.sp,
                      // fontFamily: fontRegular,
                      fontFamily: fontBold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome To Antsnest For Professionals! \nShowcase, Connect, Grow.\nReady to succeed? Let's begin.",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Regular"),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: SignUpScreen(),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: text(
                          "SIGN UP",
                          textColor: Colors.black,
                          fontSize: 12.sp,
                          // fontFamily: fontRegular,
                          fontFamily: fontBold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: LoginScreen(),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: text(
                          "SIGN IN",
                          textColor: Colors.black,
                          fontSize: 12.sp,
                          // fontFamily: fontRegular,
                          fontFamily: fontBold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
