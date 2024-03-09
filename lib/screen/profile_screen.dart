import 'dart:async';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:fixerking/screen/paymentHistory.dart';
import 'package:fixerking/screen/plan_history.dart';
import 'package:fixerking/screen/privacy_policy.dart';
import 'package:fixerking/screen/profile/edit_profile_screen.dart';
import 'package:fixerking/screen/profile/view_profile_screen.dart';
import 'package:fixerking/screen/service_history.dart';
import 'package:fixerking/screen/subscription_screen.dart';
import 'package:fixerking/screen/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../api/api_helper/auth_helper.dart';
import '../modal/request/get_profile_request.dart';
import '../modal/response/get_profile_response.dart';
import '../token/app_token_data.dart';
import '../utility_widget/shimmer_loding_view/loding_all_page.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/toast_string.dart';
import '../utils/utility_hlepar.dart';
import '../utils/widget.dart';
import 'Chat_Screen.dart';
import 'CustomerSupport/customer_support_faq.dart';
import 'ReviewPage.dart';
import 'auth_view/login_screen.dart';
import 'availablity.dart';
import 'cancellation_screen.dart';
import 'change_password_screen.dart';
import 'contactUsPage.dart';
import 'my_booking_list.dart';
import 'my_wallet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamController<GetProfileResponse> profileResponseStram =
      StreamController();
  late GetProfileResponse profileResponse;
  bool selected = false, enabled = false, edit1 = false;
  String? walletAmount;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    profileResponseStram.close();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorPrimary());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
        title: Text("My Account"),
      ),
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
                  AppColor().colorBg1(),
                ],
                radius: 0.8,
              ),
            ),
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                // Container(
                //   height: 9.92.h,
                //   width: 100.w,
                //   decoration: BoxDecoration(
                //    /*   image: DecorationImage(
                //     image: AssetImage(profileBg),
                //     fit: BoxFit.fill,
                //   )*/
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.white.withOpacity(0.4),
                //       spreadRadius: 3,
                //       blurRadius: 4,
                //     )
                //   ]
                //   ),
                //   child: Center(
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Container(
                //             width: 6.38.w,
                //             height: 6.38.w,
                //             alignment: Alignment.centerLeft,
                //             margin: EdgeInsets.only(left: 7.91.w),
                //             child: InkWell(
                //                 onTap: () {
                //                   Navigator.pushReplacement(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) => BottomBar(index: 1,)));
                //                 },
                //                 child: Image.asset(
                //                   back,
                //                   height: 4.0.h,
                //                   width: 8.w,
                //                 )
                //             )),
                //         SizedBox(
                //           width: 2.08.h,
                //         ),
                //         Container(
                //           width: 65.w,
                //           child: text(
                //             "My Account",
                //             textColor: Color(0xffffffff),
                //             fontSize: 14.sp,
                //             fontFamily: fontMedium,
                //             isCentered: true,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                StreamBuilder<GetProfileResponse>(
                    stream: profileResponseStram.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: text(snapshot.error.toString()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox(height: 15.h, child: LodingAllPage());
                      }
                      print(
                          "wallet amount here ${snapshot.data!.user!.wallet}");
                      walletAmount = snapshot.data!.user!.wallet.toString();
                      return InkWell(
                        onTap: () async {
                          var data = await Navigator.push(
                              context,
                              PageTransition(
                                child: ViewProfileScreen(
                                  response: snapshot.data!,
                                ),
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 500),
                              ));
                          print(data);
                          print("---------=");
                          getProfile();
                        },
                        child: Container(
                            height: 11.40.h,
                            width: 82.91.w,
                            margin: EdgeInsets.only(
                                left: 8.33.w,
                                right: 8.33.w,
                                bottom: 1.87.h,
                                top: 1.87.h),
                            child: Row(
                              children: [
                                Container(
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          height: 9.76.h,
                                          width: 9.76.h,
                                          child: snapshot.data!.user!
                                                      .profileImage !=
                                                  ""
                                              ? UtilityHlepar.convertetIMG(
                                                  snapshot
                                                      .data!.user!.profileImage
                                                      .toString(),
                                                  fit: BoxFit.cover)
                                              : Image(
                                                  image: AssetImage(picture),
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                      snapshot.data!.activePlan == "1"
                                          ? Positioned(
                                              right: 0,
                                              top: 1,
                                              child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  alignment: Alignment.topRight,
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.blue,
                                                    size: 29,
                                                  )))
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 3.05.w,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: text(
                                            snapshot.data!.user!.fname
                                                    .toString() +
                                                " " +
                                                snapshot.data!.user!.lname
                                                    .toString(),
                                            textColor: Color(0xff191919),
                                            fontSize: 14.0.sp,
                                            fontFamily: fontBold,
                                            overFlow: true),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Container(
                                        child: text(
                                          snapshot.data!.user!.email.toString(),
                                          textColor: Color(0xff2a2a2a),
                                          fontSize: 10.sp,
                                          overFlow: true,
                                          fontFamily: fontRegular,
                                          maxLine: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 2.05.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          child: EditProfileScreen(
                                              response: snapshot.data!),
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 500),
                                        ));
                                  },
                                  child: Container(
                                    height: 5.39.h,
                                    width: 5.39.h,
                                    decoration: boxDecoration(
                                        radius: 100,
                                        bgColor: AppColor().colorPrimary()),
                                    child: Center(
                                      child: Image.asset(
                                        edit,
                                        height: 2.26.h,
                                        width: 2.26.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
                tabItem(context, 5, subscription, "Subscription Plans"),
                tabItem(
                    context, 14, "images/BOOKING LIST.png", "My BookingList"),
                tabItem(context, 7, walletIcon, "My Wallet"),
                tabItem(context, 1, payment, "Plan History"),
                // tabItem(context, 2, serviceIcon, "Service History"),
                tabItem(context, 6, chatIcon, "Chat With User"),
                tabItem(context, 8, service, "Reviews"),
                tabItem(context, 11, support, "Customer Support"),
                tabItem(context, 9, "images/avail.png", "Availability"),
                tabItem(context, 10, payment, "Payment History"),
                tabItem(context, 12, "images/privacy.png", "Privacy Policy "),
                tabItem(context, 15, "images/resignation.png",
                    "Cancellation Policy "),
                tabItem(context, 13, "images/terms-and-conditions.png",
                    "Terms & Condition "),
                // tabItem(context, 3, changePass, "Change Password"),
                tabItem(context, 4, support, "Contact Us"),

                SizedBox(
                  height: 2.5.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Alert(
                        context: context,
                        title: "Log out",
                        desc: "Are you sure you want to log out?",
                        style: AlertStyle(
                          isCloseButton: false,
                          descStyle: TextStyle(
                              fontFamily: "MuliRegular", fontSize: 15),
                          titleStyle: TextStyle(fontFamily: "MuliRegular"),
                        ),
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "MuliRegular"),
                            ),
                            onPressed: () async {
                              // setState(() {
                              //   userID = '';
                              //   userEmail = '';
                              //   userMobile = '';
                              //   likedProduct = [];
                              //   likedService = [];
                              // });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                            },
                            color: AppColor.PrimaryDark,
                          ),
                          DialogButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "MuliRegular"),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            color: AppColor.PrimaryDark,
                            // gradient: LinearGradient(colors: [
                            //   Color.fromRGBO(116, 116, 191, 1.0),
                            //   Color.fromRGBO(52, 138, 199, 1.0)
                            // ]),
                          ),
                        ],
                      ).show();
                    },
                    // onTap: () {
                    //   // SharedPreferences prefs = await SharedPreferences.getInstance();
                    //   // await prefs.clear();
                    //   // Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                    //   // setState(() {
                    //   //   edit1 = true;
                    //   // });
                    //   // await Future.delayed(Duration(milliseconds: 200));
                    //   // setState(() {
                    //   //   edit1 = false;
                    //   // });
                    //   // Navigator.pushReplacement(
                    //   //     context,
                    //   //     PageTransition(
                    //   //       child: LoginScreen(),
                    //   //       type: PageTransitionType.rightToLeft,
                    //   //       duration: Duration(milliseconds: 500),
                    //   //     ));
                    // },
                    child: ScaleAnimatedWidget.tween(
                      enabled: edit1,
                      duration: Duration(milliseconds: 200),
                      scaleDisabled: 1.0,
                      scaleEnabled: 0.9,
                      child: Container(
                        height: 7.09.h,
                        width: 42.63.w,
                        decoration: boxDecoration(
                            radius: 15.0, bgColor: AppColor.PrimaryDark),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                logout,
                                height: 3.82.h,
                                width: 3.82.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            text(
                              "Log Out",
                              textColor: Color(0xffffffff),
                              fontSize: 10.sp,
                              fontFamily: fontRegular,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    } else {
      profileResponseStram.sink.addError(profileResponse.message.toString());
    }
    //}
    // catch (e) {
    //   UtilityHlepar.getToast(e.toString());
    //   profileResponseStram.sink.addError(ToastString.msgSomeWentWrong);
    // }
  }

  Widget tabItem(BuildContext context, var pos, var icon, String title) {
    return InkWell(
      onTap: () {
        if (pos == 1) {
          Navigator.push(
              context,
              PageTransition(
                child: PlanHistory(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 2) {
          Navigator.push(
              context,
              PageTransition(
                child: MainServiceHistory(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 3) {
          Navigator.push(
              context,
              PageTransition(
                child: ChangeScreen(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 4) {
          Navigator.push(
              context,
              PageTransition(
                child: ContactUsPage(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 5) {
          Navigator.push(
              context,
              PageTransition(
                child: SubscriptionScreen(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 6) {
          Navigator.push(
            context,
            PageTransition(
              child: ChatScreen(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        if (pos == 7) {
          Navigator.push(
            context,
            PageTransition(
              child: WalletScreen(
                walletAmount: walletAmount.toString(),
              ),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
            ),
          );
        } else if (pos == 8) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReviewPage()));
        } else if (pos == 10) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentHistory()));
        }
        if (pos == 9) {
          Navigator.push(
            context,
            PageTransition(
              child: Availability(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        if (pos == 11) {
          Navigator.push(
              context,
              PageTransition(
                child: CustomerSupport(
                    // walletAmount: walletAmount.toString(),
                    ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 12) {
          Navigator.push(
              context,
              PageTransition(
                child: PrivacyPolicyScreen(
                    // walletAmount: walletAmount.toString(),
                    ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 13) {
          Navigator.push(
              context,
              PageTransition(
                child: TermsConditionScreen(
                    // walletAmount: walletAmount.toString(),
                    ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 14) {
          Navigator.push(
              context,
              PageTransition(
                child: MyBookinglistScreen(
                    // walletAmount: walletAmount.toString(),
                    ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
        if (pos == 15) {
          Navigator.push(
              context,
              PageTransition(
                child: CancellationScreen(
                    // walletAmount: walletAmount.toString(),
                    ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500),
              ));
        }
      },
      child: Container(
          height: 11.25.h,
          width: 82.91.w,
          decoration: boxDecoration(
            showShadow: true,
            radius: 20.0,
            bgColor: AppColor().colorBg1(),
          ),
          margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
          padding: EdgeInsets.only(left: 6.05.w, right: 3.05.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 4.82.h,
                width: 4.82.h,
                child: Image(
                  image: AssetImage(icon),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: text(title,
                    textColor: Color(0xff191919),
                    fontSize: 10.5.sp,
                    fontFamily: fontBold,
                    overFlow: true),
              ),
              SizedBox(
                width: 1.05.w,
              ),
              Container(
                height: 6.32.h,
                width: 6.32.h,
                decoration: boxDecoration(
                    radius: 100,
                    bgColor: AppColor().colorPrimary().withOpacity(0.15)),
                child: Center(
                  child: Image(
                    image: AssetImage(arrowForward),
                    fit: BoxFit.fill,
                    height: 1.87.h,
                    width: 1.80.w,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
