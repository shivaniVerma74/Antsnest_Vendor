import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

// import 'package:time_picker_sheet/widget/sheet.dart';
// import 'package:time_picker_sheet/widget/time_picker.dart';
import '../api/api_path.dart';
import '../modal/AddServicesModel.dart';
import '../modal/City_model.dart';
import '../modal/CurrencyModel.dart';
import '../modal/ModelCategoryModel.dart';
import '../modal/ServiceCategoryModel.dart';
import '../modal/ServiceChildCategoryModel.dart';
import '../modal/ServiceSubCategoryModel.dart';
import '../modal/VisitChargeModel.dart';
import '../modal/country_model.dart';
import '../modal/state_model.dart';
import '../token/app_token_data.dart';
import '../utility_widget/utility_widget.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/toast_string.dart';
import '../utils/utility_hlepar.dart';
import '../utils/widget.dart';
import 'bottom_bar.dart';

class EditServices extends StatefulWidget {
  final serviceName,
      serviceTime,
      serviceCharge,
      catId,
      subCatId,
      serviceId,
      serviceImage,
      subName,
      childName,
      experts,
      city,
      country,
      state,
      logo,
      currency,
      addOntype,
      service,
      adddOnservice,
      hour,
      dayHour,
      addOnPrice,
      serviceDescription,
      servicesOffered;

  const EditServices(
      {Key? key,
      this.serviceName,
      this.serviceTime,
      this.logo,
      this.city,
      this.country,
      this.state,
      this.serviceCharge,
      this.currency,
      this.serviceId,
      this.catId,
      this.subCatId,
      this.serviceImage,
      this.subName,
      this.childName,
      this.addOntype,
      this.experts,
      this.adddOnservice,
      this.addOnPrice,
      this.hour,
      this.dayHour,
      this.service,
      this.serviceDescription,
      this.servicesOffered})
      : super(key: key);

  @override
  State<EditServices> createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  // late TextEditingController onpenTime;
  late TextEditingController serviceCharge;
  late TextEditingController serviceName;
  late TextEditingController descriptionController;
  late TextEditingController expertsC;
  List<TextEditingController> addonServicePriceControllerList = [];
  List<TextEditingController> addonHourDayPriceControllerList = [];

  List<String> hourDayList = ["Hour", "Day"];
  List<String> addonServiceList = ["Basic", "Standard", "Premium"];
  String? selectedServiceType;
  List addonList = [];
  List<Map> addonList2 = [];
  String? selectedServiceHour;

  List<String?> selectedServiceTypeList = [];

  List<String?> selectedServiceHourList = [];
  var fileResult;
  String service_name = "";
  String issue = "";
  GlobalKey<FormState> _formKey = GlobalKey();
  String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
  double perMinServiceCharge = 0.0;
  String? visitingCharge;
  bool buttonLogin = false;
  String finalCharges = "0";
  var servicePic;
  var imageList;
  var imagePathList;
  dynamic? selectedCurrency;
  var storeId;
  DateTime dateTimeSelected = DateTime.now();
  dynamic? selectedCountry;
  dynamic? selectedState;
  dynamic? selectedCity;

  final MultiSelectController _controller = MultiSelectController();

  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  List<StateData> stateList = [];
  List<String> categorylist = [];
  Set<String> uniqueValues = Set();
  List<dynamic> subcateid = [];

  void addOnOperation(
      {String? charges,
      String? houranddays,
      String? serviceType,
      String? serviceHour}) {
    print(serviceHour.toString() + "++++++++++");
    selectedServiceTypeList.add(serviceType ?? selectedServiceType);
    selectedServiceHourList.add(serviceHour ?? selectedServiceHour);
    addonServicePriceControllerList
        .add(TextEditingController(text: "${charges ?? ""}"));
    addonHourDayPriceControllerList
        .add(TextEditingController(text: "${houranddays ?? ""}"));
    addonList2.add({"service": '', "price_a": '', "hrly": '', "days_hrs": ''});
  }

  Future getState() async {
    print("ok now working");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
    request.fields.addAll({'country_id': '${selectedCountry.id}'});
    http.StreamedResponse response = await request.send();
    print(request);
    print(request.fields);
    print("status of state ${response.statusCode}");
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = StateModel.fromJson(json.decode(str));
      List stateIdList = [];
      if (jsonResponse.responseCode == "1") {
        setState(() {
          stateList = jsonResponse.data!;
        });
        print("state list here ${stateList.length}");
        for (var i = 0; i < stateList.length; i++) {
          print("checking id list here ${stateList[i].id}");
          stateIdList.add(stateList[i].id);
        }
        print("checking state widget ${widget.state}");
        if (stateIdList.contains(widget.state)) {
          selectedState =
              stateList.firstWhere((item) => item.id == widget.state);

          setState(() {
            // selectedState = widget.state;
          });
          // print("selected state $selectedState");
          getCities();
        }
      }
      return StateModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future getCountries() async {
    print("checking country id ${widget.country}");
    print("checking country id ${widget.city}");
    print("checking country id ${widget.state}");
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
        List countryIdList = [];
        selectedCountry =
            countryList.firstWhere((item) => item.id == widget.country);

        //selectedCountry=countryList.firstWhere((item) => item.id == widget.country);

        for (var i = 0; i < countryList.length; i++) {
          countryIdList.add(countryList[i].id);
        }
        if (countryIdList.contains(widget.country)) {
          setState(() {
            //selectedCountry = widget.country;
          });
          print("selected country $selectedCountry");
          getState();
        }
      }
      return CountryModel.fromJson(json.decode(str));
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getCities() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '${selectedState.id}'});
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
      List cityIdList = [];
      if (jsonResponse.responseCode == "1") {
        setState(() {
          cityList = jsonResponse.data!;
        });
        for (var i = 0; i < cityList.length; i++) {
          cityIdList.add(cityList[i].id);
        }
        if (cityIdList.contains(widget.city)) {
          setState(() {
            //  selectedCity = widget.city;
            selectedCity =
                cityList.firstWhere((item) => item.id == widget.city);
          });
        }
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
    categorylist.clear();
    for (int i = 0; i < widget.addOntype.length; i++) {
      addOnOperation(
          charges: widget.addOntype[i].priceA,
          houranddays: widget.addOntype[i].daysHrs,
          serviceHour: widget.addOntype[i].hrly,
          serviceType: widget.addOntype[i].service);
    }

    // onpenTime = new TextEditingController(text: widget.serviceTime);

    serviceCharge = new TextEditingController(text: widget.serviceCharge);
    serviceName = new TextEditingController(text: widget.serviceName);
    descriptionController =
        new TextEditingController(text: widget.serviceDescription);
    serviceOfferedController =
        new TextEditingController(text: widget.servicesOffered);
    // expertsC = new TextEditingController(text: widget.experts);
    servicePic = widget.serviceImage;
    selectedCategory = widget.catId;
    selectSubCategory = widget.subCatId;
    //selectedCurrency = widget.currency.toString();

    print("${widget.country}" + "_______________________");
    print("${widget.state}" + "_______________________");
    print("${widget.city}" + "_______________________");
    print("${widget.currency}" + "_______________________");
    print("${widget.subCatId}" + "_______________________");
    subcateid = widget.subCatId.split(', ').map((String value) {
      return value.toString();
    }).toList();

    getCountries();
    //  getServicesSubCategory(widget.catId);
    getServicesSubCategory(widget.catId, widget.subName, true);

    Future.delayed(Duration(milliseconds: 200), () {
      return getCurrency();
    });
  }

  CurrencyModel? currencyModel;

  getCurrency() async {
    var headers = {
      'Cookie': 'ci_session=739ff0b92429e4e79523e8467bd7b6590cf83d2b'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_currency'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResult = CurrencyModel.fromJson(json.decode(finalResult));

      setState(() {
        currencyModel = jsonResult;
      });
      print(widget.currency.toString() + "++++++++++++++++++++");
      selectedCurrency = currencyModel?.data?.firstWhere((item) {
        print(item.symbol.toString() + "++++++++++++++++++++");

        if (item.symbol == widget.currency.toString()) {
          return true;
        }
        return false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getUpdate() {
    selectedCountry =
        countryList.firstWhere((item) => item.id == widget.country);
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.addOntype.length}");

    print("checking city here now ${widget.city} and ${widget.state}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor().colorBg1(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.PrimaryDark,
          title: Text("Edit Service"),
        ),
        body: SingleChildScrollView(
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
                //                   Navigator.pop(context);
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
                //             "Edit Service Profile",
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
                SizedBox(
                  height: 2.02.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: secondSign(context),
                ),
                SizedBox(
                  height: 4.02.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget secondSign(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 2.62.h,
          ),
          // text(
          //   "Service Offered",
          //   textColor: AppColor().colorPrimary(),
          //   fontSize: 14.sp,
          //   fontFamily: fontBold,
          // ),
          // SizedBox(
          //   height: 2.96.h,
          // ),

          // SERVICE NAME
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
              width: double.infinity,
              height: 6.h,
              decoration: boxDecoration(
                radius: 14.0,
                bgColor: AppColor().colorEdit(),
              ),
              child: TextFormField(
                controller: serviceName,
                maxLines: 1,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Service Name",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                  prefixIcon: Icon(
                    Icons.miscellaneous_services,
                    color: AppColor.PrimaryDark,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Container(
              width: double.infinity,
              height: 6.h,
              decoration: boxDecoration(
                radius: 10.0,
                color: AppColor().colorEdit(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<dynamic>(
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
                      .map((item) => DropdownMenuItem<dynamic>(
                            value: item,
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
                  value: selectedCountry,
                  //== null ? widget.country : selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                      print("selectedCategory=>" + selectedCountry.toString());
                      getState();
                    });
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
                  buttonElevation: 0,
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
              )),
          SizedBox(
            height: 2.5.h,
          ),
          Container(
            width: double.infinity,
            height: 6.h,
            decoration: boxDecoration(
              radius: 10.0,
              color: AppColor().colorEdit(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<dynamic>(
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
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: stateList
                    .map(
                      (item) => DropdownMenuItem<dynamic>(
                        value: item,
                        child: Text(
                          item.name!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                value: selectedState,
                // == null ? widget.state : selectedState,
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                    print("selected State===>" + selectedState.toString());
                  });
                  getCities();
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
                buttonElevation: 0,
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
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Container(
            width: double.infinity,
            height: 6.h,
            decoration: boxDecoration(
              radius: 10.0,
              color: AppColor().colorEdit(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<dynamic>(
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
                    .map((item) => DropdownMenuItem<dynamic>(
                          value: item,
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
                value: selectedCity,
                //== null ? widget.city : selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                    print("selected State===>" + selectedCity.toString());
                  });
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
                buttonElevation: 0,
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
            ),
          ),

          SizedBox(
            height: 2.5.h,
          ),
          // currencyModel == null
          //     ? SizedBox()
          //     : Container(
          //         width: double.infinity,
          //         height: 6.h,
          //         decoration: boxDecoration(
          //           radius: 10.0,
          //           color: AppColor().colorEdit(),
          //         ),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton2<dynamic>(
          //             isExpanded: true,
          //             hint: Row(
          //               children: [
          //                 Image.asset(
          //                   country,
          //                   width: 6.04.w,
          //                   height: 5.04.w,
          //                   fit: BoxFit.fill,
          //                   color: AppColor.PrimaryDark,
          //                 ),
          //                 SizedBox(
          //                   width: 4,
          //                 ),
          //                 Expanded(
          //                   child: Text(
          //                     'Select Currency',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.normal,
          //                     ),
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             items: currencyModel!.data!
          //                 .map((item) => DropdownMenuItem<dynamic>(
          //                       value: item,
          //                       child: Text(
          //                         item.symbol.toString(),
          //                         style: const TextStyle(
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.black,
          //                         ),
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ))
          //                 .toList(),
          //             value: selectedCurrency,
          //             // ==
          //             //  null ? widget.currency : selectedCurrency,
          //             onChanged: (value) {
          //               setState(() {
          //                 selectedCurrency = value;
          //                 print("selectedCategory=>" +
          //                     selectedCurrency.toString());
          //                 getState();
          //               });
          //             },
          //             icon: const Icon(
          //               Icons.arrow_forward_ios_outlined,
          //               color: AppColor.PrimaryDark,
          //             ),
          //             iconSize: 14,
          //             buttonHeight: 50,
          //             buttonWidth: 160,
          //             buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          //             buttonDecoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(14),
          //               color: AppColor().colorEdit(),
          //             ),
          //             buttonElevation: 0,
          //             itemHeight: 40,
          //             itemPadding: const EdgeInsets.only(left: 14, right: 14),
          //             dropdownMaxHeight: 300,
          //             dropdownPadding: null,
          //             dropdownDecoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(14),
          //             ),
          //             dropdownElevation: 8,
          //             scrollbarRadius: const Radius.circular(40),
          //             scrollbarThickness: 6,
          //             scrollbarAlwaysShow: true,
          //           ),
          //         )),

          SizedBox(
            height: 1.h,
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
              width: double.infinity,
              decoration: boxDecoration(
                radius: 14.0,
                bgColor: AppColor().colorEdit(),
              ),
              child: TextFormField(
                controller: serviceOfferedController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Service Offered give in ( , )",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                  // prefixIcon: Icon(
                  //   Icons.miscellaneous_services,
                  //   color: AppColor.PrimaryDark,
                  // ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          // SERVICE CATEGORY
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      ServiceCategoryModel serviceModel = snapshot.data;
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
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(
                                        item.cName!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedCategory,
                            onChanged: (value) {
                              var serviceName = "";

                              setState(() {
                                var serviceName = "";
                                selectedCategory = value as String;
                              });
                              categorylist.clear();
                              print(selectedCategory);
                              serviceName = serviceModel.data!
                                  .firstWhere((element) => element.id == value)
                                  .cName
                                  .toString();
                              print(serviceName.toString());
                              serviceSubCategoryModel = null;
                              getServicesSubCategory(
                                  selectedCategory, serviceName, false);
                              setState(() {});
                              print("CATEGORY ID issssss== $selectedCategory");
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColor.PrimaryDark,
                            ),
                            iconSize: 14,
                            buttonHeight: 50,
                            buttonWidth: 160,
                            buttonPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                // color: AppColor().colorEdit(),
                                color: Colors.grey.withOpacity(0.05)),
                            buttonElevation: 0,
                            itemHeight: 40,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
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
                        print("ERROR===" + snapshot.error.toString());
                        return Icon(Icons.error_outline);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
          ),
          SizedBox(
            height: 10,
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

                    controller: _controller,
                    borderColor: Colors.transparent,

                    onOptionSelected: (options) {
                      categorylist.clear();
                      for (int i = 0; i < options.length; i++) {
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
                    options: listValues,
                    //  <ValueItem>[
                    //   for (int i = 0;
                    //       i < serviceSubCategoryModel!.data!.length;
                    //       i++) ...[
                    //     ValueItem(
                    //       label: "${serviceSubCategoryModel!.data![i].cName}",
                    //       value: "${serviceSubCategoryModel!.data![i].id}",
                    //     )
                    //   ]
                    // ],

                    selectionType: SelectionType.multi,
                    //  selectedOptions: [
                    //   for (int i = 0; i < serviceSubCategoryModel!.data!.length; i++) ...[
                    //     "${serviceSubCategoryModel!.data![i].id}" == widget.profileResponse?.user?.jsonData?.subCat.toString()
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
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(
                      Icons.check_circle,
                      color: AppColor.PrimaryDark,
                    ),
                    selectedOptionTextColor: AppColor.PrimaryDark,
                  ),
                ),
          // Container(
          //   width: double.infinity,
          //   height: 6.h,
          //   decoration: boxDecoration(
          //     radius: 10.0,
          //   ),
          //   child: FutureBuilder(
          //     future: getServiceCategory(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       ServiceCategoryModel serviceModel = snapshot.data;
          //       if (snapshot.hasData) {
          //         return DropdownButtonHideUnderline(
          //           child: DropdownButton2(
          //             isExpanded: true,
          //             hint: Row(
          //               children: [
          //                 Image.asset(
          //                   service,
          //                   width: 6.04.w,
          //                   height: 5.04.w,
          //                   fit: BoxFit.fill,
          //                   color: AppColor.PrimaryDark,
          //                 ),
          //                 SizedBox(
          //                   width: 4,
          //                 ),
          //                 Expanded(
          //                   child: Text(
          //                     'Select Category',
          //                     style: TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.normal,
          //                     ),
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             items: serviceModel.data
          //                 ?.map(
          //                   (item) => DropdownMenuItem<String>(
          //                     value: item.id,
          //                     child: Text(
          //                       item.cName!,
          //                       style: const TextStyle(
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.bold,
          //                         color: Colors.black,
          //                       ),
          //                       overflow: TextOverflow.ellipsis,
          //                     ),
          //                   ),
          //                 )
          //                 .toList(),
          //             value: selectedCategory,
          //             // icon:  Icon(
          //             //   Icons.arrow_forward_ios_outlined,
          //             //   color: AppColor.PrimaryDark,
          //             // ),
          //             // onChanged: (value) {
          //             //   setState(() {
          //             //     selectedCategory = value as String;
          //             //     // // serviceName.text = serviceModel.data!
          //             //     //     .firstWhere((element) => element.id == value)
          //             //     //     .cName
          //             //     //     .toString();
          //             //     print("selectedCategory=>" + selectedCategory.toString() + "serviceName" + serviceName.text);
          //             //   });
          //             //   categorylist.clear();
          //             //   getServicesSubCategory(selectedCategory);
          //             //   print("CATEGORY ID== $selectedCategory");
          //             // },

          //             iconSize: 0,
          //             buttonHeight: 50,
          //             buttonWidth: 160,
          //             buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          //             buttonDecoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(14),
          //               color: AppColor().colorEdit(),
          //             ),
          //             buttonElevation: 0,
          //             itemHeight: 40,
          //             itemPadding: const EdgeInsets.only(left: 14, right: 14),
          //             dropdownMaxHeight: 300,
          //             dropdownPadding: null,
          //             dropdownDecoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(14),
          //             ),
          //             dropdownElevation: 8,
          //             scrollbarRadius: const Radius.circular(40),
          //             scrollbarThickness: 6,
          //             scrollbarAlwaysShow: true,
          //           ),
          //         );
          //       } else if (snapshot.hasError) {
          //         print("ERROR===" + snapshot.error.toString());
          //         return Icon(Icons.error_outline);
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),

          SizedBox(
            height: 2.8.h,
          ),

          // SizedBox(
          //   height: 20,
          // ),
          // subCategory?.data == null
          //     ? SizedBox.shrink()
          //     : MultiSelectDropDown(
          //         hint: "Select Sub Category",
          //         // alwaysShowOptionIcon: true,

          //         clearIcon: const Icon(Icons.cancel),
          //         controller: _controller,
          //         onOptionSelected: (options) {
          //           for (int i = 0; i < options.length; i++) {
          //             String value = options[i].value ?? "";

          //             // Check if the value is not already in the set
          //             if (uniqueValues.add(value)) {
          //               // If the value is added to the set (i.e., it's unique), add it to the list
          //               categorylist.add(value);
          //             }
          //           }

          //           // setState(() {
          //           //
          //           // });
          //           debugPrint(categorylist.toString());
          //         },
          //         options: <ValueItem>[
          //           for (int i = 0; i < subCategory!.data!.length; i++) ...[
          //             ValueItem(
          //               label: "${subCategory!.data![i].cName}",
          //               value: "${subCategory!.data![i].id}",
          //             )
          //           ]
          //         ],

          //         selectionType: SelectionType.multi,
          //         selectedOptions: [
          //           for (int i = 0; i < subCategory!.data!.length; i++) ...[
          //             for (int j = 0; j < subcateid.length; j++) ...[
          //               "${subCategory!.data![i].id}" == subcateid[j].toString()
          //                   ? ValueItem(
          //                       label: "${subCategory!.data![i].cName}",
          //                       value: "${subCategory!.data![i].id}",
          //                     )
          //                   : ValueItem(label: "", value: "")
          //             ]
          //           ]
          //         ]..removeWhere(
          //             (element) => element.label == ""), // Remove null entries
          //         chipConfig: const ChipConfig(
          //           wrapType: WrapType.scroll,
          //           backgroundColor: AppColor.PrimaryDark,
          //         ),
          //         dropdownHeight: 300,
          //         optionTextStyle: const TextStyle(fontSize: 16),
          //         selectedOptionIcon: const Icon(
          //           Icons.check_circle,
          //           color: AppColor.PrimaryDark,
          //         ),
          //         selectedOptionTextColor: AppColor.PrimaryDark,
          //         // suffixIcon: IconData(),
          //         // selectedItemBuilder: (BuildContext context, ValueItem item,) {
          //         //   // Customize the appearance of the selected item here
          //         //   return Container(
          //         //     padding: EdgeInsets.all(8.0),
          //         //     decoration: BoxDecoration(
          //         //       color: Colors.red, // Set the background color to red
          //         //       borderRadius: BorderRadius.circular(5.0),
          //         //     ),
          //         //     child: Row(
          //         //       mainAxisSize: MainAxisSize.min,
          //         //       children: [
          //         //         Text(item.label),
          //         //         const SizedBox(width: 8.0),
          //         //         Icon(Icons.close, color: Colors.white, size: 18.0),
          //         //       ],
          //         //     ),
          //         //   );
          //         // },
          //       ),

          // SERVICE SUBCATEGORY
          // Container(
          //     width: double.infinity,
          //     height: 6.h,
          //     decoration: boxDecoration(
          //       radius: 10.0,
          //       // bgColor: AppColor().colorEdit(),
          //     ),
          //     child: FutureBuilder(
          //         future: getServicesSubCategory(selectedCategory),
          //         builder: (BuildContext context, AsyncSnapshot snapshot) {
          //           ServiceSubCategoryModel subCatModel = snapshot.data;
          //           print("SUB CAT DATA=== $subCatModel");
          //           if (snapshot.hasData) {
          //             return DropdownButtonHideUnderline(
          //               child: DropdownButton2(
          //                 isExpanded: true,
          //                 hint: Row(
          //                   children: [
          //                     Image.asset(
          //                       special,
          //                       width: 6.04.w,
          //                       height: 5.04.w,
          //                       fit: BoxFit.fill,
          //                       color: AppColor.PrimaryDark,
          //                     ),
          //                     SizedBox(
          //                       width: 5,
          //                     ),
          //                     Expanded(
          //                       child: Text(
          //                         'Select Sub Category',
          //                         style: TextStyle(
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.normal,
          //                         ),
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 items: subCatModel.data!
          //                     .map((item) => DropdownMenuItem<String>(
          //                   value: item.id,
          //                   child: Text(
          //                     item.cName!,
          //                     style: const TextStyle(
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black,
          //                     ),
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                 ),
          //                 ).toList(),
          //                 value: selectSubCategory,
          //                 onChanged: (value) {
          //                   setState(() {
          //                     selectSubCategory = value as String;
          //                   });
          //                   print("SUB CATEGORY ID== $selectSubCategory");
          //                 },
          //                 icon: const Icon(
          //                   Icons.arrow_forward_ios_outlined,
          //                   color: Color(0xffEEF1F9)
          //                 ),
          //                 iconSize: 14,
          //                 buttonHeight: 50,
          //                 buttonWidth: 160,
          //                 buttonPadding:
          //                 const EdgeInsets.only(left: 14, right: 14),
          //                 buttonDecoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(14),
          //                   color: AppColor().colorEdit(),
          //                 ),
          //                 buttonElevation: 0,
          //                 itemHeight: 40,
          //                 itemPadding:
          //                 const EdgeInsets.only(left: 14, right: 14),
          //                 dropdownMaxHeight: 300,
          //                 dropdownPadding: null,
          //                 dropdownDecoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(14),
          //                 ),
          //                 dropdownElevation: 8,
          //                 scrollbarRadius: const Radius.circular(40),
          //                 scrollbarThickness: 6,
          //                 scrollbarAlwaysShow: true,
          //               ),
          //             );
          //           } else if (snapshot.hasError) {
          //             return Icon(Icons.error_outline);
          //           } else {
          //             return Center(child: CircularProgressIndicator());
          //           }
          //         })),

          //service Description
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
                width: double.infinity,
                height: 20.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Description",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.description,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),

          /* //SERVICE EXPERTS
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            color: AppColor().colorEdit(),
            child: Container(
                width: double.infinity,
                height: 6.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: expertsC,
                  inputFormatters: [LengthLimitingTextInputFormatter(5)],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Experts",
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.credit_card_outlined,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),*/

          //SERVICE PRICE
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            color: AppColor().colorEdit(),
            child: Container(
                width: double.infinity,
                height: 6.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: serviceCharge,
                  inputFormatters: [LengthLimitingTextInputFormatter(5)],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Charges",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.credit_card_outlined,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),

          /* // Service TIME
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
                width: double.infinity,
                height: 6.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  controller: onpenTime,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Service Time (in Hrs.)",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    prefixIcon: Icon(
                      Icons.watch,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                  onTap: () async {
                    _openTimePickerSheet(context);
                  },
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),
*/
          // SERVICE IMAGE
          GestureDetector(
            onTap: () {
              // getImagePicker();
              getFromGallery();
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0)),
              color: AppColor().colorEdit(),
              child: Container(
                width: double.infinity,
                height: 10.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: servicePic != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.image,
                              color: AppColor.PrimaryDark,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.logo.length,
                                    itemBuilder: (c, i) {
                                      return Text(
                                        "${widget.logo[i]}",
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    }))
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.image,
                              color: AppColor.PrimaryDark,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text("Upload service image"),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          widget.logo == null || widget.logo == ""
              ? SizedBox.shrink()
              : Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.logo.length,
                      itemBuilder: (c, i) {
                        return Container(
                          height: 90,
                          width: 100,
                          margin: EdgeInsets.only(left: 25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              "${widget.logo[i]}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                ),

          //  Container(
          //   padding: EdgeInsets.symmetric(horizontal: 30),
          //   child: Column(
          //     children: [
          //       Container(
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Name",
          //                 style: TextStyle(
          //                   color: AppColor.PrimaryDark,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //               Text(
          //                 "Price",
          //                 style: TextStyle(
          //                   color: AppColor.PrimaryDark,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //               Text(
          //                 "Hour/Day",
          //                 style: TextStyle(
          //                   color: AppColor.PrimaryDark,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //               Text(
          //                 "Value",
          //                 style: TextStyle(
          //                   color: AppColor.PrimaryDark,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           )),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       /*addonList.length == 0
          //                 ? SizedBox()
          //                 : ListView.builder(
          //                     // padding: EdgeInsets.symmetric(horizontal: 30),
          //                     shrinkWrap: true,
          //                     itemCount: addonList.length,
          //                     itemBuilder: (c, i) {
          //                       print("addon list here ${addonList}");
          //                       List<dynamic> decodedData =
          //                           json.decode(json.encode(addonList)) as List;
          //                       var fianlData = decodedData[i];
          //                       return Container(
          //                         margin: EdgeInsets.only(top: 5),
          //                         child: Row(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.spaceBetween,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             Expanded(
          //                                 child:
          //                                     Text("${fianlData["service"]}")),
          //                             // Expanded(child: Text("\u{20B9} ${addonList[i]['price_a']}")),
          //                             // Expanded(child: Text("${addonList[i]['hrly']}")),
          //                             // Text("${addonList[i]['days_hrs']}"),
          //                             // InkWell(
          //                             //     onTap: (){
          //                             //       setState(() {
          //                             //         addonList.removeAt(addonList[i]['serviceName']);
          //                             //         addonList.removeAt(addonList[i]['addonPrice']);
          //                             //       });
          //                             //     },
          //                             //     child: Icon(Icons.clear)),
          //                           ],
          //                         ),
          //                       );
          //                     })*/
          //     ],
          //   ),
          // ),
          ///

          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add on service",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addOnOperation();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          primary: AppColor.PrimaryDark,
                          padding: EdgeInsets.all(0),
                          maximumSize: Size(30, 30),
                          minimumSize: Size(30, 30)),
                      child: Align(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: addonList2.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0)),
                          color: AppColor().colorEdit(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: double.infinity,
                                            height: 6.h,
                                            decoration: boxDecoration(
                                                radius: 10.0,
                                                color: AppColor().colorEdit()),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                isExpanded: true,
                                                hint: Text(
                                                  'Select Hours / Day',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                items: addonServiceList
                                                    .map(
                                                      (String? item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item.toString(),
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
                                                      ),
                                                    )
                                                    .toList(),
                                                value: selectedServiceTypeList[
                                                    index],
                                                onChanged: (value) {
                                                  print(
                                                      "select serviceee typeee hereree ${selectedServiceTypeList[index]}");
                                                  setState(() {
                                                    selectedServiceTypeList[
                                                            index] =
                                                        value as String;
                                                    // // serviceName.text = serviceModel.data!
                                                    //     .firstWhere((element) => element.id == value)
                                                    //     .cName
                                                    //     .toString();
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color:
                                                        AppColor.PrimaryDark),
                                                iconSize: 14,
                                                buttonHeight: 50,
                                                buttonWidth: 160,
                                                buttonPadding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                                buttonDecoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: AppColor().colorBg1(),
                                                  //color: Colors.grey.withOpacity(0.05)
                                                ),
                                                buttonElevation: 0,
                                                itemHeight: 40,
                                                itemPadding:
                                                    const EdgeInsets.only(
                                                        left: 14, right: 14),
                                                dropdownMaxHeight: 300,
                                                dropdownPadding: null,
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                dropdownElevation: 8,
                                                scrollbarRadius:
                                                    const Radius.circular(40),
                                                scrollbarThickness: 6,
                                                scrollbarAlwaysShow: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            height: 6.h,
                                            child: TextField(
                                              controller:
                                                  addonServicePriceControllerList[
                                                      index],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: "I will charge",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: double.infinity,
                                            height: 6.h,
                                            decoration: boxDecoration(
                                              radius: 10.0,
                                              color: AppColor().colorEdit(),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                isExpanded: true,
                                                hint: Text(
                                                  'Select Hours / Day',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                items: ['Hours', 'Days']
                                                    .map(
                                                      (String? item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item,
                                                        child: Text(
                                                          item.toString(),
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
                                                      ),
                                                    )
                                                    .toList(),
                                                value: selectedServiceHourList[
                                                    index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    //selectedServiceHour = value as String;
                                                    selectedServiceHourList[
                                                            index] =
                                                        value as String;
                                                    // // serviceName.text = serviceModel.data!
                                                    //     .firstWhere((element) => element.id == value)
                                                    //     .cName
                                                    //     .toString();
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
                                                  color: AppColor().colorBg1(),
                                                  //color: Colors.grey.withOpacity(0.05)
                                                ),
                                                buttonElevation: 0,
                                                itemHeight: 40,
                                                itemPadding:
                                                    const EdgeInsets.only(
                                                        left: 14, right: 14),
                                                dropdownMaxHeight: 300,
                                                dropdownPadding: null,
                                                dropdownDecoration:
                                                    BoxDecoration(
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
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            height: 6.h,
                                            child: TextField(
                                              controller:
                                                  addonHourDayPriceControllerList[
                                                      index],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText: "Hour/Day",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          child: InkWell(
                              onTap: () {
                                selectedServiceTypeList.removeAt(index);
                                selectedServiceHourList.removeAt(index);
                                addonServicePriceControllerList.removeAt(index);
                                addonHourDayPriceControllerList.removeAt(index);
                                addonList2.removeAt(index);
                                setState(() {});
                              },
                              child: Icon(Icons.remove_circle_outline)),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                var userId = await MyToken.getUserID();
                if (_formKey.currentState!.validate()) {
                  if (descriptionController.text.toString().length < 100) {
                    return UtilityHlepar.getToast(
                        "Descriptionn must be of 100 characters");
                  } else if (selectedCategory!.isNotEmpty &&
                      subcateid!.isNotEmpty &&
                      serviceCharge.text.isNotEmpty) {
                    setState(() {
                      buttonLogin = true;
                    });

                    for (int i = 0;
                        i < addonServicePriceControllerList.length;
                        i++) {
                      if (addonServicePriceControllerList[i].text.isNotEmpty &&
                          addonHourDayPriceControllerList[i].text.isNotEmpty &&
                          selectedServiceTypeList[i] != null &&
                          selectedServiceHourList[i] != null) {
                        addonList.add(jsonEncode({
                          "service": selectedServiceTypeList[i],
                          "price_a": addonServicePriceControllerList[i].text,
                          "hrly": selectedServiceHourList[i],
                          "days_hrs": addonHourDayPriceControllerList[i].text
                        }));
                      }
                    }

                    Map<String, String> param = {
                      'name': '${serviceName.text.toString()}',
                      'description': '${descriptionController.text}',
                      'cat_id': '$selectedCategory',
                      'scat_id': categorylist.isEmpty
                          ? subcateid.map((dynamic value) {
                              return value.toString();
                            }).join(', ')
                          : categorylist.map((String value) {
                              return value.toString();
                            }).join(', '),
                      'vid': '$userId',
                      'price': '${serviceCharge.text.toString()}',
                      // 'hours': '${onpenTime.text.toString()}',
                      // 'experts': '${expertsC.text}',
                      'id': widget.serviceId,
                      'country_id': "${selectedCountry.id.toString()}",
                      "state_id": "${selectedState.id.toString()}",
                      "city_id": "${selectedCity.id.toString()}",
                      "currency": selectedCurrency == null
                          ? "₹"
                          : "${selectedCurrency.symbol}",
                      "addon": addonList.toString(),
                    };
                    print("ADD SERVICE PARAM=====" + param.toString());
                    AddServicesModel addModel = await editServices(param);
                    if (addModel.responseCode == "1") {
                      Navigator.pop(context, true);
                      UtilityHlepar.getToast("Service Edit Successfully");
                    } else {
                      UtilityHlepar.getToast(addModel.message);
                    }
                  } else if (selectedCategory!.isEmpty) {
                    UtilityHlepar.getToast(ToastString.msgSelectServiceType);
                  } else if (subcateid!.isEmpty) {
                    UtilityHlepar.getToast(ToastString.msgSelectServiceSubType);
                  }
                  // else if (onpenTime.text.isEmpty) {
                  //   UtilityHlepar.getToast(ToastString.msgServiceTime);
                  // }
                  else if (serviceCharge.text.isEmpty) {
                    UtilityHlepar.getToast(ToastString.msgServiceCharge);
                  } else if (servicePic == null) {
                    UtilityHlepar.getToast("Service Image Required");
                  }
                }
              },
              child: UtilityWidget.lodingButton(
                  buttonLogin: buttonLogin, btntext: 'Submit'),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
        ],
      ),
    );
  }

  TextEditingController serviceOfferedController = TextEditingController();

  ServiceCategoryModel? serviceCategoryModel11;
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
      serviceCategoryModel11 = ServiceCategoryModel.fromJson(json.decode(str));

      return ServiceCategoryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  ServiceSubCategoryModel? serviceSubCategoryModel;
  List<ValueItem> listValues = [];
  Future<ServiceSubCategoryModel?> getServicesSubCategory(
      catId, String serviceName, bool forFirstTym) async {
    listValues.clear();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));

      request.fields.addAll({'p_id': '$catId'});

      print(request);
      print(request.fields);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final str = await response.stream.bytesToString();
        log(str);
        var finalResult = ServiceSubCategoryModel.fromJson(json.decode(str));
        setState(() {
          serviceSubCategoryModel = finalResult;
        });
        listValues.clear();
        for (int i = 0; i < serviceSubCategoryModel!.data!.length; i++) {
          listValues.add(ValueItem(
            label: "${serviceSubCategoryModel!.data![i].cName}",
            value: "${serviceSubCategoryModel!.data![i].id}",
          ));
        }

        _controller.setOptions(listValues);
        // for (int i = 0; i < listValues.length; i++) {
        //   print(listValues[i].toString() + "LIST VALUUES");
        // }

        if (forFirstTym) {
          _controller.addSelectedOption(
              ValueItem(label: widget.subName, value: widget.subCatId));
        }

        ///  addData(serviceName, serviceSubCategoryModel!.data!);
        //customMap.addEntries(serviceName, serviceSubCategoryModel.data!);
      } else {
        return null;
      }
    } catch (stacktrace, error) {
      log(stacktrace.toString());
      log(error.toString());
    }
  }

  // ServiceSubCategoryModel? subCategory;

  // Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));

  //   request.fields.addAll({'p_id': '$catId'});

  //   print(request);
  //   print(request.fields);
  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     final str = await response.stream.bytesToString();
  //     print(str);
  //     subCategory = ServiceSubCategoryModel.fromJson(json.decode(str));
  //     setState(() {});
  //     return ServiceSubCategoryModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> getFromGallery() async {
    fileResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (fileResult != null) {
      setState(() {
        // servicePic = File(result.files.single.path!);
        servicePic = fileResult.paths.toList();
      });
      print("SERVICE PIC === $servicePic");
    } else {
      // User canceled the picker
    }
  }

  // Future<void> getFromGallery() async {
  //   var result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //   );
  //   if (result != null) {
  //     setState(() {
  //       // servicePic = File(result.files.single.path.toString());
  //     });
  //     imagePathList = result.paths.toList();
  //     // imagePathList.add(result.paths.toString()).toList();
  //     print("SERVICE PIC === ${imagePathList.length}");
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  Future editServices(param) async {
    print("servicePic list here ${servicePic}");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}edit_restaurant'));
    for (var i = 0; i < servicePic.length; i++) {
      fileResult == null
          ? ""
          : request.files.add(await http.MultipartFile.fromPath(
              'res_image[]', servicePic[i].toString()));
    }
    // if(widget.serviceImage == null){
    //   request.files.add(await http.MultipartFile.fromPath(
    //       'logo', servicePic!.path));
    // } else {
    //   request.files.add(http.MultipartFile.fromString(
    //       'logo', widget.serviceImage));
    // }

    request.fields.addAll(param);

    http.StreamedResponse response = await request.send();
    print(request.toString());
    print(request.fields.toString());
    print(response.statusCode.toString() + "___________________");
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str.toString());
      return AddServicesModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: 'Select Service Time',
        minuteTitle: 'Minute',
        hourTitle: 'Hour',
        saveButtonText: 'Save',
      ),
    );

    if (result != null) {
      print("--22222------$result");
      setState(() {
        dateTimeSelected = result;
        // onpenTime.text = "0${dateTimeSelected.hour}:${dateTimeSelected.minute == 0 ? "0${dateTimeSelected.minute}" : dateTimeSelected.minute} ";
      });
    }
  }

  bool isChange = false;
}
