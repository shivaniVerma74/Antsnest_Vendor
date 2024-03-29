import 'dart:async';
import 'package:fixerking/screen/service_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../api/api_helper/home_api_helper.dart';
import '../api/api_path.dart';
import '../api/api_services.dart';
import '../modal/VendorOrderModel.dart';
import '../modal/request/get_new_order_request.dart';
import '../modal/request/notification_request.dart';
import '../modal/response/notification_response.dart';
import '../token/app_token_data.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/toast_string.dart';
import '../utils/utility_hlepar.dart';
import '../utils/widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  StreamController<NotificationResponse> responseSteam = StreamController();

  @override
  void initState() {
    super.initState();
    getNotification();
    getReadNotification();
  }

  late VendorOrderModel orderResponse;

  getNewOders(i, String bookinId) async {
    var userid = await MyToken.getUserID();
    GetNewOrderRequest request =
        GetNewOrderRequest(userId: userid, bookingId: bookinId);
    orderResponse = await HomeApiHelper.getNewOrder(request);
    if (orderResponse.responseCode == ToastString.responseCode) {
      gotOderInfo(orderResponse, i);
    } else {}
  }

  gotOderInfo(response, i) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ServiceScreenDetails(orderResponse: response, i: i)),
    );
    // await getVendorBooking("");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    responseSteam.close();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorPrimary());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Notification",
        ),
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            width: 100.w,
            // decoration: BoxDecoration(
            //   gradient: RadialGradient(
            //     center: Alignment(0.0, -0.5),
            //     colors: [
            //       AppColor().colorBg1(),
            //       AppColor().colorBg1(),
            //     ],
            //     radius: 0.8,
            //   ),
            // ),
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                // Container(
                //   height: 9.92.h,
                //   width: 100.w,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //     image: AssetImage(profileBg),
                //     fit: BoxFit.fill,
                //   )),
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
                //                 ))),
                //         SizedBox(
                //           width: 2.08.h,
                //         ),
                //         Container(
                //           width: 65.w,
                //           child: text(
                //             "Notification",
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
                StreamBuilder<NotificationResponse>(
                    stream: responseSteam.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Center(child: Text(snapshot.error.toString())),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        // return LodingAllPage();
                        return Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(
                              child: Image.asset("images/icons/loader.gif"),
                            ));
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 1.87.h),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.notifications!.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () async {
                                  getNewOders(0,
                                      "${snapshot.data!.notifications?[i].dataId}");
                                },
                                child: Container(
                                    height: 11.40.h,
                                    width: 82.91.w,
                                    decoration: boxDecoration(
                                      showShadow: true,
                                      radius: 0.0,
                                      bgColor: AppColor().colorBg1(),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 8.33.w,
                                        right: 8.33.w,
                                        bottom: 1.87.h),
                                    padding: EdgeInsets.only(
                                        left: 3.05.w, right: 2.05.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 6.32.h,
                                          width: 6.32.h,
                                          child: Image(
                                            image: AssetImage(notificationIcon),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3.05.w,
                                        ),
                                        Container(
                                          width: 57.5.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: text(
                                                    snapshot
                                                        .data!
                                                        .notifications![i]
                                                        .title!,
                                                    textColor:
                                                        Color(0xff191919),
                                                    fontSize: 11.5.sp,
                                                    fontFamily: fontBold,
                                                    overFlow: true),
                                              ),
                                              SizedBox(
                                                height: 0.79.h,
                                              ),
                                              Container(
                                                child: text(
                                                  snapshot
                                                      .data!
                                                      .notifications![i]
                                                      .message!,
                                                  textColor: Color(0xff2a2a2a),
                                                  fontSize: 7.sp,
                                                  overFlow: true,
                                                  fontFamily: fontRegular,
                                                  maxLine: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getReadNotification() async {
    String userid = await MyToken.getUserID();
    var responsData = await ApiService.postAPI(
        path: Apipath.readnotification, parameters: {"user_id": "${userid}"});

    print(responsData.body);
    print(responsData.statusCode);
  }

  late NotificationResponse response;
  getNotification() async {
    String userid = await MyToken.getUserID();

    try {
      NotificationRequest request = NotificationRequest(userid: userid);
      response = await HomeApiHelper.getNotification(request);
      print(response.notifications?.length);
      if (response.responseCode == ToastString.responseCode) {
        responseSteam.sink.add(response);
      } else {
        responseSteam.sink.addError(response.message!);
      }
    } catch (e) {
      UtilityHlepar.getToast(e.toString());
      responseSteam.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}
