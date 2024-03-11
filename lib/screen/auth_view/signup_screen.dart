import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fixerking/screen/auth_view/subCategoryScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../api/api_helper/ApiList.dart';
import '../../api/api_helper/auth_helper.dart';
import '../../api/api_path.dart';
import '../../modal/City_model.dart';
import '../../modal/New models/SignupModel.dart';
import '../../modal/ServiceCategoryModel.dart';
import '../../modal/ServiceSubCategoryModel.dart';
import '../../modal/country_model.dart';
import '../../modal/request/sign_up_request.dart';
import '../../modal/response/sign_up_response.dart';
import '../../modal/state_model.dart';
import '../../token/app_token_data.dart';
import 'package:http/http.dart' as http;

import '../../token/token_string.dart';
import '../../utility_widget/customLoader.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/toast_string.dart';
import '../../utils/utility_hlepar.dart';
import '../../utils/widget.dart';
import '../../validation/form_validation.dart';
import '../bottom_bar.dart';
import '../privacy_policy.dart';
import '../terms_condition.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

late String myLoction = "";

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  int tabController = 1;
  String? selectedLanguage;
  Map<String, List<SubData>> customMap = {};

  late AnimationController _controller;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController aadharController = new TextEditingController();
  TextEditingController addController = new TextEditingController();
  TextEditingController onpenTime = new TextEditingController();
  TextEditingController closeTime = new TextEditingController();

  TextEditingController signUpNameController = new TextEditingController();
  TextEditingController signUpEmailController = new TextEditingController();
  TextEditingController signPhoneController = new TextEditingController();
  TextEditingController signPassController = new TextEditingController();
  TextEditingController signUpAadharController = new TextEditingController();
  TextEditingController signAddController = new TextEditingController();
  TextEditingController signDescriptionController = new TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  String signUpCatId = '';

  TextEditingController lastController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController portfolioController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController comfertableServiceController = TextEditingController();
  TextEditingController whyJoinController = TextEditingController();
  TextEditingController serviceInfoController = TextEditingController();
  TextEditingController facebookLinkController = TextEditingController();

  String? noOfDays;
  List<String> noofDayList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  String? selectedCategory;
  String? selectedSubCategory;
  TextEditingController amountController = TextEditingController();

  String? SelectedSignleCity;
  String? selectedDayHour;
  String? SelectedLanguage;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _storeFormKey = GlobalKey();
  bool buttonLogin = false;
  var lat, long;
  String? selectedCountry, selectedState;
  List serviceTypeId = [];
  List specilizationTypeId = [];
  int roleValue = 0;

  String roleString = "Role";
  int productIndex = 0;

  List<String> timeList = ["Hour", "Days"];
  List<String> languageList = [
    "English",
    "Italian",
    "Turkish",
    "Polish",
    "Indonesian",
    "Chinese/Manadarin",
    "Tagalog",
    "Japanese",
    "German",
    "Korean",
    "urdu",
    "Hindi",
    "French",
    "Portuguese",
    "Dutch",
    "Norwegian",
    "Arabic",
    "Chinese/Cantonese"
  ];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<String> cityIdList = [];

  bool status = false;
  bool selected = false, enabled = false, edit = false;
  List serviceList = [];
  List boolList = [];
  Map<String, dynamic> boolStoreMapList = {};
  Map<String, dynamic> boolServiceMapList = {};
  List productList = [];
  List boolStoreList = [];
  List<CountryData> countryList = [];
  List<StateData> stateList = [];
  List<CityData> cityList = [];
  List<String> selectedCities = [];
  List<bool> isCheck = [];
  List _selectedItems = [];
  final MultiSelectController multiSelectController = MultiSelectController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getCountries();
    // getServiceList();
    // getLocation();
  }

  String? selectedTravel;
  List<String> travelList = ["Local", "Nationwide", "Worldwide"];

  List<String> selectedLanguageList = [];

  void _showMultiSelect() async {
    // // a list of selectable items
    // // these items can be hard-coded or dynamically fetched from a database/API
    // final List _items = [
    //   {
    //     "id":"1",
    //     "name":"Flutter"
    //   },
    //   {
    //     "id":"2",
    //     "name":"Node.js"
    //   },
    //   {
    //     "id":"3",
    //     "name":"React Native"
    //   },
    // ];

    final List? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          selectedState: selectedState.toString(),
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
      print("this is result == ${_selectedItems.toString()}");
    }
  }

  int visibleIndex = 1;
  bool isVisible = false;
  List<String> categorylist = [];
  Set<String> uniqueValues = Set();

  // citiesDialog(){
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //     return StatefulBuilder(
  //         builder: (context, setState) {
  //       return AlertDialog(
  //           title: const Text('Select Cities'),
  //           content: FutureBuilder(
  //               future: getCities(),
  //               builder: (BuildContext context,
  //                   AsyncSnapshot snapshot) {
  //                 if (snapshot.hasData) {
  //                   return SingleChildScrollView(
  //                     child: ListBody(
  //                       children: cityList.map((item) =>
  //                       //    InkWell(
  //                       //      onTap: (){
  //                       //        isCheck[0] = !isCheck[0];
  //                       //      },
  //                       //      child: Padding(
  //                       //        padding: const EdgeInsets.only(bottom: 10.0),
  //                       //        child: Row(
  //                       //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       //          children: [
  //                       //            Container(
  //                       //              width: 25,
  //                       //              height: 25,
  //                       //              decoration: BoxDecoration(
  //                       //                color: isCheck[0] ? Colors.blue : Colors.white,
  //                       //                border: Border.all(
  //                       //                  color: Colors.grey
  //                       //                )
  //                       //              ),
  //                       //            ),
  //                       //            Text(
  //                       //              item.name!
  //                       //            )
  //                       //          ],
  //                       //        ),
  //                       //      ),
  //                       //    )
  //                       // ).toList()
  //
  //
  //                           CheckboxListTile(
  //                               value: selectedCities.contains(item.id),
  //                               //_selectedItems.contains(item),
  //                               title: Text(item.name!),
  //                              // controlAffinity: ListTileControlAffinity
  //                                   //.leading,
  //                               onChanged: (isChecked) {
  //                                 selectedCities.contains(item.id)
  //                                     ? selectedCities
  //                                     .remove(item.id)
  //                                     : selectedCities
  //                                     .add(item.id!);
  //                                 // print()
  //                                 // _itemChange(item, isChecked!),
  //                               }
  //
  //                           )
  //                     )
  //                           .toList(),
  //                     ),
  //                   );
  //                 } else if (snapshot.hasError) {
  //                   return Icon(Icons.error_outline);
  //                 } else {
  //                   return Center(
  //                       child: CircularProgressIndicator());
  //                 }
  //               }),
  //
  //
  //           actions: [
  //             TextButton(
  //                 child: const Text('Cancel'),
  //                 onPressed: () {}
  //               //_cancel,
  //             ),
  //             ElevatedButton(
  //                 child: const Text('Submit'),
  //                 onPressed: () {}
  //               //_submit,
  //             ),
  //           ],
  //         );
  //     }
  //     );
  //       }
  //   );
  //
  // }
  String phoneCode = '+91';
  var dateFormate;
  bool dobError = false;
  String _dateValue = '';
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Colors.black, //Head background
                //  accentColor: Colors.black,
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
      });
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  checkvisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  getServiceList() async {
    Response response = await get(
      Uri.parse("${Apipath.BASH_URL}get_cities"),
    );
    var fullResponse = jsonDecode(response.body);
    serviceList = fullResponse["data"];
    print(serviceList.length);
    setState(() {});
    boolList = serviceList.map((element) {
      return false;
    }).toList();
    serviceList.forEach((element) {
      boolServiceMapList[element["id"]] = false;
    });
    print(boolServiceMapList.length);
    print(boolList.length);
  }

  String? latitude, longitudes;

  getLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: Platform.isAndroid
              ? "AIzaSyB_R73InTM8ee1c57EiJhpkYRqoq3nF_Gc"
              : "AIzaSyB_R73InTM8ee1c57EiJhpkYRqoq3nF_Gc",
          onPlacePicked: (result) {
            print(result.formattedAddress);
            setState(() {
              addressController.text = result.formattedAddress.toString();
              latitude = result.geometry!.location.lat.toString();
              longitudes = result.geometry!.location.lng.toString();
              myLoction = result.formattedAddress.toString();
            });
            Navigator.of(context).pop();
          },
          initialPosition: LatLng(22.719568, 75.857727),
          useCurrentLocation: true,
        ),
      ),
    );
  }

  signUpFunction() async {
    String langueges = selectedLanguageList.join(",");
    print("new languages are here ${langueges}");

    String cities = cityIdList.join(",");
    print("new cities are here ${cities} andc ${cityList} and ${cityIdList}");
    print("checking here ${cityIdList.length}");
    for (var i = 0; i < _selectedItems.length; i++) {
      print("check now ${_selectedItems[i].id}");
    }
    showDialog(
        context: context,
        builder: (context) {
          return CustomLoader(
            text: "Signing Up,please wait...",
          );
        });

    var response = await http.post(Uri.parse(VendorRegistration), body: {
      "mobile": "${phoneController.text}",
      "name": "${fullNameController.text}",
      "email": "${emailController.text}",
      'country_id': selectedCountry,
      'state_id': selectedState,
      'city_id': SelectedSignleCity.toString(),
      "address": addressController.text,
      "can_travel": selectedTravel.toString(),
      "service_cities": cities.toString(),
      "website": portfolioController.text,
      "t_link": twitterController.text,
      "i_link": instagramController.text,
      "l_link": linkedInController.text,
      "f_link": facebookLinkController.text,
      "equipments": equipmentController.text,
      "country_code": "+$phoneCode",
      "birthday": dateFormate.toString(),
      "provide_services": comfertableServiceController.text,
      "join_antsnest": whyJoinController.text,
      "cat": selectedCategory.toString(),
      "sub_cat": categorylist.map((String value) {
            return value.toString();
          }).join(', ') ??
          "",
      "hrs_day": selectedDayHour.toString(),
      "amount": amountController.text,
      "language": langueges.toString(),
      "number": noOfDays,
      "provide_services": serviceInfoController.text
    });

    var datas = {
      "mobile": phoneController.text,
      "name": fullNameController.text,
      "email": emailController.text,
      'country_id': selectedCountry,
      'state_id': selectedState,
      'city_id': SelectedSignleCity.toString(),
      "address": addressController.text,
      "can_travel": selectedTravel.toString(),
      "service_cities": cityIdList.toString(),
      "website": portfolioController.text,
      "t_link": twitterController.text,
      "i_link": instagramController.text,
      "f_link": facebookLinkController.text,
      "l_link": linkedInController.text,
      "equipments": equipmentController.text,
      "birthday": dateFormate.toString(),
      "provide_services": comfertableServiceController.text,
      "join_antsnest": whyJoinController.text,
      "cat": selectedCategory.toString(),
      "sub_cat": selectedSubCategory.toString(),
      "hrs_day": selectedDayHour.toString(),
      "amount": amountController.text,
      "language": selectedLanguage.toString(),
      "number": noOfDays,
      "provide_services": serviceInfoController.text
    };
    print("sign up parameter ${datas}");
    print("response of sign up api ${response.body}");
    var finalStr = SignupModel.fromJson(json.decode(response.body));
    print("final status ${finalStr.status}");
    if (finalStr.status == "success") {
      showWarningDialog(context);
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         backgroundColor: Colors.green,
      //         content: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisSize: MainAxisSize.min,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(finalStr.message ?? ""),
      //             SizedBox(
      //               height: 4,
      //             ),
      //             ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 child: Text(
      //                   "Your form was successfully submitted! We'll review your application and get back to you within 48 hours.",
      //                   style: TextStyle(color: Colors.white),
      //                 )),

      //             //CircularProgressIndicator(),
      //           ],
      //         ),
      //       );
      //     });
      // // const snackBar = SnackBar(
      //   backgroundColor: Colors.green,
      //   content: Text(
      //       "Your form was successfully submitted! We'll review your application and get back to you within 48 hours."),
      // );
      //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "${finalStr.message}");
    }
  }

  void showWarningDialog(BuildContext context) {
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
                  Icons.check_circle_rounded,
                  size: 50,
                  color: AppColor.PrimaryDark,
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
                  "Your form was successfully submitted! We'll review your application and get back to you within 48 hours.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
              ],
            ),
          ),
        );
      },
    );
  }

  Future<ServiceCategoryModel?> getServiceCategory() async {
    // var userId = await MyToken.getUserID();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${Apipath.BASH_URL}get_categories_list',
        ));
    print(request);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return ServiceCategoryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  ServiceSubCategoryModel? serviceSubCategoryModel;

  Future<ServiceSubCategoryModel?> getServicesSubCategory(
      catId, String serviceName) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));

    request.fields.addAll({'p_id': '$catId'});

    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      var finalResult = ServiceSubCategoryModel.fromJson(json.decode(str));
      setState(() {
        serviceSubCategoryModel = finalResult;
      });
      addData(serviceName, serviceSubCategoryModel!.data!);
      //customMap.addEntries(serviceName, serviceSubCategoryModel.data!);
    } else {
      return null;
    }
  }

  void addData(String key, List<SubData> newData) {
    if (customMap.containsKey(key)) {
      customMap[key]!.addAll(newData);
    } else {
      customMap[key] = newData;
    }
  }

  bool isValidUrl(String url) {
    final RegExp urlRegExp = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    return urlRegExp.hasMatch(url);
  }

  openLanguageList() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Multiple Language",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      // InkWell(
                      //     onTap: (){
                      //       Navigator.pop(context);
                      //       setState((){
                      //
                      //       });
                      //     },
                      //     child: Icon(Icons.clear,))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    //height: 500,
                    width: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: languageList.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {
                                if (selectedLanguageList
                                    .contains(languageList[i].toString())) {
                                  setState(() {
                                    selectedLanguageList
                                        .remove(languageList[i]);
                                  });
                                  print(
                                      "removed language list ${selectedLanguageList}");
                                } else {
                                  setState(() {
                                    selectedLanguageList.add(languageList[i]);
                                  });
                                  print(
                                      "added language list ${selectedLanguageList}");
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedLanguageList.contains(languageList[i])
                                      ? Icon(Icons.check_box,
                                          size: 20, color: AppColor.PrimaryDark)
                                      : Icon(Icons.check_box_outline_blank,
                                          size: 20,
                                          color: AppColor.PrimaryDark),
                                  // Container(
                                  //     height: 15,
                                  //     width: 15,
                                  //     padding: EdgeInsets.all(2),
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.transparent,
                                  //         border: Border.all(
                                  //             color: AppColor.PrimaryDark),
                                  //         borderRadius:
                                  //             BorderRadius.circular(0)),
                                  //     child: Container(
                                  //       decoration: BoxDecoration(
                                  //           color: selectedLanguageList
                                  //                   .contains(
                                  //                       languageList[i])
                                  //               ? AppColor().colorPrimary()
                                  //               : Colors.transparent,
                                  //           borderRadius:
                                  //               BorderRadius.circular(2)),
                                  //     ),
                                  //   ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("${languageList[i]}"),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        color: AppColor.PrimaryDark,
                      ))
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "images/loging_baground.png",
        ),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                visibleIndex == 2
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          text(
                            "Sign Up",
                            textColor: Colors.black,
                            fontSize: 25.sp,
                            // fontFamily: fontRegular,
                            fontFamily: fontBold,
                          ),
                          text(
                            "By signing up, you agree to receive emails\nfrom AntsNest.",
                            textColor: Colors.black,
                            fontSize: 12.sp,
                            // fontFamily: fontRegular,
                            fontFamily: fontRegular,
                          ),
                        ],
                      ),
                Form(
                  key: _formKey,
                  child: visibleIndex == 1
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                          // physics: ClampingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: TextFormField(
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: "Enter your Full Name",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: AppColor().colorPrimary(),
                                  ),
                                  label: Text(
                                    "Full Name",
                                  ),
                                  hintStyle: TextStyle(
                                      //     color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                ),
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return "Enter your Full Name";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffF9F9F9),
                            //       borderRadius: BorderRadius.circular(12)),
                            //   child: TextFormField(
                            //     controller: nameController,
                            //     decoration: InputDecoration(
                            //       contentPadding:
                            //       EdgeInsets.symmetric(horizontal: 10),
                            //       hintText: "First name",
                            //       label: Text(
                            //         "First name",
                            //       ),
                            //       hintStyle: TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400),
                            //       border: InputBorder.none,
                            //     ),
                            //     validator: (v) {
                            //       if (v!.isEmpty) {
                            //         return "Enter first name";
                            //       }
                            //       return null;
                            //     },
                            //     keyboardType: TextInputType.text,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffF9F9F9),
                            //       borderRadius: BorderRadius.circular(12)),
                            //   child: TextFormField(
                            //     controller: lastController,
                            //     decoration: InputDecoration(
                            //       contentPadding:
                            //       EdgeInsets.symmetric(horizontal: 10),
                            //       hintText: "Last name",
                            //       label: Text(
                            //         "Last name",
                            //       ),
                            //       hintStyle: TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400),
                            //       border: InputBorder.none,
                            //     ),
                            //     validator: (v) {
                            //       if (v!.isEmpty) {
                            //         return "Enter last name";
                            //       }
                            //       return null;
                            //     },
                            //     keyboardType: TextInputType.text,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            /*Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      showCountryPicker(

                                        context: context,
                                        showPhoneCode: true,
                                        // optional. Shows phone code before the country name.
                                        onSelect: ( Country country) {
                                          print('Select country: ${country.countryCode}');
                                          String countryCode = country.countryCode;
                                          String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
                                                  (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
                                          print(flag);
                                          setState(() {
                                            phoneCode = country.phoneCode.toString();

                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 0),
                                      alignment: Alignment.center,
                                      height: 60,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF9F9F9),
                                          borderRadius: BorderRadius.circular(12),
                                      ),
                                      child:  Text('\u{20B9}'),),
                                  ),

                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF9F9F9),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: TextFormField(
                                        controller: mobileController,
                                        maxLength: 10,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                          hintText: "Mobile",
                                          label: Text(
                                            "Mobile",
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (v) {
                                          if (v!.isEmpty || v.length != 10) {
                                            return "Enter mobile number";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),*/
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: "Enter your Email Address",
                                  label: Text(
                                    "Email",
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: AppColor().colorPrimary(),
                                  ),
                                  hintStyle: TextStyle(
                                      //     color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  if (!v!.contains('@')) {
                                    return "Enter valid email";
                                  }
                                  // return false;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  width: double.infinity,
                                  height: 6.h,
                                  decoration: boxDecoration(
                                    radius: 6.0,
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          Image.asset(
                                            country,
                                            width: 6.04.w,
                                            height: 5.04.w,
                                            fit: BoxFit.fill,
                                            color: AppColor.PrimaryDark,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select Country',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: countryList
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id,
                                                child: Text(
                                                  item.nicename!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedCountry,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCountry = value as String;
                                          print("selectedCategory=>" +
                                              selectedCountry.toString());
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: AppColor.PrimaryDark,
                                      ),
                                      iconSize: 14,
                                      buttonHeight: 50,
                                      buttonWidth: 160,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Color(0xffF9F9F9),
                                      ),
                                      buttonElevation: 0,
                                      itemHeight: 40,
                                      itemPadding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      dropdownMaxHeight: 300,
                                      dropdownPadding: null,
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      dropdownElevation: 8,
                                      scrollbarRadius:
                                          const Radius.circular(40),
                                      scrollbarThickness: 6,
                                      scrollbarAlwaysShow: true,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //STATE
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  width: double.infinity,
                                  height: 6.h,
                                  decoration: boxDecoration(
                                    radius: 10.0,
                                  ),
                                  child: FutureBuilder(
                                      future: getState(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Row(
                                                children: [
                                                  Image.asset(
                                                    city,
                                                    width: 6.04.w,
                                                    height: 5.04.w,
                                                    fit: BoxFit.fill,
                                                    color: AppColor.PrimaryDark,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      'Select State',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              items: stateList
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item.id,
                                                        child: Text(
                                                          item.name!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectedState,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedState =
                                                      value as String;
                                                  print("selected State===>" +
                                                      selectedState.toString());
                                                  getCities();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: AppColor.PrimaryDark,
                                              ),
                                              iconSize: 14,
                                              buttonHeight: 50,
                                              buttonWidth: 160,
                                              buttonPadding:
                                                  const EdgeInsets.only(
                                                      left: 14, right: 14),
                                              buttonDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: Color(0xffF9F9F9),
                                              ),
                                              buttonElevation: 0,
                                              itemHeight: 40,
                                              itemPadding:
                                                  const EdgeInsets.only(
                                                      left: 14, right: 14),
                                              dropdownMaxHeight: 300,
                                              dropdownPadding: null,
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              dropdownElevation: 8,
                                              scrollbarRadius:
                                                  const Radius.circular(40),
                                              scrollbarThickness: 6,
                                              scrollbarAlwaysShow: true,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      })),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: double.infinity,
                                height: 6.h,
                                decoration: boxDecoration(
                                  radius: 10.0,
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Image.asset(
                                          city,
                                          width: 6.04.w,
                                          height: 5.04.w,
                                          fit: BoxFit.fill,
                                          color: AppColor.PrimaryDark,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select City',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: cityList
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.id,
                                              child: Text(
                                                item.name!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: SelectedSignleCity,
                                    onChanged: (value) {
                                      setState(() {
                                        SelectedSignleCity = value as String;
                                        print("selected State===>" +
                                            SelectedSignleCity.toString());
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: AppColor.PrimaryDark,
                                    ),
                                    iconSize: 14,
                                    buttonHeight: 50,
                                    buttonWidth: 160,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColor()
                                          .colorTextFour()
                                          .withOpacity(0.02),
                                    ),
                                    buttonElevation: 0,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 300,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
//Adress field is here
                            // Material(
                            //   elevation: 4,
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(6),
                            //   child: TextFormField(
                            //     controller: addressController,
                            //     keyboardType: TextInputType.streetAddress,
                            //     validator: FormValidation.checkEmptyValidator,
                            //     decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       contentPadding: EdgeInsets.only(top: 15),
                            //       hintText: "User Address",
                            //       prefixIcon: Icon(
                            //         Icons.location_on_outlined,
                            //         color: AppColor().colorPrimary(),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Container(
                            //   width: 69.99.w,
                            //   child: InkWell(
                            //     onTap: () {
                            //       getLocation();
                            //     },
                            //     child: Row(
                            //       children: [
                            //         Icon(
                            //           Icons.my_location_outlined,
                            //           color: Color(0xff666666),
                            //           size: 18,
                            //         ),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         Text(
                            //           "Use My Current Location",
                            //           style: TextStyle(
                            //             color: Color(0xff666666),
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            //COUNTRY
                            // CITY
                            // _selectedItems.isEmpty ?
                            // InkWell(
                            //      onTap: (){
                            //        _showMultiSelect();
                            //      },
                            //      child: Container(
                            //          width: double.infinity,
                            //          height: 6.h,
                            //          decoration: BoxDecoration(
                            //              borderRadius: BorderRadius.circular(10),
                            //              color: Colors.grey[100]
                            //          ),
                            //          // boxDecoration(
                            //          //   radius: 10.0,
                            //          // ),
                            //          child: _selectedItems.isEmpty ?
                            //          Padding(
                            //            padding: const EdgeInsets.only(left: 10.0, right: 10),
                            //            child: Row(
                            //              children: [
                            //                Image.asset(
                            //                  city,
                            //                  width: 6.04.w,
                            //                  height: 5.04.w,
                            //                  fit: BoxFit.fill,
                            //                  color: AppColor.PrimaryDark,
                            //                ),
                            //                Padding(
                            //                  padding: EdgeInsets.only(left: 8),
                            //                  child: Text(
                            //                    'Select Multiple Cities',
                            //                    style: TextStyle(
                            //                      fontSize: 14,
                            //                      color: Colors.black54,
                            //                      fontWeight: FontWeight.normal,
                            //                    ),
                            //                    overflow: TextOverflow.ellipsis,
                            //                  ),
                            //                ),
                            //              ],
                            //            ),
                            //          )
                            //              :  Wrap(
                            //            children: _selectedItems
                            //                .map((item){
                            //              print("okok ${item.id}");
                            //              return Padding(
                            //                padding: const EdgeInsets.only(left: 8.0, right: 8),
                            //                child: Chip(
                            //                  label:
                            //                  Text(
                            //                      "${item.name}"
                            //                    //item.name
                            //                  ),
                            //                ),
                            //              );
                            //            })
                            //                .toList(),
                            //          )
                            //        // FutureBuilder(
                            //        //     future: getCities(),
                            //        //     builder: (BuildContext context,
                            //        //         AsyncSnapshot snapshot) {
                            //        //       if (snapshot.hasData) {
                            //        //         return DropdownButtonHideUnderline(
                            //        //           child: DropdownButton2(
                            //        //             isExpanded: true,
                            //        //             hint: Row(
                            //        //               children: [
                            //        //                 Image.asset(
                            //        //                   city,
                            //        //                   width: 6.04.w,
                            //        //                   height: 5.04.w,
                            //        //                   fit: BoxFit.fill,
                            //        //                   color: AppColor.PrimaryDark,
                            //        //                 ),
                            //        //                 SizedBox(
                            //        //                   width: 4,
                            //        //                 ),
                            //        //                 Expanded(
                            //        //                   child: Text(
                            //        //                     'Select Multiple Cities',
                            //        //                     style: TextStyle(
                            //        //                       fontSize: 14,
                            //        //                       fontWeight: FontWeight.normal,
                            //        //                     ),
                            //        //                     overflow: TextOverflow.ellipsis,
                            //        //                   ),
                            //        //                 ),
                            //        //               ],
                            //        //             ),
                            //        //             items: cityList.map((item) {
                            //        //               return DropdownMenuItem<String>(
                            //        //                 value: item.id,
                            //        //                 enabled: false,
                            //        //                 child: StatefulBuilder(
                            //        //                   builder: (context, menuSetState) {
                            //        //                     final _isSelected =
                            //        //                         selectedCities
                            //        //                             .contains(item);
                            //        //                     print("SLECTED CITY");
                            //        //                     return InkWell(
                            //        //                       onTap: () {
                            //        //                         _isSelected
                            //        //                             ? selectedCities
                            //        //                                 .remove(item.id)
                            //        //                             : selectedCities
                            //        //                                 .add(item.id!);
                            //        //                         setState(() {});
                            //        //                         menuSetState(() {});
                            //        //                       },
                            //        //                       child: Container(
                            //        //                         height: double.infinity,
                            //        //                         padding: const EdgeInsets
                            //        //                                 .symmetric(
                            //        //                             horizontal: 16.0),
                            //        //                         child: Row(
                            //        //                           children: [
                            //        //                             _isSelected
                            //        //                                 ? const Icon(Icons
                            //        //                                     .check_box_outlined)
                            //        //                                 : const Icon(Icons
                            //        //                                     .check_box_outline_blank),
                            //        //                             const SizedBox(
                            //        //                                 width: 16),
                            //        //                             Text(
                            //        //                               item.name!,
                            //        //                               style:
                            //        //                                   const TextStyle(
                            //        //                                 fontSize: 14,
                            //        //                               ),
                            //        //                             ),
                            //        //                           ],
                            //        //                         ),
                            //        //                       ),
                            //        //                     );
                            //        //                   },
                            //        //                 ),
                            //        //               );
                            //        //             }).toList(),
                            //        //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                            //        //             value: selectedCities.isEmpty
                            //        //                 ? null
                            //        //                 : selectedCities.last,
                            //        //             onChanged: (value) {},
                            //        //             buttonHeight: 50,
                            //        //             buttonWidth: 160,
                            //        //             buttonPadding: const EdgeInsets.only(
                            //        //                 left: 14, right: 14),
                            //        //             buttonDecoration: BoxDecoration(
                            //        //               borderRadius:
                            //        //                   BorderRadius.circular(14),
                            //        //               color: Color(0xffF9F9F9),
                            //        //             ),
                            //        //             buttonElevation: 0,
                            //        //             itemHeight: 40,
                            //        //             itemPadding: const EdgeInsets.only(
                            //        //                 left: 14, right: 14),
                            //        //             dropdownMaxHeight: 300,
                            //        //             dropdownPadding: null,
                            //        //             dropdownDecoration: BoxDecoration(
                            //        //               borderRadius:
                            //        //                   BorderRadius.circular(14),
                            //        //             ),
                            //        //             dropdownElevation: 8,
                            //        //             scrollbarRadius:
                            //        //                 const Radius.circular(40),
                            //        //             scrollbarThickness: 6,
                            //        //             scrollbarAlwaysShow: true,
                            //        //             selectedItemBuilder: (context) {
                            //        //               return cityList.map(
                            //        //                 (item) {
                            //        //                   return Container(
                            //        //                     // alignment: AlignmentDirectional.center,
                            //        //                     padding:
                            //        //                         const EdgeInsets.symmetric(
                            //        //                             horizontal: 16.0),
                            //        //                     child: Text(
                            //        //                       selectedCities.join(','),
                            //        //                       style: const TextStyle(
                            //        //                         fontSize: 14,
                            //        //                         overflow:
                            //        //                             TextOverflow.ellipsis,
                            //        //                       ),
                            //        //                       maxLines: 1,
                            //        //                     ),
                            //        //                   );
                            //        //                 },
                            //        //               ).toList();
                            //        //             },
                            //        //           ),
                            //        //         );
                            //        //       } else if (snapshot.hasError) {
                            //        //         return Icon(Icons.error_outline);
                            //        //       } else {
                            //        //         return Center(
                            //        //             child: CircularProgressIndicator());
                            //        //       }
                            //        //     })
                            //      ),
                            //    ),
                            //    SizedBox(
                            //      height: 20,
                            //    ),

                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: IntlPhoneField(
                                controller: phoneController,
                                flagsButtonPadding: const EdgeInsets.all(8),
                                dropdownIconPosition: IconPosition.trailing,
                                decoration: InputDecoration(
                                  label:
                                      Text('Phone Number', style: TextStyle()),
                                  focusColor: AppColor.PrimaryDark,
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                  counterText: '',
                                  hintStyle: TextStyle(
                                      //     color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                initialCountryCode: 'IN',
                                validator: (v) {
                                  if (v!.number.isEmpty ||
                                      v.number.length < 6) {
                                    return "Enter mobile number";
                                  }
                                  return null;
                                },
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),

                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedCountry == null) {
                                    Fluttertoast.showToast(
                                        msg: "please select country");
                                  } else if (selectedState == null) {
                                    Fluttertoast.showToast(
                                        msg: "please select state");
                                  } else if (SelectedSignleCity == null) {
                                    Fluttertoast.showToast(
                                        msg: "please select city");
                                  } else if (phoneController.text.isEmpty ||
                                      phoneController.text.length != 10) {
                                    Fluttertoast.showToast(
                                        msg: "please add valid mobile no");
                                  } else {
                                    setState(() {
                                      visibleIndex = 2;
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "please fill all fields");
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                alignment: Alignment.center,
                                //width: MediaQuery.of(context).size.width/2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ),
                            ),

                            /// sign up button
                            // InkWell(
                            //   onTap: () {
                            //     cityIdList.clear();
                            //     print("ok nowoooo ${cityIdList.length}");
                            //     for(var i=0;i<_selectedItems.length;i++){
                            //       print("check now ${_selectedItems[i].id}");
                            //       cityIdList.add(_selectedItems[i].id);
                            //     }
                            //     print("yes ${cityIdList.length}");
                            //     if (_formKey.currentState!.validate()) {
                            //       signUpFunction();
                            //     } else {}
                            //   },
                            //   child: Container(
                            //     height: 45,
                            //     alignment: Alignment.center,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //       color: AppColor.PrimaryDark,
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     child: Text(
                            //       "SignUp",
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 17),
                            //     ),
                            //   ),
                            // ),

                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                top: 30,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    edit = true;
                                  });
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  setState(() {
                                    edit = false;
                                  });
                                  Navigator.pop(context);
                                },
                                child: ScaleAnimatedWidget.tween(
                                  enabled: edit,
                                  duration: Duration(milliseconds: 200),
                                  scaleDisabled: 1.0,
                                  scaleEnabled: 0.8,
                                  child: RichText(
                                    text: new TextSpan(
                                      text: "Already Have An Account? ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontFamily: fontBold,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                          text: 'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
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
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                          // physics: ClampingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 15,
                            ),

                            ///  portfolio / website
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: portfolioController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Portfolio / website is required";
                                    } else if (!isValidUrl(v!)) {
                                      return "Portfolio / website is invalid";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Enter your Portfolio/Website",
                                    label: Text(
                                      "Portfolio / Website",
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  // validator: (v) {
                                  //   if (v!.isEmpty) {
                                  //     return "Enter valid value";
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "(At least One Social Media link is Required*)",
                                style: TextStyle(color: AppColor.PrimaryDark),
                              ),
                            ),

                            /// twitter link
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: twitterController,
                                  // validator: (v){
                                  //   if(v!.isEmpty){
                                  //     return "Twitter is required";
                                  //   }
                                  // },
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "https://twitter.com/",
                                    label: Text(
                                      "Twitter link",
                                    ),
                                    hintStyle: TextStyle(
                                        // color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  // validator: (v) {
                                  //   if (v!.isEmpty) {
                                  //     return "Enter valid value";
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            /// instagram link
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: instagramController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "https://instagram.com/",
                                    label: Text(
                                      "Instagram link",
                                    ),
                                    hintStyle: TextStyle(
                                        // color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  // validator: (v) {
                                  //   if (v!.isEmpty) {
                                  //     return "";
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: facebookLinkController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "https://facebook.com/",
                                    label: Text(
                                      "Facebook link",
                                    ),
                                    hintStyle: TextStyle(
                                        // color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  // validator: (v) {
                                  //   if (v!.isEmpty) {
                                  //     return "";
                                  //   }
                                  //   return null;
                                  // },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: linkedInController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "https://linkedin.com/",
                                    label: Text(
                                      "LinkedIn link",
                                    ),
                                    hintStyle: TextStyle(
                                        // color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  // validator: (v) {
                                  //   if (v!.isEmpty) {
                                  //     return "Enter linkedIn link";
                                  //   }
                                  //   return null;
                                  //},
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: equipmentController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Enter your Equipment Used",
                                    label: Text(
                                      "Equipment used (optional)",
                                    ),
                                    hintStyle: TextStyle(
                                        //  color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  /*validator: (v) {
                                      if (v!.isEmpty) {
                                        return "Enter equipment";
                                      }
                                      return null;
                                    },*/
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                _selectDate();
                              },
                              child: Material(
                                elevation: 4,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  width: double.infinity,
                                  height: 6.5.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2.h),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: _dateValue.length > 0
                                      ? Text("$dateFormate")
                                      : Text(
                                          "When is your birthday?",
                                          style: TextStyle(
                                              color: AppColor()
                                                  .colorTextFour()
                                                  .withOpacity(0.7),
                                              fontSize: 15),
                                        ),
                                  // TextFormField(
                                  //   controller: birthDayController,
                                  //   decoration: InputDecoration(
                                  //     contentPadding:
                                  //     EdgeInsets.symmetric(horizontal: 10),
                                  //     hintText: "dd/mm/yyyy",
                                  //     label: Text(
                                  //       "Enter Birthday",
                                  //     ),
                                  //     hintStyle: TextStyle(
                                  //         color: Colors.black,
                                  //         fontWeight: FontWeight.w400),
                                  //     border: InputBorder.none,
                                  //   ),
                                  //   validator: (v) {
                                  //     if (v!.isEmpty) {
                                  //       return "Enter your birthday";
                                  //     }
                                  //     return null;
                                  //   },
                                  //   keyboardType: TextInputType.text,
                                  // ),
                                ),
                              ),
                            ),
                            !dobError
                                ? Container()
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Enter your date of birth',
                                      style: TextStyle(
                                          color: AppColor.PrimaryDark),
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            ),

                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                //  /   height: 65,
                                padding: EdgeInsets.symmetric(vertical: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: comfertableServiceController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText:
                                        "What kinds of Service do you feel most comfortable doing ?",
                                    label: Text(
                                      "What kinds of Service do you feel most comfortable doing ?",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Enter service";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Material(
                            //   elevation: 4,
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(6),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(vertical: 6),
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(12)),
                            //     child: TextFormField(
                            //       controller: serviceInfoController,
                            //       decoration: InputDecoration(
                            //         contentPadding:
                            //             EdgeInsets.symmetric(horizontal: 10),
                            //         hintText: "Service Info",
                            //         label: Text(
                            //           "Service Info",
                            //         ),
                            //         hintStyle: TextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.w400),
                            //         border: InputBorder.none,
                            //       ),
                            //       validator: (v) {
                            //         if (v!.isEmpty) {
                            //           return "Enter info";
                            //         }
                            //         return null;
                            //       },
                            //       keyboardType: TextInputType.text,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Color(0xffF9F9F9),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: whyJoinController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText:
                                        "Why do you want to join antsnest?",
                                    label: Text(
                                      "Why do you want to join antsnest?",
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Enter reason";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  width: double.infinity,
                                  height: 6.h,
                                  decoration: boxDecoration(
                                    radius: 10.0,
                                  ),
                                  child: FutureBuilder(
                                      future: getServiceCategory(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        ServiceCategoryModel serviceModel =
                                            snapshot.data;
                                        if (snapshot.hasData) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Text(
                                                'Select Category',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              items: serviceModel.data!
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item.id,
                                                        child: Text(
                                                          item.cName!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: selectedCategory,
                                              onChanged: (value) {
                                                var serviceName = "";

                                                setState(() {
                                                  var serviceName = "";
                                                  selectedCategory =
                                                      value as String;
                                                });
                                                categorylist.clear();
                                                print(selectedCategory);
                                                serviceName = serviceModel.data!
                                                    .firstWhere((element) =>
                                                        element.id == value)
                                                    .cName
                                                    .toString();
                                                print(serviceName.toString());

                                                getServicesSubCategory(
                                                    selectedCategory,
                                                    serviceName);
                                                print(
                                                    "CATEGORY ID issssss== $selectedCategory");
                                              },
                                              icon: const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: AppColor.PrimaryDark,
                                              ),
                                              iconSize: 14,
                                              buttonHeight: 50,
                                              buttonWidth: 160,
                                              buttonPadding:
                                                  const EdgeInsets.only(
                                                      left: 14, right: 14),
                                              buttonDecoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  // color: AppColor().colorEdit(),
                                                  color: Colors.grey
                                                      .withOpacity(0.05)),
                                              buttonElevation: 0,
                                              itemHeight: 40,
                                              itemPadding:
                                                  const EdgeInsets.only(
                                                      left: 14, right: 14),
                                              dropdownMaxHeight: 300,
                                              dropdownPadding: null,
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              dropdownElevation: 8,
                                              scrollbarRadius:
                                                  const Radius.circular(40),
                                              scrollbarThickness: 6,
                                              scrollbarAlwaysShow: true,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          print("ERROR===" +
                                              snapshot.error.toString());
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      })),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            serviceSubCategoryModel == null
                                ? SizedBox()
                                : Material(
                                    elevation: 4,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    child: MultiSelectDropDown(
                                      hint: "Select Sub Category",
                                      clearIcon: const Icon(Icons.cancel),

                                      controller: multiSelectController,
                                      borderColor: Colors.transparent,

                                      onOptionSelected: (options) {
                                        categorylist.clear();
                                        for (int i = 0;
                                            i < options.length;
                                            i++) {
                                          String value = options[i].value ?? "";

                                          // Check if the value is not already in the set
                                          // if (uniqueValues.add(value)) {
                                          //   print(value);

                                          categorylist.add(value);
                                          setState(() {});
                                          // }
                                        }

                                        // setState(() {
                                        //
                                        // });
                                        debugPrint(categorylist.toString());
                                      },
                                      options: <ValueItem>[
                                        for (int i = 0;
                                            i <
                                                serviceSubCategoryModel!
                                                    .data!.length;
                                            i++) ...[
                                          ValueItem(
                                            label:
                                                "${serviceSubCategoryModel!.data![i].cName}",
                                            value:
                                                "${serviceSubCategoryModel!.data![i].id}",
                                          )
                                        ]
                                      ],

                                      selectionType: SelectionType.multi,
                                      // selectedOptions: [
                                      //   for (int i = 0; i < serviceSubCategoryModel!.data!.length; i++) ...[
                                      //     "${subCategory!.data![i].id}" == widget.profileResponse?.user?.jsonData?.subCat.toString()
                                      //         ? ValueItem(
                                      //       label: "${subCategory!.data![i].cName}",
                                      //       value: "${subCategory!.data![i].id}",
                                      //     )
                                      //         : ValueItem(label: "")
                                      //   ]
                                      // ]..removeWhere((element) => element.label == ""), // Remove null entries
                                      chipConfig: const ChipConfig(
                                        wrapType: WrapType.scroll,
                                        backgroundColor: AppColor.PrimaryDark,
                                      ),
                                      dropdownHeight: 300,
                                      optionTextStyle:
                                          const TextStyle(fontSize: 16),
                                      selectedOptionIcon: const Icon(
                                        Icons.check_circle,
                                        color: AppColor.PrimaryDark,
                                      ),
                                      selectedOptionTextColor:
                                          AppColor.PrimaryDark,
                                      // suffixIcon: IconData(),
                                      // selectedItemBuilder: (BuildContext context, ValueItem item,) {
                                      //   // Customize the appearance of the selected item here
                                      //   return Container(
                                      //     padding: EdgeInsets.all(8.0),
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.red, // Set the background color to red
                                      //       borderRadius: BorderRadius.circular(5.0),
                                      //     ),
                                      //     child: Row(
                                      //       mainAxisSize: MainAxisSize.min,
                                      //       children: [
                                      //         Text(item.label),
                                      //         const SizedBox(width: 8.0),
                                      //         Icon(Icons.close, color: Colors.white, size: 18.0),
                                      //       ],
                                      //     ),
                                      //   );
                                      // },
                                    ),
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            // GestureDetector(
                            //     onTap: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return FruitSelectionDialog(customMap: customMap,);
                            //         },
                            //       ).then((selectedFruits) {
                            //         if (selectedFruits != null) {
                            //           print('Selected fruits: $selectedFruits');
                            //         }
                            //         customMap.forEach((key, value) {
                            //           print('Key: $key');
                            //           value.forEach((element) {
                            //             print(
                            //                 'Id: ${element.id}, Name: ${element.cName}');
                            //           });
                            //         });
                            //       });
                            //     },
                            //     child: Text("SELECT SUB CATEGORY")),

                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: Color(0xffF9F9F9),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextFormField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Amount per Hour/Day",
                                    label: Text(
                                      "Amount",
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    border: InputBorder.none,
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Enter amount";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Select the Hours / Days *')),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  elevation: 4,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    width: 40.w,
                                    height: 6.h,
                                    decoration: boxDecoration(
                                      radius: 10.0,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Text(
                                          'No of days',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: noofDayList
                                            .map((String? item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: noOfDays,
                                        onChanged: (value) {
                                          setState(() {
                                            noOfDays = value as String;
                                            // // serviceName.text = serviceModel.data!
                                            //     .firstWhere((element) => element.id == value)
                                            //     .cName
                                            //     .toString();
                                          });
                                          print("CATEGORY ID== $noOfDays");
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: AppColor.PrimaryDark,
                                        ),
                                        iconSize: 14,
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            // color: AppColor().colorEdit(),
                                            color:
                                                Colors.grey.withOpacity(0.05)),
                                        buttonElevation: 0,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 300,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  elevation: 4,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    width: 45.w,
                                    height: 6.h,
                                    decoration: boxDecoration(
                                      radius: 10.0,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Hours / Day',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        items: timeList
                                            .map((String? item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedDayHour,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedDayHour = value as String;
                                            // // serviceName.text = serviceModel.data!
                                            //     .firstWhere((element) => element.id == value)
                                            //     .cName
                                            //     .toString();
                                          });
                                          print(
                                              "CATEGORY ID== $selectedCategory");
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: AppColor.PrimaryDark,
                                        ),
                                        iconSize: 14,
                                        buttonHeight: 50,
                                        buttonWidth: 160,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            // color: AppColor().colorEdit(),
                                            color:
                                                Colors.grey.withOpacity(0.05)),
                                        buttonElevation: 0,
                                        itemHeight: 40,
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownMaxHeight: 300,
                                        dropdownPadding: null,
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        dropdownElevation: 8,
                                        scrollbarRadius:
                                            const Radius.circular(40),
                                        scrollbarThickness: 6,
                                        scrollbarAlwaysShow: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 15,
                            ),

                            InkWell(
                              onTap: () async {
                                await openLanguageList();
                                setState(() {});
                              },
                              child: Material(
                                elevation: 4,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                    width: double.infinity,
                                    height: 6.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.05),
                                    ),
                                    child: selectedLanguageList.isEmpty
                                        ? Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Language(S) Spoken",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                selectedLanguageList.length,
                                            itemBuilder: (c, i) {
                                              return Container(
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   borderRadius: BorderRadius.circular(12),
                                                  //   border: Border.all(color: Colors.grey)
                                                  // ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: selectedLanguageList
                                                                .length >
                                                            1
                                                        ? Text(
                                                            "${selectedLanguageList[i]} ,")
                                                        : Text(
                                                            "${selectedLanguageList[i]}"),
                                                  ));
                                            })
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10.0, right: 10),
                                    //   child: Row(
                                    //     children: [
                                    //       Padding(
                                    //         padding: EdgeInsets.only(left: 8),
                                    //         child:
                                    //        selectedLanguageList.isEmpty ?  Text(
                                    //           'Language(S) Spoken',
                                    //           style: TextStyle(
                                    //             fontSize: 14,
                                    //             color: Colors.black54,
                                    //             fontWeight: FontWeight.normal,
                                    //           ),
                                    //           overflow: TextOverflow.ellipsis,
                                    //         ) : Text("${selectedLanguageList.toString()}"),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    // ListView.builder(
                                    //     shrinkWrap: true,
                                    //     itemCount: languageList.length,
                                    //     itemBuilder: (context,i){
                                    //   return Container(
                                    //     child: Text("${languageList[i]}"),
                                    //   );
                                    // }),
                                    // DropdownButtonHideUnderline(
                                    //   child: DropdownButton2(
                                    //     isExpanded: true,
                                    //     hint: Text(
                                    //       'Language(S) Spoken',
                                    //       style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.normal,
                                    //       ),
                                    //       overflow: TextOverflow.ellipsis,
                                    //     ),
                                    //     items: languageList
                                    //         .map((String? item) => DropdownMenuItem<String>(
                                    //       value: item,
                                    //       child: Text(
                                    //         item.toString(),
                                    //         style: const TextStyle(
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.black,
                                    //         ),
                                    //         overflow: TextOverflow.ellipsis,
                                    //       ),
                                    //     ))
                                    //         .toList(),
                                    //     value: selectedLanguage,
                                    //     onChanged: (value) {
                                    //       setState(() {
                                    //         selectedLanguage = value as String;
                                    //         // // serviceName.text = serviceModel.data!
                                    //         //     .firstWhere((element) => element.id == value)
                                    //         //     .cName
                                    //         //     .toString();
                                    //
                                    //       });
                                    //       print("CATEGORY ID== $selectedCategory");
                                    //     },
                                    //     icon: const Icon(
                                    //       Icons.arrow_forward_ios_outlined,
                                    //       color: AppColor.PrimaryDark,
                                    //     ),
                                    //     iconSize: 14,
                                    //     buttonHeight: 50,
                                    //     buttonWidth: 160,
                                    //     buttonPadding:
                                    //     const EdgeInsets.only(left: 14, right: 14),
                                    //     buttonDecoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(14),
                                    //         // color: AppColor().colorEdit(),
                                    //         color: Colors.grey.withOpacity(0.05)
                                    //     ),
                                    //     buttonElevation: 0,
                                    //     itemHeight: 40,
                                    //     itemPadding:
                                    //     const EdgeInsets.only(left: 14, right: 14),
                                    //     dropdownMaxHeight: 300,
                                    //     dropdownPadding: null,
                                    //     dropdownDecoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(14),
                                    //     ),
                                    //     dropdownElevation: 8,
                                    //     scrollbarRadius: const Radius.circular(40),
                                    //     scrollbarThickness: 6,
                                    //     scrollbarAlwaysShow: true,
                                    //   ),
                                    // ),
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: double.infinity,
                                height: 6.h,
                                decoration: boxDecoration(
                                  radius: 10.0,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Can Travel',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: travelList
                                        .map((String? item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedTravel,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTravel = value as String;
                                        // // serviceName.text = serviceModel.data!
                                        //     .firstWhere((element) => element.id == value)
                                        //     .cName
                                        //     .toString();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: AppColor.PrimaryDark,
                                    ),
                                    iconSize: 14,
                                    buttonHeight: 50,
                                    buttonWidth: 160,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        // color: AppColor().colorEdit(),
                                        color: Colors.grey.withOpacity(0.05)),
                                    buttonElevation: 0,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 300,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     _showMultiSelect();
                            //   },
                            //   child: Material(
                            //     elevation: 4,
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(6),
                            //     child: Container(
                            //         width: double.infinity,
                            //         height: 6.h,
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: Colors.grey[100]),
                            //         // boxDecoration(
                            //         //   radius: 10.0,
                            //         // ),
                            //         child: _selectedItems.isEmpty
                            //             ? Padding(
                            //                 padding: const EdgeInsets.only(
                            //                     left: 10.0, right: 10),
                            //                 child: Row(
                            //                   children: [
                            //                     Image.asset(
                            //                       city,
                            //                       width: 6.04.w,
                            //                       height: 5.04.w,
                            //                       fit: BoxFit.fill,
                            //                       color: AppColor.PrimaryDark,
                            //                     ),
                            //                     Padding(
                            //                       padding:
                            //                           EdgeInsets.only(left: 8),
                            //                       child: Text(
                            //                         'Select Multiple Cities',
                            //                         style: TextStyle(
                            //                           fontSize: 14,
                            //                           color: Colors.black54,
                            //                           fontWeight:
                            //                               FontWeight.normal,
                            //                         ),
                            //                         overflow:
                            //                             TextOverflow.ellipsis,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               )
                            //             : ListView.builder(
                            //                 itemCount: _selectedItems.length,
                            //                 physics:
                            //                     AlwaysScrollableScrollPhysics(),
                            //                 scrollDirection: Axis.horizontal,
                            //                 itemBuilder: (c, i) {
                            //                   return Padding(
                            //                     padding:
                            //                         EdgeInsets.only(right: 5),
                            //                     child: Chip(
                            //                       label: Text(
                            //                           "${_selectedItems[i].name}"),
                            //                     ),
                            //                   );
                            //                 })
                            //         // Wrap(
                            //         //   children: _selectedItems
                            //         //       .map((item){
                            //         //     print("okok ${item.id}");
                            //         //     return Padding(
                            //         //       padding: const EdgeInsets.only(left: 8.0, right: 8),
                            //         //       child: Chip(
                            //         //         label:
                            //         //         Text(
                            //         //             "${item.name}"
                            //         //           //item.name
                            //         //         ),
                            //         //       ),
                            //         //     );
                            //         //   })
                            //         //       .toList(),
                            //         // )

                            //         // FutureBuilder(
                            //         //     future: getCities(),
                            //         //     builder: (BuildContext context,
                            //         //         AsyncSnapshot snapshot) {
                            //         //       if (snapshot.hasData) {
                            //         //         return DropdownButtonHideUnderline(
                            //         //           child: DropdownButton2(
                            //         //             isExpanded: true,
                            //         //             hint: Row(
                            //         //               children: [
                            //         //                 Image.asset(
                            //         //                   city,
                            //         //                   width: 6.04.w,
                            //         //                   height: 5.04.w,
                            //         //                   fit: BoxFit.fill,
                            //         //                   color: AppColor.PrimaryDark,
                            //         //                 ),
                            //         //                 SizedBox(
                            //         //                   width: 4,
                            //         //                 ),
                            //         //                 Expanded(
                            //         //                   child: Text(
                            //         //                     'Select Multiple Cities',
                            //         //                     style: TextStyle(
                            //         //                       fontSize: 14,
                            //         //                       fontWeight: FontWeight.normal,
                            //         //                     ),
                            //         //                     overflow: TextOverflow.ellipsis,
                            //         //                   ),
                            //         //                 ),
                            //         //               ],
                            //         //             ),
                            //         //             items: cityList.map((item) {
                            //         //               return DropdownMenuItem<String>(
                            //         //                 value: item.id,
                            //         //                 enabled: false,
                            //         //                 child: StatefulBuilder(
                            //         //                   builder: (context, menuSetState) {
                            //         //                     final _isSelected =
                            //         //                         selectedCities
                            //         //                             .contains(item);
                            //         //                     print("SLECTED CITY");
                            //         //                     return InkWell(
                            //         //                       onTap: () {
                            //         //                         _isSelected
                            //         //                             ? selectedCities
                            //         //                                 .remove(item.id)
                            //         //                             : selectedCities
                            //         //                                 .add(item.id!);
                            //         //                         setState(() {});
                            //         //                         menuSetState(() {});
                            //         //                       },
                            //         //                       child: Container(
                            //         //                         height: double.infinity,
                            //         //                         padding: const EdgeInsets
                            //         //                                 .symmetric(
                            //         //                             horizontal: 16.0),
                            //         //                         child: Row(
                            //         //                           children: [
                            //         //                             _isSelected
                            //         //                                 ? const Icon(Icons
                            //         //                                     .check_box_outlined)
                            //         //                                 : const Icon(Icons
                            //         //                                     .check_box_outline_blank),
                            //         //                             const SizedBox(
                            //         //                                 width: 16),
                            //         //                             Text(
                            //         //                               item.name!,
                            //         //                               style:
                            //         //                                   const TextStyle(
                            //         //                                 fontSize: 14,
                            //         //                               ),
                            //         //                             ),
                            //         //                           ],
                            //         //                         ),
                            //         //                       ),
                            //         //                     );
                            //         //                   },
                            //         //                 ),
                            //         //               );
                            //         //             }).toList(),
                            //         //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                            //         //             value: selectedCities.isEmpty
                            //         //                 ? null
                            //         //                 : selectedCities.last,
                            //         //             onChanged: (value) {},
                            //         //             buttonHeight: 50,
                            //         //             buttonWidth: 160,
                            //         //             buttonPadding: const EdgeInsets.only(
                            //         //                 left: 14, right: 14),
                            //         //             buttonDecoration: BoxDecoration(
                            //         //               borderRadius:
                            //         //                   BorderRadius.circular(14),
                            //         //               color: Color(0xffF9F9F9),
                            //         //             ),
                            //         //             buttonElevation: 0,
                            //         //             itemHeight: 40,
                            //         //             itemPadding: const EdgeInsets.only(
                            //         //                 left: 14, right: 14),
                            //         //             dropdownMaxHeight: 300,
                            //         //             dropdownPadding: null,
                            //         //             dropdownDecoration: BoxDecoration(
                            //         //               borderRadius:
                            //         //                   BorderRadius.circular(14),
                            //         //             ),
                            //         //             dropdownElevation: 8,
                            //         //             scrollbarRadius:
                            //         //                 const Radius.circular(40),
                            //         //             scrollbarThickness: 6,
                            //         //             scrollbarAlwaysShow: true,
                            //         //             selectedItemBuilder: (context) {
                            //         //               return cityList.map(
                            //         //                 (item) {
                            //         //                   return Container(
                            //         //                     // alignment: AlignmentDirectional.center,
                            //         //                     padding:
                            //         //                         const EdgeInsets.symmetric(
                            //         //                             horizontal: 16.0),
                            //         //                     child: Text(
                            //         //                       selectedCities.join(','),
                            //         //                       style: const TextStyle(
                            //         //                         fontSize: 14,
                            //         //                         overflow:
                            //         //                             TextOverflow.ellipsis,
                            //         //                       ),
                            //         //                       maxLines: 1,
                            //         //                     ),
                            //         //                   );
                            //         //                 },
                            //         //               ).toList();
                            //         //             },
                            //         //           ),
                            //         //         );
                            //         //       } else if (snapshot.hasError) {
                            //         //         return Icon(Icons.error_outline);
                            //         //       } else {
                            //         //         return Center(
                            //         //             child: CircularProgressIndicator());
                            //         //       }
                            //         //     })
                            //         ),
                            //   ),
                            // ),

                            termsAndCondition(),
                            SizedBox(
                              height: 30,
                            ),

                            // Container(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffF9F9F9),
                            //       borderRadius: BorderRadius.circular(12)),
                            //   child: TextFormField(
                            //     controller: mobileController,
                            //     maxLength: 10,
                            //     decoration: InputDecoration(
                            //       counterText: "",
                            //       contentPadding:
                            //       EdgeInsets.symmetric(horizontal: 10),
                            //       hintText: "Mobile",
                            //       label: Text(
                            //         "Mobile",
                            //       ),
                            //       hintStyle: TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400),
                            //       border: InputBorder.none,
                            //     ),
                            //     keyboardType: TextInputType.number,
                            //     validator: (v) {
                            //       if (v!.isEmpty || v.length != 10) {
                            //         return "Enter mobile nuber";
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffF9F9F9),
                            //       borderRadius: BorderRadius.circular(12)),
                            //   child: TextFormField(
                            //     controller: emailController,
                            //     decoration: InputDecoration(
                            //       contentPadding:
                            //       EdgeInsets.symmetric(horizontal: 10),
                            //       hintText: "Email",
                            //       label: Text(
                            //         "Email",
                            //       ),
                            //       hintStyle: TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w400),
                            //       border: InputBorder.none,
                            //     ),
                            //     keyboardType: TextInputType.emailAddress,
                            //     validator: (v) {
                            //       if (!v!.contains('@')) {
                            //         return "Enter valid email";
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   decoration: BoxDecoration(
                            //       color: Color(0xffF9F9F9),
                            //       borderRadius: BorderRadius.circular(12)),
                            //   child: TextFormField(
                            //     controller: addressController,
                            //     keyboardType: TextInputType.streetAddress,
                            //     validator: FormValidation.checkEmptyValidator,
                            //     decoration: InputDecoration(
                            //       border: InputBorder.none,
                            //       contentPadding: EdgeInsets.zero,
                            //       hintText: "User Address",
                            //       prefixIcon: Icon(
                            //         Icons.location_on_outlined,
                            //         color: Colors.grey,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   width: 69.99.w,
                            //   child: InkWell(
                            //     onTap: () {
                            //       getLocation();
                            //     },
                            //     child: Row(
                            //       children: [
                            //         Icon(Icons.my_location_outlined,
                            //             color: Color(0xff666666)),
                            //         Text(
                            //           "Use My Current Location",
                            //           style: TextStyle(
                            //             color: Color(0xff666666),
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // //COUNTRY
                            // Container(
                            //     width: double.infinity,
                            //     height: 6.h,
                            //     decoration: boxDecoration(
                            //       radius: 10.0,
                            //     ),
                            //     child: DropdownButtonHideUnderline(
                            //       child: DropdownButton2(
                            //         isExpanded: true,
                            //         hint: Row(
                            //           children: [
                            //             Image.asset(
                            //               country,
                            //               width: 6.04.w,
                            //               height: 5.04.w,
                            //               fit: BoxFit.fill,
                            //               color: AppColor.PrimaryDark,
                            //             ),
                            //             SizedBox(
                            //               width: 4,
                            //             ),
                            //             Expanded(
                            //               child: Text(
                            //                 'Select Country',
                            //                 style: TextStyle(
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.normal,
                            //                 ),
                            //                 overflow: TextOverflow.ellipsis,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         items: countryList
                            //             .map((item) => DropdownMenuItem<String>(
                            //           value: item.id,
                            //           child: Text(
                            //             item.name!,
                            //             style: const TextStyle(
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black,
                            //             ),
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ))
                            //             .toList(),
                            //         value: selectedCountry,
                            //         onChanged: (value) {
                            //           setState(() {
                            //             selectedCountry = value as String;
                            //             print("selectedCategory=>" +
                            //                 selectedCountry.toString());
                            //           });
                            //         },
                            //         icon: const Icon(
                            //           Icons.arrow_forward_ios_outlined,
                            //           color: AppColor.PrimaryDark,
                            //         ),
                            //         iconSize: 14,
                            //         buttonHeight: 50,
                            //         buttonWidth: 160,
                            //         buttonPadding:
                            //         const EdgeInsets.only(left: 14, right: 14),
                            //         buttonDecoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(14),
                            //           color: Color(0xffF9F9F9),
                            //         ),
                            //         buttonElevation: 0,
                            //         itemHeight: 40,
                            //         itemPadding:
                            //         const EdgeInsets.only(left: 14, right: 14),
                            //         dropdownMaxHeight: 300,
                            //         dropdownPadding: null,
                            //         dropdownDecoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(14),
                            //         ),
                            //         dropdownElevation: 8,
                            //         scrollbarRadius: const Radius.circular(40),
                            //         scrollbarThickness: 6,
                            //         scrollbarAlwaysShow: true,
                            //       ),
                            //     )),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            //STATE

                            // _selectedItems.isEmpty ?

                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        visibleIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Previous",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        dobError = false;
                                      });
                                      cityIdList.clear();
                                      print("ok nowoooo ${cityIdList.length}");
                                      for (var i = 0;
                                          i < _selectedItems.length;
                                          i++) {
                                        print(
                                            "check now ${_selectedItems[i].id}");
                                        cityIdList.add(_selectedItems[i].name);
                                      }
                                      print("yes ${cityIdList.length}");
                                      if (_formKey.currentState!.validate()) {
                                        if (dateFormate == null) {
                                          dobError = true;
                                          setState(() {});
                                          showSnackBar(context,
                                              'please enter date of birth');
                                        } else if (selectedCategory == null) {
                                          showSnackBar(context,
                                              'please select category');
                                        } else if (noOfDays == null) {
                                          showSnackBar(
                                              context, 'please select days');
                                        } else if (selectedDayHour == null) {
                                          showSnackBar(
                                              context, 'please select hours');
                                        } else if (twitterController
                                                .text.isEmpty &&
                                            instagramController.text.isEmpty &&
                                            facebookLinkController
                                                .text.isEmpty &&
                                            linkedInController.text.isEmpty) {
                                          showSnackBar(context,
                                              'At least One Social Media link is Required');
                                        } else if (!_isChecked) {
                                          showSnackBar(context,
                                              'please check terms & condition');
                                        } else {
                                          signUpFunction();
                                        }
                                      } else {
                                        var snackBar = SnackBar(
                                          content: Text('Details are required'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Sign up",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            /// sign up button
                            // InkWell(
                            //   onTap: () {
                            //     cityIdList.clear();
                            //     print("ok nowoooo ${cityIdList.length}");
                            //     for(var i=0;i<_selectedItems.length;i++){
                            //       print("check now ${_selectedItems[i].id}");
                            //       cityIdList.add(_selectedItems[i].id);
                            //     }
                            //     print("yes ${cityIdList.length}");
                            //     if (_formKey.currentState!.validate()) {
                            //       signUpFunction();
                            //     } else {}
                            //   },
                            //   child: Container(
                            //     height: 45,
                            //     alignment: Alignment.center,
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //       color: AppColor.PrimaryDark,
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     child: Text(
                            //       "SignUp",
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.w500,
                            //           fontSize: 17),
                            //     ),
                            //   ),
                            // ),

                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                top: 30,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    edit = true;
                                  });
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  setState(() {
                                    edit = false;
                                  });
                                  Navigator.pop(context);
                                },
                                child: ScaleAnimatedWidget.tween(
                                  enabled: edit,
                                  duration: Duration(milliseconds: 200),
                                  scaleDisabled: 1.0,
                                  scaleEnabled: 0.8,
                                  child: RichText(
                                    text: new TextSpan(
                                      text: "Already Have An Account? ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontFamily: fontBold,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                          text: 'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.sp,
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
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isChecked = false;

  Widget termsAndCondition() {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            child: Checkbox(
              value: _isChecked,
              onChanged: (newValue) {
                setState(() {
                  _isChecked = newValue!;
                });
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('I agree to Antsnest', style: TextStyle(fontSize: 12)),
              RichText(
                softWrap: false,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicyScreen(),
                              ));

                          // Handle the Privacy Policy click action here.
                        },
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the Terms and Conditions click action here.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsConditionScreen(),
                              ));
                        },
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget firstSign(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 6.32.h,
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    validator: FormValidation.checkEmptyValidator,
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
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      helperText: '',
                      counterText: '',
                      fillColor: AppColor().colorEdit(),
                      enabled: true,
                      filled: true,
                      prefixIcon: Container(
                        padding: EdgeInsets.all(3.5.w),
                        child: Image.asset(
                          person,
                          width: 1.04.w,
                          height: 1.04.w,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
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
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    maxLength: 10,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.phone,
                    validator: FormValidation.validateMobile,
                    controller: phoneController,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Mobile Number',
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
                          phone,
                          width: 2.04.w,
                          height: 2.04.w,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 0.5.h,
                ),

                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    validator: FormValidation.checkEmptyValidator,
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
                      labelText: 'Password',
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
                          lock,
                          width: 2.04.w,
                          height: 2.04.w,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),

                // productListWidget2() ,

                serviceListWidget(),
                SizedBox(
                  height: 16,
                ),

                // SizedBox(
                //   height: 0.5.h,
                // ),
                // Container(
                //   width: 69.99.w,
                //   height: 9.46.h,
                //   child: TextFormField(
                //     cursorColor: Colors.red,
                //     obscureText: true,
                //     keyboardType: TextInputType.visiblePassword,
                //     controller: cPassController,
                //     style: TextStyle(
                //       color: AppColor().colorTextFour(),
                //       fontSize: 10.sp,
                //     ),
                //     inputFormatters: [],
                //     decoration: InputDecoration(
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: AppColor().colorEdit(),
                //             width: 1.0,
                //             style: BorderStyle.solid),
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       ),
                //       labelText: 'Confirm Password',
                //       labelStyle: TextStyle(
                //         color: AppColor().colorTextFour(),
                //         fontSize: 10.sp,
                //       ),
                //       helperText: '',
                //       counterText: '',
                //       fillColor: AppColor().colorEdit(),
                //       enabled: true,
                //       filled: true,
                //       prefixIcon: Padding(
                //         padding: EdgeInsets.all(3.5.w),
                //         child: Image.asset(
                //           lock,
                //           width: 2.04.w,
                //           height: 2.04.w,
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //       suffixIcon: phoneController.text.length == 10
                //           ? Container(
                //               width: 10.w,
                //               alignment: Alignment.center,
                //               child: FaIcon(
                //                 FontAwesomeIcons.check,
                //                 color: AppColor().colorPrimary(),
                //                 size: 10.sp,
                //               ))
                //           : SizedBox(),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: AppColor().colorEdit(), width: 5.0),
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       ),
                //     ),
                //   ),
                // ),

                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    maxLength: 12,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.phone,
                    controller: aadharController,
                    validator: FormValidation.aadharNumber,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Aadhar Card No.',
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
                          pass,
                          width: 2.04.w,
                          height: 2.04.w,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  width: 69.99.w,
                  child: TextFormField(
                    readOnly: true,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.visiblePassword,
                    controller: addController,
                    validator: FormValidation.checkEmptyValidator,
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
                      labelText: 'Permanent Address',
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
                          location,
                          width: 2.04.w,
                          height: 2.04.w,
                          fit: BoxFit.contain,
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                /*Container(
                  width: 69.99.w,
                  child: TextFormField(
                    controller: addController,
                    keyboardType: TextInputType.streetAddress,
                    validator: FormValidation.checkEmptyValidator,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "User Address",
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),*/
                Container(
                  width: 69.99.w,
                  child: InkWell(
                    onTap: () {
                      getLocation();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.my_location_outlined,
                            color: Color(0xff666666)),
                        Text(
                          "Use My Current Location",
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  signUpNow();
                } else {
                  UtilityHlepar.getToast(ToastString.msgAllFieldsRequired);
                }
              },
              child: ScaleAnimatedWidget.tween(
                enabled: enabled,
                duration: Duration(milliseconds: 200),
                scaleDisabled: 1.0,
                scaleEnabled: 0.9,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 69.99.w,
                  height: 6.46.h,
                  decoration: boxDecoration(
                      radius: 15.0, bgColor: AppColor().colorPrimaryDark()),
                  child: Center(
                    child: text(
                      "Sign Up",
                      textColor: Color(0xffffffff),
                      fontSize: 14.sp,
                      fontFamily: fontRegular,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  storeRegistration(BuildContext context) {
    return Form(
      key: _storeFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 6.32.h,
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
                      keyboardType: TextInputType.name,
                      controller: signUpNameController,
                      validator: FormValidation.checkEmptyValidator,
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
                        labelText: 'User Name',
                        labelStyle: TextStyle(
                          color: AppColor().colorTextFour(),
                          fontSize: 10.sp,
                        ),
                        helperText: '',
                        counterText: '',
                        fillColor: AppColor().colorEdit(),
                        enabled: true,
                        filled: true,
                        prefixIcon: Container(
                          padding: EdgeInsets.all(3.5.w),
                          child: Image.asset(
                            person,
                            width: 1.04.w,
                            height: 1.04.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: signPhoneController.text.length == 10
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
                  Container(
                    width: 69.99.w,
                    // height: 9.46.h,
                    child: TextFormField(
                      cursorColor: Colors.red,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidation.emailVeledetion,
                      controller: signUpEmailController,
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
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: signPhoneController.text.length == 10
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
                  Container(
                    width: 69.99.w,
                    // height: 9.46.h,
                    child: TextFormField(
                      maxLength: 10,
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.phone,
                      validator: FormValidation.validateMobile,
                      controller: signPhoneController,
                      style: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor().colorEdit(),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Mobile Number',
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
                            phone,
                            width: 2.04.w,
                            height: 2.04.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: signPhoneController.text.length == 10
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
                  Container(
                    width: 69.99.w,
                    // height: 9.46.h,
                    child: TextFormField(
                      cursorColor: Colors.red,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: signPassController,
                      validator: FormValidation.checkEmptyValidator,
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
                        labelText: 'Password',
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
                            lock,
                            width: 2.04.w,
                            height: 2.04.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        suffixIcon: signPhoneController.text.length == 10
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
                  Container(
                    width: 69.99.w,
                    // height: 9.46.h,
                    child: TextFormField(
                      maxLength: 12,
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.text,
                      controller: signDescriptionController,
                      style: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor().colorEdit(),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Description',
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
                            pass,
                            width: 2.04.w,
                            height: 2.04.w,
                            fit: BoxFit.contain,
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
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  productListWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    width: 69.99.w,
                    // height: 9.46.h,
                    child: TextFormField(
                      maxLength: 12,
                      cursorColor: Colors.red,
                      keyboardType: TextInputType.text,
                      controller: signAddController,
                      style: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor().colorEdit(),
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        labelText: 'Address',
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
                            pass,
                            width: 2.04.w,
                            height: 2.04.w,
                            fit: BoxFit.contain,
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
                                ),
                              )
                            : SizedBox(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor().colorEdit(), width: 5.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: InkWell(
              onTap: () async {
                if (_storeFormKey.currentState!.validate()) {
                  storeSignUp();
                } else {
                  UtilityHlepar.getToast(ToastString.msgAllFieldsRequired);
                }
              },
              child: ScaleAnimatedWidget.tween(
                enabled: enabled,
                duration: Duration(milliseconds: 200),
                scaleDisabled: 1.0,
                scaleEnabled: 0.9,
                child: Container(
                  width: 69.99.w,
                  height: 6.46.h,
                  decoration: boxDecoration(
                      radius: 15.0, bgColor: AppColor().colorPrimaryDark()),
                  child: Center(
                    child: text(
                      "Sign Up",
                      textColor: Color(0xffffffff),
                      fontSize: 14.sp,
                      fontFamily: fontRegular,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  roleWidget() {
    return Container(
      width: 69.99.w,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColor().colorEdit(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PopupMenuButton<int>(
            child: Icon(Icons.keyboard_arrow_down_sharp),
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                child: Text("Service Provider"),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: Text("Store"),
              ),
              PopupMenuItem(
                value: 3,
                // row has two child icon and text
                child: Text("Both"),
              ),
            ],
            color: Colors.grey.shade200,
            elevation: 2,
            onSelected: getRole,
          ),
        ],
      ),
    );
  }

  storeSignUp() async {
    Map<String, dynamic> storeMap = Map();
    storeMap["name"] = signUpNameController.text;
    storeMap["description"] = signDescriptionController.text;
    storeMap["address"] = signAddController.text;
    storeMap["phone"] = signPhoneController.text;

    storeMap["res_email"] = signUpEmailController.text;
    storeMap["password"] = signPassController.text;

    String catId = "";

    productList.forEach((element) {
      if (boolStoreMapList[element["id"]]) {
        catId = catId + element["id"] + ",";
      }
    });

    storeMap["cat_id"] = catId;

    Response response = await post(
        Uri.parse("http://fixerking.com/Admin/api/add_restaurant"),
        body: storeMap);
    debugPrint(storeMap.toString());
    var data = jsonDecode(response.body);
    print("http://fixerking.com/Admin/api/add_restaurant =>" + data.toString());

    if (data["status"] == ToastString.success) {
      setTokenData(data["user_id"].toString(), context);
    }
    buttonLogin = false;
    setState(() {});
  }

  getRole(int value) {
    roleValue = value;
    switch (value) {
      case 1:
        roleString = "Service Provider";
        break;
      case 2:
        roleString = "Store";
        break;
      case 3:
        roleString = "Both";
    }
    setState(() {});
  }

  /* int dayIndex = 0;
  int timeIndex = 0;
  Widget secondSign(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 2.62.h,
        ),
        text(
          "Service Offered",
          textColor: Color(0xffFD531F),
          fontSize: 14.sp,
          fontFamily: fontBold,
        ),
        SizedBox(
          height: 2.96.h,
        ),

        Container(
          width: 69.99.w,
          height: 6.h,
          decoration: boxDecoration(
            radius: 10.0,
            bgColor: AppColor().colorEdit(),
          ),
          child: InkWell(
            onTap: () async {
              print("data");
              serviceTypeId = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ServiceTypeList()));
              print(serviceTypeId);
              if (serviceTypeId.isNotEmpty) {
                setState(() {
                  serviceType = serviceTypeId[0].toString();
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.5.w),
                      child: Image.asset(
                        service,
                        width: 6.04.w,
                        height: 5.04.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 40.00.w,
                      child: Text(
                        serviceType,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: AppColor().colorTextFour(),
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    // text(
                    //   serviceType,
                    //   textColor: AppColor().colorTextFour(),
                    //   fontSize: 10.sp,
                    // ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(3.5.w),
                  child: Image.asset(
                    down,
                    width: 6.04.w,
                    height: 6.04.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(
          height: 2.5.h,
        ),
        Container(
          width: 69.99.w,
          height: 6.h,
          decoration: boxDecoration(
            radius: 10.0,
            bgColor: AppColor().colorEdit(),
          ),
          child: InkWell(
            onTap: () async {
              if (serviceTypeId.isNotEmpty) {
                specilizationTypeId = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpecializationList(
                            serviceId: serviceTypeId[1].toString())));
                print("===============");
                print("SPECIALIZATION ID" + specilizationTypeId.toString());
                if (specilizationTypeId.isNotEmpty) {
                  setState(() {
                    specialization = specilizationTypeId[0].toString();
                  });
                }
              } else {
                UtilityHlepar.getToast(ToastString.msgSelectServiceType);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.5.w),
                      child: Image.asset(
                        special,
                        width: 6.04.w,
                        height: 5.04.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 40.00.w,
                      child: Text(
                        specialization,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: AppColor().colorTextFour(),
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(3.5.w),
                  child: Image.asset(
                    down,
                    width: 6.04.w,
                    height: 6.04.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.62.h,
        ),
        Container(
          width: 69.99.w,
          // height: 9.46.h,
          child: TextFormField(
            readOnly: true,
            onTap: () => selectTime(context, from: 0),
            cursorColor: Colors.red,
            // obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: onpenTime,
            validator: FormValidation.checkEmptyValidator,
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
              labelText: 'Open time ',
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
                child: Icon(Icons.watch, size: 15.sp),
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
                borderSide:
                    BorderSide(color: AppColor().colorEdit(), width: 5.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),

        Container(
          width: 69.99.w,
          // height: 9.46.h,
          child: TextFormField(
            readOnly: true,
            onTap: () => selectTime(context, from: 1),
            cursorColor: Colors.red,
            // obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: closeTime,
            validator: FormValidation.checkEmptyValidator,
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
              labelText: 'Close time ',
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
                child: Icon(Icons.watch, size: 15.sp),
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
                borderSide:
                    BorderSide(color: AppColor().colorEdit(), width: 5.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        // text(
        //   "Business Days & Time",
        //   textColor: Color(0xffFD531F),
        //   fontSize: 14.sp,
        //   fontFamily: fontBold,
        // ),
        // SizedBox(
        //   height: 2.96.h,
        // ),
        // Container(
        //   height: 5.07.h,
        //   margin: EdgeInsets.only(left: 8.w),
        //   child: ListView.builder(
        //       itemCount: day.length,
        //       shrinkWrap: true,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         return InkWell(
        //           onTap: () async {
        //             setState(() {
        //               enabled = true;
        //               selected = true;
        //               dayIndex = index;
        //             });
        //             await Future.delayed(Duration(milliseconds: 200));
        //             setState(() {
        //               enabled = false;
        //             });
        //             //  Navigator.push(context, PageTransition(child: SignUpScreen(), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500),));
        //           },
        //           child: ScaleAnimatedWidget.tween(
        //             enabled: enabled,
        //             duration: Duration(milliseconds: 200),
        //             scaleDisabled: 1.0,
        //             scaleEnabled: 0.9,
        //             child: Container(
        //               width: 14.86.w,
        //               height: 6.46.h,
        //               margin: EdgeInsets.only(right: 3.w),
        //               decoration: boxDecoration(
        //                   radius: 15.0,
        //                   bgColor: dayIndex == index
        //                       ? AppColor().colorPrimaryDark()
        //                       : AppColor().colorEdit()),
        //               child: Center(
        //                 child: text(
        //                   day[index],
        //                   textColor: dayIndex == index
        //                       ? Color(0xffffffff)
        //                       : AppColor().colorTextFour(),
        //                   fontSize: 9.sp,
        //                   fontFamily: fontRegular,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       }),
        // ),
        // SizedBox(
        //   height: 4.53.h,
        // ),
        // Container(
        //   width: 69.99.w,
        //   height: 27.53.h,
        //   child: GridView.count(
        //       crossAxisCount: 2,
        //       physics: NeverScrollableScrollPhysics(),
        //       childAspectRatio: 2.8,
        //       mainAxisSpacing: 14.0,
        //       crossAxisSpacing: 2.0,
        //       children: time.map((e) {
        //         int index = time.indexWhere((element) => element == e);
        //         return InkWell(
        //           onTap: () async {
        //             setState(() {
        //               enabled = true;
        //               selected = true;
        //               timeIndex = index;
        //             });
        //             await Future.delayed(Duration(milliseconds: 200));
        //             setState(() {
        //               enabled = false;
        //             });
        //             //  Navigator.push(context, PageTransition(child: SignUpScreen(), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500),));
        //           },
        //           child: ScaleAnimatedWidget.tween(
        //             enabled: enabled,
        //             duration: Duration(milliseconds: 200),
        //             scaleDisabled: 1.0,
        //             scaleEnabled: 0.9,
        //             child: Container(
        //               width: 34.86.w,
        //               height: 6.46.h,
        //               margin: EdgeInsets.only(right: 2.w),
        //               decoration: boxDecoration(
        //                   radius: 15.0,
        //                   bgColor: timeIndex == index
        //                       ? AppColor().colorPrimaryDark()
        //                       : AppColor().colorEdit()),
        //               child: Center(
        //                 child: text(
        //                   e,
        //                   textColor: timeIndex == index
        //                       ? Color(0xffffffff)
        //                       : AppColor().colorTextFour(),
        //                   fontSize: 9.sp,
        //                   fontFamily: fontRegular,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       }).toList()),
        // ),
        SizedBox(
          height: 2.5.h,
        ),
        Center(
          child: InkWell(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                if (serviceTypeId.isNotEmpty &&
                    specilizationTypeId.isNotEmpty) {
                  setState(() {
                    buttonLogin = true;
                  });
                  signUpNow();
                } else if (serviceTypeId.isEmpty) {
                  UtilityHlepar.getToast(ToastString.msgSelectServiceType);
                } else if (specilizationTypeId.isEmpty) {
                  UtilityHlepar.getToast(ToastString.msgSpecializationType);
                }
              }
              // setState(() {
              //   enabled = true;
              //   selected = true;
              // });
              // await Future.delayed(Duration(milliseconds: 200));
              // setState(() {
              //   enabled = false;
              // });
              //  Navigator.push(context, PageTransition(child: SignUpScreen(), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500),));
            },
            child: UtilityWidget.lodingButton(
                buttonLogin: buttonLogin, btntext: 'Sign Up'),
            // child: ScaleAnimatedWidget.tween(
            //   enabled: enabled,
            //   duration: Duration(milliseconds: 200),
            //   scaleDisabled: 1.0,
            //   scaleEnabled: 0.9,
            //   child: Container(
            //     width: 69.99.w,
            //     height: 6.46.h,
            //     decoration: boxDecoration(
            //         radius: 15.0, bgColor: AppColor().colorPrimaryDark()),
            //     child: Center(
            //       child: text(
            //         "Sign Up",
            //         textColor: Color(0xffffffff),
            //         fontSize: 14.sp,
            //         fontFamily: fontRegular,
            //       ),
            //     ),
            //   ),
            // ),
          ),
        ),
        // InkWell(
        //     onTap: () {
        //       _selectTime(context);
        //     },
        //     child: Container(
        //       height: 30,
        //       width: 30,
        //       color: Colors.orange,
        //       child: text("text"),
        //     ))
      ],
    );
  }

  var selectedTime = TimeOfDay.now();
  Future selectTime(BuildContext context, {from}) async {
    final TimeOfDay? result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 12-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 24-Hour format, just change alwaysUse24HourFormat to true
              child: child!);
        });
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
        print(_selectedTime.toString());
      });
    }
    print("===========");
    print(_selectedTime.toString());
    print(result!.hour);
    print(result.minute);
    print(result.period);
    print(UtilityHlepar.convertTime(time: result));
    setState(() {
      if (from == 0) {
        onpenTime.text = UtilityHlepar.convertTime(time: result);
      } else {
        closeTime.text = UtilityHlepar.convertTime(time: result);
      }
    });
  }*/

  Future getCountries() async {
    var request =
        http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_countries'));
    http.StreamedResponse response = await request.send();
    print(request);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = CountryModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          countryList = jsonResponse.data!;
        });
      }
      return CountryModel.fromJson(json.decode(str));
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getState() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
    request.fields.addAll({'country_id': '$selectedCountry'});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = StateModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          stateList = jsonResponse.data!;
        });
      }
      return StateModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future getCities() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '$selectedState'});
    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      /*var fullResponse = json.decode(str);
      serviceList = fullResponse["data"];
      print(serviceList.length);
      setState(() {});
      boolList = serviceList.map((element) {
        return false;
      }).toList();
      serviceList.forEach((element) {
        boolServiceMapList[element["id"]] = false;
      });
      print(boolServiceMapList.length);
      print(boolList.length);*/
      final jsonResponse = CityModel.fromJson(json.decode(str));

      if (jsonResponse.responseCode == "1") {
        setState(() {
          cityList = jsonResponse.data!;
        });
      }
      return CityModel.fromJson(json.decode(str));
    } else {
      print(response.reasonPhrase);
    }
  }

  serviceListWidget() {
    return Container(
      width: 69.99.w,
      child: FutureBuilder(
          future: getServiceCategory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            ServiceCategoryModel serviceModel = snapshot.data;
            if (snapshot.hasData) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Image.asset(
                        service,
                        width: 6.04.w,
                        height: 5.04.w,
                        fit: BoxFit.fill,
                        color: AppColor.PrimaryDark,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Service Category",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: serviceList.map((item) {
                    return DropdownMenuItem<String>(
                        value: item["id"],
                        child: StatefulBuilder(builder: (context, State) {
                          return CheckboxListTile(
                            activeColor: AppColor.PrimaryDark,
                            title: Text(item["c_name"]),
                            onChanged: (val) {
                              print("change");
                              boolServiceMapList[item["id"]] = val as bool;
                              State(() {});
                            },
                            value: boolServiceMapList[item["id"]],
                          );
                        }));
                  }).toList(),
                  onChanged: (value) {
                    // print("CATEGORY ID== $selectedCategory");
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColor.PrimaryDark,
                  ),
                  iconSize: 14,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor().colorEdit(),
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 300,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                ),
              );
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
    // return Container(
    //   width: 69.99.w,
    //   padding: EdgeInsets.all(16),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(15),
    //       color: AppColor().colorEdit()),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text("Product List"),
    //       PopupMenuButton<int>(
    //         child: Icon(Icons.keyboard_arrow_down_sharp),
    //         itemBuilder: (context) {
    //           return [
    //             // popupmenu item 1
    //             PopupMenuItem(
    //                 enabled: false,
    //                 value: 1,
    //                 // row has two child icon and text.
    //                 child: Container(
    //                   height: 200,
    //                   width: 160,
    //                   color: AppColor().colorEdit(),
    //                   // padding: EdgeInsets.all(16),
    //                   child: ListView.builder(
    //                       key: UniqueKey(),
    //                       itemCount: serviceList.length,
    //                       itemBuilder: (context, index) {
    //                         return StatefulBuilder(
    //                             builder: (context, SetState) {
    //                           return CheckboxListTile(
    //                               title: SizedBox(
    //                                   width: 120,
    //                                   child:
    //                                       Text(serviceList[index]["c_name"])),
    //                               key: UniqueKey(),
    //                               value: boolList[index],
    //                               onChanged: (val) {
    //                                 boolList[index] = val;
    //                                 SetState(() {});
    //                               });
    //                         });
    //                       }),
    //                 )),
    //           ];
    //         },
    //         color: AppColor().colorEdit(),
    //         elevation: 2,
    //       ),
    //
    //       // http://fixerking.com/Admin/api/get_service_category
    //     ],
    //   ),
    // );
  }

  productListWidget() {
    return Container(
      width: 69.99.w,
      child: FutureBuilder(
          future: getServiceCategory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            ServiceCategoryModel serviceModel = snapshot.data;
            if (snapshot.hasData) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Image.asset(
                        service,
                        width: 6.04.w,
                        height: 5.04.w,
                        fit: BoxFit.fill,
                        color: AppColor.PrimaryDark,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Service Category",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: productList.map((item) {
                    return DropdownMenuItem<String>(
                        value: item["id"],
                        child: StatefulBuilder(builder: (context, State) {
                          return CheckboxListTile(
                            activeColor: AppColor.PrimaryDark,
                            title: Text(item["c_name"]),
                            onChanged: (val) {
                              print("change");
                              boolStoreMapList[item["id"]] = val as bool;
                              State(() {});
                            },
                            value: boolStoreMapList[item["id"]],
                          );
                        }));
                  }).toList(),
                  onChanged: (value) {
                    // print("CATEGORY ID== $selectedCategory");
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColor.PrimaryDark,
                  ),
                  iconSize: 14,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor().colorEdit(),
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 300,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                ),
              );
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  late SignUpResponse signUpResponse;

  void signUpNow() async {
    String name = nameController.text;
    String email = emailController.text;
    String mobile = phoneController.text;
    String password = passController.text;
    String aadharNo = aadharController.text;
    String address = addController.text;
    String role = roleValue.toString();
    String newLat = lat.toString();
    String newLang = long.toString();
    String deviceToken = TokenString.deviceToken;
    int boolIndex = 0;
    String catId = "";

    serviceList.forEach((element) {
      if (boolServiceMapList[element["id"]]) {
        catId = catId + element["id"] + ",";
      }
    });
    catId = catId.substring(0, catId.length - 1);
    debugPrint("catId=" + catId);
    SignUpRequest request = SignUpRequest(
        name: name,
        email: email,
        mobile: mobile,
        password: password,
        aadharNo: aadharNo,
        address: address,
        latitude: newLat,
        longitude: newLang,
        deviceToken: deviceToken,
        role: role,
        categoryId: catId);
    print("SIGNUP PARAM====" + request.tojson().toString());
    signUpResponse = await AuthApiHelper.signUpNow(request);
    if (signUpResponse.status == ToastString.success) {
      setTokenData(signUpResponse.user, context);
    }
    buttonLogin = false;
    setState(() {});
  }

  setTokenData(userid, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TokenString.userid, userid);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomBar(
                  index: 0,
                )),
        (route) => false);
  }
}

showSnackBar(BuildContext context, String text) {
  var snackBar = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class MultiSelect extends StatefulWidget {
  String selectedState;
  MultiSelect({Key? key, required this.selectedState}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<CityData> _selectedItems = [];
  // this variable holds the selected items

  List<CityData> cityList = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    List selectedItem = _selectedItems.map((item) => item.id).toList();
    // var map = {
    //   "itemIds" : selectedItem,
    //   "selectedItems" : _selectedItems
    // };
    // print("checking selected value ${_selectedItems} && ${selectedItem} && ${map}");
    Navigator.pop(context);
  }

  Future getCities() async {
    print("this is selceted state @@ ${widget.selectedState}");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '${widget.selectedState}'});
    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      /*var fullResponse = json.decode(str);
      serviceList = fullResponse["data"];
      print(serviceList.length);
      setState(() {});
      boolList = serviceList.map((element) {
        return false;
      }).toList();
      serviceList.forEach((element) {
        boolServiceMapList[element["id"]] = false;
      });
      print(boolServiceMapList.length);
      print(boolList.length);*/
      final jsonResponse = CityModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          cityList = jsonResponse.data!;
        });
      }
      return CityModel.fromJson(json.decode(str));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCities();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Multiple Cities'),
      content: SingleChildScrollView(
        child: ListBody(
          children: cityList
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item.name!),
                    controlAffinity: ListTileControlAffinity.leading,
                    // onChanged: (isChecked) => _itemChange(item, isChecked!),
                    onChanged: (isChecked) {
                      setState(() {
                        if (isChecked!) {
                          setState(() {
                            _selectedItems.add(item);
                          });
                          print("length of item list ${_selectedItems.length}");
                          for (var i = 0; i < _selectedItems.length; i++) {
                            print(
                                "ok now final  ${_selectedItems[i].id} and  ${_selectedItems[i].name}");
                          }
                        } else {
                          setState(() {
                            _selectedItems.remove(item);
                          });
                          print("ok now data ${_selectedItems}");
                        }
                      });
                    },
                  ))
              .toList(),
        ),
      ),
      // FutureBuilder(
      //   future: getCities(),
      //   builder: (context, snapshot){
      //     if(snapshot.hasData) {
      //      return SingleChildScrollView(
      //         child: ListBody(
      //           children: cityList
      //               .map((item) =>
      //               CheckboxListTile(
      //                 value: _selectedItems.contains(item),
      //                 title: Text(item.name!),
      //                 controlAffinity: ListTileControlAffinity.leading,
      //                 onChanged: (isChecked) => _itemChange(item, isChecked!),
      //               ))
      //               .toList(),
      //         ),
      //       );
      //     }
      //     return Container(
      //       height: 30,
      //         width: 30,
      //         child: CircularProgressIndicator(
      //           color: AppColor().colorPrimary(),
      //         ));
      //   }
      // ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: AppColor().colorPrimary()),
          ),
          onPressed: _cancel,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: AppColor().colorPrimary()),
          child: Text('Submit'),
          onPressed: () {
            Navigator.pop(context, _selectedItems);
          }
          //     (){
          //   for(var i = 0 ; i< _selectedItems.length; i++){
          //     print(_selectedItems[i].id);
          //   }
          // }
          ,
        ),
      ],
    );
  }
}
