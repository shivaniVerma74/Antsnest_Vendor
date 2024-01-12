import 'dart:async';
import 'package:fixerking/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;
import '../api/api_helper/auth_helper.dart';
import '../api/api_helper/home_api_helper.dart';
import '../modal/request/get_profile_request.dart';
import '../modal/request/notification_request.dart';
import '../modal/response/get_profile_response.dart';
import '../modal/response/notification_response.dart';
import '../token/app_token_data.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/toast_string.dart';
import '../utils/utility_hlepar.dart';
import 'home_screen.dart';
import 'manage_Service.dart';
import 'notification_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List<Widget> bodyList = [
    HomeScreen(),
    NotificationScreen(),
    ManageService(),
    ProfileScreen()
  ];
  StreamController<NotificationResponse> responseSteam = StreamController();
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getNotification();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late NotificationResponse response;
  String? count;
  getNotification() async {
    try {
      String userid = await MyToken.getUserID();
      NotificationRequest request = NotificationRequest(userid: userid);
      response = await HomeApiHelper.getNotification(request);
      count = response.count;
      setState(() {});
      print(response.notifications?.length);
      // if (response.responseCode == ToastString.responseCode) {
      //   responseSteam.sink.add(response);
      // } else {
      //   responseSteam.sink.addError(response.message!);
      // }
    } catch (e) {
      UtilityHlepar.getToast(e.toString());
      responseSteam.sink.addError(ToastString.msgSomeWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor().colorBg2(),
        body: selectedIndex == 2
            ? ManageService(profileResponse: profileResponse)
            : bodyList[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          selectedItemColor: AppColor.PrimaryDark,
          unselectedItemColor: Color(0xff757575),
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(home),
                ),
                label: "Home"),
            BottomNavigationBarItem(
                // icon: Icon(Icons.category),
                icon: badges.Badge(
                    badgeContent: Text('${count ?? 0}'),
                    showBadge: count=="0"?false:true,
                    child: Icon(Icons.notifications),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: AppColor.PrimaryDark,
                      padding: EdgeInsets.all(5),
                    )),
                label: "Notification"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(addIcon)), label: "Manage Service"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(profile)), label: "My Account"),
          ],
        ),
        /*bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              tabItem(context, 0, home, "Home"),
              tabItem(context, 1, notification, "Notification"),
              tabItem(context, 2, addIcon, "Add Service"),
              tabItem(context, 3, profile, "My Account"),
              // IconButton(
              //   enableFeedback: false,
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.home_outlined,
              //     color: AppColor.PrimaryDark,
              //     size: 35,
              //   ),
              // ),
              // IconButton(
              //   enableFeedback: false,
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.work_outline_outlined,
              //     color: AppColor.PrimaryDark,
              //     size: 35,
              //   ),
              // ),
              // IconButton(
              //   enableFeedback: false,
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.widgets_outlined,
              //     color: AppColor.PrimaryDark,
              //     size: 35,
              //   ),
              // ),
              // IconButton(
              //   enableFeedback: false,
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.person_outline,
              //     color: AppColor.PrimaryDark,
              //     size: 35,
              //   ),
              // ),
            ],
          ),
        ),*/
      ),
    );
  }

  Widget tabItem(BuildContext context, var pos, var icon, String title) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   selectedIndex = pos;
        // });
        if (pos == 1) {
          selectedIndex = 1;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotificationScreen()));
        }
        // if (pos == 2) {
        //   // Navigator.push(context,
        //   //     MaterialPageRoute(builder: (context) => ProfileScreen()));
        // }
        switch (pos) {
          case 0:
            selectedIndex = 0;
            break;
          case 1:
            selectedIndex = 1;
            break;
          case 2:
            selectedIndex = 2;
            break;
          case 3:
            selectedIndex = 3;
            break;
          default:
            selectedIndex = 0;
        }
        setState(() {});
      },
      child: Container(
        width: 15.63.w,
        height: 6.79.h,
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(
              icon,
              width: 6.94.w,
              height: 3.90.h,
              color: selectedIndex == pos
                  ? AppColor().colorPrimaryDark()
                  : Color(0xff757575),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  color: selectedIndex == pos
                      ? AppColor().colorPrimaryDark()
                      : Color(0xff757575),
                  fontFamily: fontRegular,
                  fontSize: 8.sp),
            ),
          ],
        ),
      ),
    );
  }

  GetProfileResponse? profileResponse;

  getProfile() async {
    // try {
    print("sdsds");
    var vendorId = await MyToken.getUserID();
    // var vendorId = "31";
    GetProfileRequest request = GetProfileRequest(vendorId: vendorId);
    print("profile request here" + request.toString());
    profileResponse = await AuthApiHelper.getProfile(request);
    if (profileResponse?.status == ToastString.success) {
      Fluttertoast.showToast(msg: profileResponse?.message ?? '');
    } else {
      Fluttertoast.showToast(msg: profileResponse?.message ?? '');
    }
    //}
    // catch (e) {
    //   UtilityHlepar.getToast(e.toString());
    //   profileResponseStram.sink.addError(ToastString.msgSomeWentWrong);
    // }
  }
}
