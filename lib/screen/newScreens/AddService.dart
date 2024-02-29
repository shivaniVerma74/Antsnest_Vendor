// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:fixerking/modal/ModelCategoryModel.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/modal/AddServicesModel.dart';
// import 'package:fixerking/modal/ServiceCategoryModel.dart';
// import 'package:fixerking/modal/ServiceChildCategoryModel.dart';
// import 'package:fixerking/modal/VisitChargeModel.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sizer/sizer.dart';
// import 'package:time_picker_sheet/widget/sheet.dart';
// import 'package:time_picker_sheet/widget/time_picker.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import '../../modal/ServiceSubCategoryModel.dart';
// import '../../modal/country_model.dart';
// import '../../modal/state_model.dart';
// import '../../token/app_token_data.dart';
// import '../../utility_widget/utility_widget.dart';
// import '../../utils/colors.dart';
// import '../../utils/constant.dart';
// import '../../utils/images.dart';
// import '../../utils/toast_string.dart';
// import '../../utils/utility_hlepar.dart';
// import '../../utils/widget.dart';
// import '../auth_view/signup_screen.dart';
// import '../bottom_bar.dart';
// import 'package:http/http.dart' as http;
//
// class AddServices extends StatefulWidget {
//   const AddServices({Key? key}) : super(key: key);
//
//   @override
//   State<AddServices> createState() => _AddServicesState();
// }
//
// class _AddServicesState extends State<AddServices> {
//   TextEditingController onpenTime = new TextEditingController();
//   TextEditingController imageC = new TextEditingController();
//   TextEditingController closeTime = new TextEditingController();
//   TextEditingController serviceCharge = new TextEditingController();
//   TextEditingController expertsC = new TextEditingController();
//   TextEditingController serviceName = new TextEditingController();
//   TextEditingController serviceIssue = new TextEditingController();
//   TextEditingController descriptionController = new TextEditingController();
//   TextEditingController servicePrice = new TextEditingController();
//
//   TextEditingController serviceLocation = TextEditingController();
//   TextEditingController serviceOfferedController  = TextEditingController();
//   // TextEditingController descriptionController = TextEditingController();
//   final ImagePicker imagePicker = ImagePicker();
//
//
//   GlobalKey<FormState> _formKey = GlobalKey();
//
//   bool buttonLogin = false;
//   String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
//   double perMinServiceCharge = 0.0;
//   String? visitingCharge;
//   String? issue;
//   List serviceTypeId = [];
//   List specilizationTypeId = [];
//   String finalCharges = "0";
//   File? servicePic;
//   var storeId;
//   var imagePathList;
//   DateTime dateTimeSelected = DateTime.now();
//   String showImage = '';
//   String service_price = "";
//   String service_name = "";
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;
//   List<CountryData> countryList = [];
//   List<StateData> stateList = [];
//   List _selectedItems = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCountries();
//   }
//    File? _finalPhoto;
//
//   List pickedImageList = [];
//   // imageFromCamera()async{
//   // List<XFile>? imagesList = await ImagePicker.platform.getMultiImage();
//   //   setState(() {
//   //     pickedImageList.add(imagesList);
//   //   });
//   //   print("checking images here ${pickedImageList.length}");
//   //   for(var i=0;i< pickedImageList.length;i++){
//   //     print(" new image here ${pickedImageList[i]}");
//   //   }
//   //   Navigator.of(context).pop();
//   // }
//
//   Future getState() async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
//     request.fields.addAll({'country_id': '$selectedCountry'});
//     http.StreamedResponse response = await request.send();
//     print(request);
//     print(request.fields);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = StateModel.fromJson(json.decode(str));
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           stateList = jsonResponse.data!;
//         });
//       }
//       return StateModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   void _showMultiSelect() async {
//     // // a list of selectable items
//     // // these items can be hard-coded or dynamically fetched from a database/API
//     // final List _items = [
//     //   {
//     //     "id":"1",
//     //     "name":"Flutter"
//     //   },
//     //   {
//     //     "id":"2",
//     //     "name":"Node.js"
//     //   },
//     //   {
//     //     "id":"3",
//     //     "name":"React Native"
//     //   },
//     // ];
//
//     final List? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelect( selectedState: selectedState.toString(),);
//       },
//     );
//
//     // Update UI
//     if (results != null) {
//       setState(() {
//         _selectedItems = results;
//       });
//       print("this is result == ${_selectedItems.toString()}");
//     }
//   }
//
//   Future getCountries() async {
//     var request =
//     http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_countries'));
//     http.StreamedResponse response = await request.send();
//     print(request);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = CountryModel.fromJson(json.decode(str));
//
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           countryList = jsonResponse.data!;
//         });
//       }
//       return CountryModel.fromJson(json.decode(str));
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 1000),
//             curve: Curves.easeInOut,
//             width: 100.w,
//             decoration: BoxDecoration(
//               gradient: RadialGradient(
//                 center: Alignment(0.0, -0.5),
//                 colors: [
//                   AppColor().colorBg1(),
//                   AppColor().colorBg1(),
//                 ],
//                 radius: 0.8,
//               ),
//             ),
//             padding: MediaQuery.of(context).viewInsets,
//             child: Column(
//               children: [
//                 Container(
//                   height: 9.92.h,
//                   width: 100.w,
//                   decoration: BoxDecoration(
//                     color: AppColor.PrimaryDark
//                   ),
//                   child: Center(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 6.38.w,
//                             height: 6.38.w,
//                             alignment: Alignment.centerLeft,
//                             margin: EdgeInsets.only(left: 7.91.w),
//                             child: InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Image.asset(
//                                   back,
//                                   height: 4.0.h,
//                                   width: 8.w,
//                                 ))),
//                         SizedBox(
//                           width: 2.08.h,
//                         ),
//                         Container(
//                           width: 65.w,
//                           child: text(
//                             "Add Services",
//                             textColor: Color(0xffffffff),
//                             fontSize: 14.sp,
//                             fontFamily: fontMedium,
//                             isCentered: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 secondSign(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget secondSign(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 2.62.h,
//           ),
//           text(
//             "Service Offered",
//             textColor: AppColor().colorPrimary(),
//             fontSize: 14.sp,
//             fontFamily: fontBold,
//           ),
//           SizedBox(
//             height: 2.96.h,
//           ),
//
//           // SERVICE NAME
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceName,
//                   maxLines: 1,
//                   keyboardType: TextInputType.text,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Name",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.miscellaneous_services,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 1.5.h,
//           ),
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceLocation,
//                   // maxLines: 2,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Location",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.location_on_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           // SERVICE CATEGORY
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Container(
//               width: double.infinity,
//               height: 6.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 color:  AppColor().colorEdit(),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: [
//                       Image.asset(
//                         country,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select Country',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: countryList
//                       .map((item) => DropdownMenuItem<String>(
//                     value: item.id,
//                     child: Text(
//                       item.name!,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ))
//                       .toList(),
//                   value: selectedCountry,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCountry = value as String;
//                       print("selectedCategory=>" +
//                           selectedCountry.toString());
//                       getState();
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: AppColor.PrimaryDark,
//                   ),
//                   iconSize: 14,
//                   buttonHeight: 50,
//                   buttonWidth: 160,
//                   buttonPadding:
//                   const EdgeInsets.only(left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     color: AppColor().colorEdit(),
//                   ),
//                   buttonElevation: 0,
//                   itemHeight: 40,
//                   itemPadding:
//                   const EdgeInsets.only(left: 14, right: 14),
//                   dropdownMaxHeight: 300,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius: const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                 ),
//               )),
//           SizedBox(
//             height: 15,
//           ),
//           //STATE
//           Container(
//               width: double.infinity,
//               height: 6.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 color:AppColor().colorEdit(),
//               ),
//               child:DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: [
//                       Image.asset(
//                         city,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select State',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: stateList
//                       .map((item) =>
//                       DropdownMenuItem<String>(
//                         value: item.id,
//                         child: Text(
//                           item.name!,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight:
//                             FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                           overflow:
//                           TextOverflow.ellipsis,
//                         ),
//                       ))
//                       .toList(),
//                   value: selectedState,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedState = value as String;
//                       print("selected State===>" +
//                           selectedState.toString());
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: AppColor.PrimaryDark,
//                   ),
//                   iconSize: 14,
//                   buttonHeight: 50,
//                   buttonWidth: 160,
//                   buttonPadding: const EdgeInsets.only(
//                       left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(14),
//                     color:AppColor().colorEdit(),
//                   ),
//                   buttonElevation: 0,
//                   itemHeight: 40,
//                   itemPadding: const EdgeInsets.only(
//                       left: 14, right: 14),
//                   dropdownMaxHeight: 300,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(14),
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius:
//                   const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                 ),
//               ),
//               // FutureBuilder(
//               //     future: getState(),
//               //     builder: (BuildContext context,
//               //         AsyncSnapshot snapshot) {
//               //       if (snapshot.hasData) {
//               //         return DropdownButtonHideUnderline(
//               //           child: DropdownButton2(
//               //             isExpanded: true,
//               //             hint: Row(
//               //               children: [
//               //                 Image.asset(
//               //                   city,
//               //                   width: 6.04.w,
//               //                   height: 5.04.w,
//               //                   fit: BoxFit.fill,
//               //                   color: AppColor.PrimaryDark,
//               //                 ),
//               //                 SizedBox(
//               //                   width: 4,
//               //                 ),
//               //                 Expanded(
//               //                   child: Text(
//               //                     'Select State',
//               //                     style: TextStyle(
//               //                       fontSize: 14,
//               //                       fontWeight: FontWeight.normal,
//               //                     ),
//               //                     overflow: TextOverflow.ellipsis,
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //             items: stateList
//               //                 .map((item) =>
//               //                 DropdownMenuItem<String>(
//               //                   value: item.id,
//               //                   child: Text(
//               //                     item.name!,
//               //                     style: const TextStyle(
//               //                       fontSize: 14,
//               //                       fontWeight:
//               //                       FontWeight.bold,
//               //                       color: Colors.black,
//               //                     ),
//               //                     overflow:
//               //                     TextOverflow.ellipsis,
//               //                   ),
//               //                 ))
//               //                 .toList(),
//               //             value: selectedState,
//               //             onChanged: (value) {
//               //               setState(() {
//               //                 selectedState = value as String;
//               //                 print("selected State===>" +
//               //                     selectedState.toString());
//               //               });
//               //             },
//               //             icon: const Icon(
//               //               Icons.arrow_forward_ios_outlined,
//               //               color: AppColor.PrimaryDark,
//               //             ),
//               //             iconSize: 14,
//               //             buttonHeight: 50,
//               //             buttonWidth: 160,
//               //             buttonPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             buttonDecoration: BoxDecoration(
//               //               borderRadius:
//               //               BorderRadius.circular(14),
//               //               color:AppColor().colorEdit(),
//               //             ),
//               //             buttonElevation: 0,
//               //             itemHeight: 40,
//               //             itemPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             dropdownMaxHeight: 300,
//               //             dropdownPadding: null,
//               //             dropdownDecoration: BoxDecoration(
//               //               borderRadius:
//               //               BorderRadius.circular(14),
//               //             ),
//               //             dropdownElevation: 8,
//               //             scrollbarRadius:
//               //             const Radius.circular(40),
//               //             scrollbarThickness: 6,
//               //             scrollbarAlwaysShow: true,
//               //           ),
//               //         );
//               //       } else if (snapshot.hasError) {
//               //         return Icon(Icons.error_outline);
//               //       } else {
//               //         return Center(
//               //             child: CircularProgressIndicator());
//               //       }
//               //     })
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           // CITY
//           // _selectedItems.isEmpty ?
//           InkWell(
//             onTap: (){
//               _showMultiSelect();
//             },
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color:  AppColor().colorEdit(),
//                 ),
//                 // boxDecoration(
//                 //   radius: 10.0,
//                 // ),
//                 child: _selectedItems.isEmpty ?
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         city,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 8),
//                         child: Text(
//                           'Select Multiple Cities',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//                     :  Wrap(
//                   children: _selectedItems
//                       .map((item){
//                     print("okok ${item.id}");
//                     selectedCity = item.id;
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8),
//                       child: Chip(
//                         label:
//                         Text(
//                             "${item.name}"
//                           //item.name
//                         ),
//                       ),
//                     );
//                   })
//                       .toList(),
//                 )
//               // FutureBuilder(
//               //     future: getCities(),
//               //     builder: (BuildContext context,
//               //         AsyncSnapshot snapshot) {
//               //       if (snapshot.hasData) {
//               //         return DropdownButtonHideUnderline(
//               //           child: DropdownButton2(
//               //             isExpanded: true,
//               //             hint: Row(
//               //               children: [
//               //                 Image.asset(
//               //                   city,
//               //                   width: 6.04.w,
//               //                   height: 5.04.w,
//               //                   fit: BoxFit.fill,
//               //                   color: AppColor.PrimaryDark,
//               //                 ),
//               //                 SizedBox(
//               //                   width: 4,
//               //                 ),
//               //                 Expanded(
//               //                   child: Text(
//               //                     'Select Multiple Cities',
//               //                     style: TextStyle(
//               //                       fontSize: 14,
//               //                       fontWeight: FontWeight.normal,
//               //                     ),
//               //                     overflow: TextOverflow.ellipsis,
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //             items: cityList.map((item) {
//               //               return DropdownMenuItem<String>(
//               //                 value: item.id,
//               //                 enabled: false,
//               //                 child: StatefulBuilder(
//               //                   builder: (context, menuSetState) {
//               //                     final _isSelected =
//               //                         selectedCities
//               //                             .contains(item);
//               //                     print("SLECTED CITY");
//               //                     return InkWell(
//               //                       onTap: () {
//               //                         _isSelected
//               //                             ? selectedCities
//               //                                 .remove(item.id)
//               //                             : selectedCities
//               //                                 .add(item.id!);
//               //                         setState(() {});
//               //                         menuSetState(() {});
//               //                       },
//               //                       child: Container(
//               //                         height: double.infinity,
//               //                         padding: const EdgeInsets
//               //                                 .symmetric(
//               //                             horizontal: 16.0),
//               //                         child: Row(
//               //                           children: [
//               //                             _isSelected
//               //                                 ? const Icon(Icons
//               //                                     .check_box_outlined)
//               //                                 : const Icon(Icons
//               //                                     .check_box_outline_blank),
//               //                             const SizedBox(
//               //                                 width: 16),
//               //                             Text(
//               //                               item.name!,
//               //                               style:
//               //                                   const TextStyle(
//               //                                 fontSize: 14,
//               //                               ),
//               //                             ),
//               //                           ],
//               //                         ),
//               //                       ),
//               //                     );
//               //                   },
//               //                 ),
//               //               );
//               //             }).toList(),
//               //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
//               //             value: selectedCities.isEmpty
//               //                 ? null
//               //                 : selectedCities.last,
//               //             onChanged: (value) {},
//               //             buttonHeight: 50,
//               //             buttonWidth: 160,
//               //             buttonPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             buttonDecoration: BoxDecoration(
//               //               borderRadius:
//               //                   BorderRadius.circular(14),
//               //               color: Color(0xffF9F9F9),
//               //             ),
//               //             buttonElevation: 0,
//               //             itemHeight: 40,
//               //             itemPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             dropdownMaxHeight: 300,
//               //             dropdownPadding: null,
//               //             dropdownDecoration: BoxDecoration(
//               //               borderRadius:
//               //                   BorderRadius.circular(14),
//               //             ),
//               //             dropdownElevation: 8,
//               //             scrollbarRadius:
//               //                 const Radius.circular(40),
//               //             scrollbarThickness: 6,
//               //             scrollbarAlwaysShow: true,
//               //             selectedItemBuilder: (context) {
//               //               return cityList.map(
//               //                 (item) {
//               //                   return Container(
//               //                     // alignment: AlignmentDirectional.center,
//               //                     padding:
//               //                         const EdgeInsets.symmetric(
//               //                             horizontal: 16.0),
//               //                     child: Text(
//               //                       selectedCities.join(','),
//               //                       style: const TextStyle(
//               //                         fontSize: 14,
//               //                         overflow:
//               //                             TextOverflow.ellipsis,
//               //                       ),
//               //                       maxLines: 1,
//               //                     ),
//               //                   );
//               //                 },
//               //               ).toList();
//               //             },
//               //           ),
//               //         );
//               //       } else if (snapshot.hasError) {
//               //         return Icon(Icons.error_outline);
//               //       } else {
//               //         return Center(
//               //             child: CircularProgressIndicator());
//               //       }
//               //     })
//             ),
//           ),
//
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Container(
//               width: double.infinity,
//               height: 6.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//               ),
//               child: FutureBuilder(
//                   future: getServiceCategory(),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     ServiceCategoryModel serviceModel = snapshot.data;
//                     if (snapshot.hasData) {
//                       return DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           hint: Row(
//                             children: [
//                               Image.asset(
//                                 service,
//                                 width: 6.04.w,
//                                 height: 5.04.w,
//                                 fit: BoxFit.fill,
//                                 color: AppColor.PrimaryDark,
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//
//                               Expanded(
//                                 child: Text(
//                                   'Select Category',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: serviceModel.data!
//                               .map((item) => DropdownMenuItem<String>(
//                             value: item.id,
//                             child: Text(
//                               item.cName!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                               .toList(),
//                           value: selectedCategory,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCategory = value as String;
//                               // // serviceName.text = serviceModel.data!
//                               //     .firstWhere((element) => element.id == value)
//                               //     .cName
//                               //     .toString();
//                               print("selectedCategory=>" +
//                                   selectedCategory.toString() +
//                                   "serviceName" +
//                                   serviceName.text);
//                             });
//                             print("CATEGORY ID== $selectedCategory");
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             color: AppColor.PrimaryDark,
//                           ),
//                           iconSize: 14,
//                           buttonHeight: 50,
//                           buttonWidth: 160,
//                           buttonPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           buttonDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: AppColor().colorEdit(),
//                           ),
//                           buttonElevation: 0,
//                           itemHeight: 40,
//                           itemPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           dropdownMaxHeight: 300,
//                           dropdownPadding: null,
//                           dropdownDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           dropdownElevation: 8,
//                           scrollbarRadius: const Radius.circular(40),
//                           scrollbarThickness: 6,
//                           scrollbarAlwaysShow: true,
//                         ),
//                       );
//                     }
//                     else if (snapshot.hasError) {
//                       print("ERROR===" + snapshot.error.toString());
//                       return Icon(Icons.error_outline);
//                     }
//                     else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           // SERVICE SUBCATEGORY
//           Container(
//               width: double.infinity,
//               height: 6.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 // bgColor: AppColor().colorEdit(),
//               ),
//               child: FutureBuilder(
//                   future: getServicesSubCategory(selectedCategory),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     ServiceSubCategoryModel subCatModel = snapshot.data;
//                     print("SUB CAT DATA=== $subCatModel");
//                     if (snapshot.hasData) {
//                       return DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           hint: Row(
//                             children: [
//                               Image.asset(
//                                 special,
//                                 width: 6.04.w,
//                                 height: 5.04.w,
//                                 fit: BoxFit.fill,
//                                 color: AppColor.PrimaryDark,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Select Sub Category',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: subCatModel.data!
//                               .map((item) => DropdownMenuItem<String>(
//                             value: item.id,
//                             child: Text(
//                               item.cName!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                               .toList(),
//                           value: selectSubCategory,
//                           onChanged: (value) {
//                             setState(() {
//                               selectSubCategory = value as String;
//                             });
//                             print("SUB CATEGORY ID== $selectSubCategory");
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             color: AppColor.PrimaryDark,
//                           ),
//                           iconSize: 14,
//                           buttonHeight: 50,
//                           buttonWidth: 160,
//                           buttonPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           buttonDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: AppColor().colorEdit(),
//                           ),
//                           buttonElevation: 0,
//                           itemHeight: 40,
//                           itemPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           dropdownMaxHeight: 300,
//                           dropdownPadding: null,
//                           dropdownDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           dropdownElevation: 8,
//                           scrollbarRadius: const Radius.circular(40),
//                           scrollbarThickness: 6,
//                           scrollbarAlwaysShow: true,
//                         ),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Icon(Icons.error_outline);
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })),
//           SizedBox(
//             height: 2.62.h,
//           ),
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 // height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceOfferedController,
//                    maxLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Offered use ( , ) ",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     // prefixIcon: Icon(
//                     //   Icons.miscellaneous_services,
//                     //   color: AppColor.PrimaryDark,
//                     // ),
//                   ),
//                 )),
//           ),
//
//           // Container(
//           //     margin: EdgeInsets.only(left: 30),
//           //     child: Row(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Container(
//           //         decoration:BoxDecoration(
//           //           color: AppColor().colorPrimary(),
//           //           borderRadius: BorderRadius.circular(100)
//           //         ),
//           //         child: Icon(Icons.add,color: Colors.white,size: 15,)),
//           //     SizedBox(width: 8,),
//           //     Text("Add More")
//           //   ],
//           // )),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           //service Description
//           Card(
//             elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: descriptionController,
//                   // maxLines: 2,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Description",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.description,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           /*//SERVICE EXPERTS
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.0),
//             ),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: expertsC,
//                   inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Experts",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.credit_card_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),*/
//           //SERVICE PRICE
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.0),
//             ),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: serviceCharge,
//                   inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Amount",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.credit_card_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//          /* // Service TIME
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: double.infinity,
//                 height: 6.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: onpenTime,
//                   textAlignVertical: TextAlignVertical.center,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     hintText: "Service Time (in Hrs.)",
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
//                     prefixIcon: Icon(
//                       Icons.watch,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                   onTap: () async {
//                     _openTimePickerSheet(context);
//                   },
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),*/
//
//           // SERVICE IMAGE
//           GestureDetector(
//             onTap: () {
//               // getImagePicker();
//               getFromGallery();
//             //  imageFromCamera();
//             },
//             child: Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14.0)),
//               color: AppColor().colorEdit(),
//               child: Container(
//                 width: double.infinity,
//                 height: 10.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child:
//                 // servicePic != null
//                 imagePathList.isNotEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.image,
//                               color: AppColor.PrimaryDark,
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.65,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                   itemCount: imagePathList.length,
//                                   itemBuilder: (context,index){
//                                 return Padding(
//                                   padding: EdgeInsets.only(top: 5,bottom: 5),
//                                   child: Text("${imagePathList[index]}"),
//                                 );
//                               })
//                               // Text(
//                               //   "$servicePic",
//                               //   overflow: TextOverflow.ellipsis,
//                               // ),
//                             )
//                           ],
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.image,
//                               color: AppColor.PrimaryDark,
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                             Text("Upload service image"),
//                           ],
//                         ),
//                       ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           Center(
//             child: InkWell(
//               onTap: () async {
//                 print(" values area here ${selectedCity} and ${selectedState} and ${selectedCountry}");
//                  var userId = await MyToken.getUserID();
//                 if (_formKey.currentState!.validate()) {
//                   if (selectedCategory!.isNotEmpty &&
//                       selectSubCategory!.isNotEmpty &&
//                       serviceCharge.text.isNotEmpty) {
//                     setState(() {
//                       buttonLogin = true;
//                     });
//                     Map<String, String> param = {
//                     'name': '${serviceName.text.toString()}',
//                     'description': '${descriptionController.text}',
//                     'cat_id': '$selectedCategory',
//                     'scat_id': '$selectSubCategory',
//                     'vid': '$userId',
//                     'price': '${serviceCharge.text.toString()}',
//                      'country_id': "${selectedCountry.toString()}",
//                      "state_id" : "${selectedState.toString()}",
//                       "city_id":"${selectedCity.toString()}",
//                       "service_offered":"${serviceOfferedController.text}"
//                     };
//                     print("ADD SERVICE PARAM=====" + param.toString());
//                     AddServicesModel addModel = await addServices(param);
//                     if (addModel.responseCode == "1") {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => BottomBar()));
//                       UtilityHlepar.getToast(addModel.message);
//                     } else {
//                       UtilityHlepar.getToast(addModel.message);
//                     }
//                   }
//                   else if (selectedCategory!.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceType);
//                   }
//                   else if (selectSubCategory!.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceSubType);
//                   }
//                   else if (serviceCharge.text.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgServiceCharge);
//                   }
//                   else if(servicePic == null){
//                     UtilityHlepar.getToast("Service Image Required");
//                   }
//                 }
//               },
//               child: UtilityWidget.lodingButton(
//                   buttonLogin: buttonLogin, btntext: 'Submit'),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//         ],
//       ),
//     );
//   }
//
//   var selectedTime = TimeOfDay.now();
//
//   Future selectTime(BuildContext context, {from}) async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 // Using 12-Hour format
//                   alwaysUse24HourFormat: false),
//               // If you want 24-Hour format, just change alwaysUse24HourFormat to true
//               child: child!);
//         });
//     if (result != null) {
//       setState(() {
//         _selectedTime = result.format(context);
//         print(_selectedTime.toString());
//       });
//     }
//     print("===========");
//     print(_selectedTime.toString());
//     print(result!.hour);
//     print(result.minute);
//     print(result.period);
//     print(UtilityHlepar.convertTime(time: result));
//     setState(() {
//       if (from == 0) {
//         onpenTime.text = UtilityHlepar.convertTime(time: result);
//       } else {
//         closeTime.text = UtilityHlepar.convertTime(time: result);
//       }
//     });
//   }
//
//   String? _selectedTime;
//
//   Future<void> showTimePikar() async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 // Using 12-Hour format
//                   alwaysUse24HourFormat: false),
//               // If you want 24-Hour format, just change alwaysUse24HourFormat to true
//               child: child!);
//         });
//     if (result != null) {
//       setState(() {
//         _selectedTime = result.format(context);
//         print(_selectedTime.toString());
//       });
//     }
//   }
//
//   Future<ServiceCategoryModel?> getServiceCategory() async {
//     // var userId = await MyToken.getUserID();
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//           '${Apipath.BASH_URL}get_categories_list',
//         ));
//     print(request);
//
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       return ServiceCategoryModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));
//
//     request.fields.addAll({'p_id': '$catId'});
//
//     print(request);
//     print(request.fields);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       print(str);
//       return ServiceSubCategoryModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   Future addServices(param) async {
//     print("ADD SERVICE PARAM=====" + param.toString());
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}add_restaurant'));
//     request.fields.addAll(param);
//     request.files.add(
//         await http.MultipartFile.fromPath('res_image', imagePathList.toString()));
//     print(request.files);
//     http.StreamedResponse response = await request.send();
//     print(request.toString());
//     print(request.fields.toString());
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       print(str.toString());
//       return AddServicesModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   getImagePicker() async {
//    /* var imageTemporary;
//     var image = await ImagePickerGC.pickImage(
//         context: context, source: ImgSource.Gallery);
//     if (image == null) return;
//     imageTemporary = File(image.path);
//     setState(() {
//       showImage = image.path;
//     });
//     var base64Image = '';
//     if (imageTemporary.toString().isNotEmpty) {
//       var _image = File(imageTemporary.path);
//       File FileCompressed = await FlutterNativeImage.compressImage(_image.path,
//           quality: 100, percentage: 50);
//       List<int> imagebytes = FileCompressed.readAsBytesSync();
//       base64Image = base64Encode(imagebytes);
//       setState(() {
//         servicePic = _image;
//       });
//       print("SERVICE PIC === ${servicePic.toString()}");
//     }*/
//     try {
//       final image = await ImagePicker().getImage(source: ImageSource.gallery);
//       if(image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => servicePic = imageTemp);
//       print("SERVICE PIC === $servicePic");
//     } on PlatformException catch(e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<void> getFromGallery() async {
//
//     var result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );
//     if (result != null) {
//       setState(() {
//           // servicePic = File(result.files.single.path.toString());
//       });
//       imagePathList.add(result.paths.toString());
//       print("SERVICE PIC === ${imagePathList.length}");
//     } else {
//       // User canceled the picker
//     }
//
//   }
//
//   TextEditingController usernameController = TextEditingController();
//   File? file;
//   String profileUrl = "";
//   String url = "";
//
//   void _openTimePickerSheet(BuildContext context) async {
//     final result = await TimePicker.show<DateTime?>(
//       context: context,
//       sheet: TimePickerSheet(
//         sheetTitle: 'Select Service Time',
//         minuteTitle: 'Minute',
//         hourTitle: 'Hour',
//         saveButtonText: 'Save',
//       ),
//     );
//
//     if (result != null) {
//       setState(() {
//         dateTimeSelected = result;
//         service_price = visitingCharge.toString();
//         onpenTime.text = "0${dateTimeSelected.hour}:${dateTimeSelected'../../../../../../Antsnest_user10Dec/Antsnest/lib/models/state_model.dart'}" : dateTimeSelected.minute} ";
//       });
//       /*if (onpenTime.text.isNotEmpty && serviceCharge.text.isNotEmpty) {
//         // var totalCharges = (int.parse(visitingCharge!) + int.parse(serviceCharge.text.toString()));
//         // print("TOTAL CHARGES=== $totalCharges");
//         // perMinServiceCharge = totalCharges/60;
//         // print("PERMINUTE SERVICE CHARGE=== ${perMinServiceCharge.toStringAsFixed(2)}");
//         var parts = onpenTime.text.toString().split(':');
//         var hrsToMinute = (int.parse(parts[0].padLeft(2, '0')) * 60);
//         print("hrs min======$hrsToMinute");
//         var finalTime = hrsToMinute + int.parse(parts[1].padLeft(2, '0'));
//         print("FINAL TIME===== $finalTime");
//         var amount = (int.parse(visitingCharge!) + (int.parse(serviceCharge.text.toString()) * finalTime));
//         print("AMOUNT==== $amount");
//         setState(() {
//           finalCharges = amount.toString();
//           servicePrice.text = finalCharges;
//         });
//       }*/
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:path/path.dart' as path;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import '../../api/api_helper/ApiList.dart';
import '../../api/api_path.dart';
import '../../modal/AddServicesModel.dart';
import '../../modal/City_model.dart';
import '../../modal/CurrencyModel.dart';
import '../../modal/New models/VerifyUserPlanModel.dart';
import '../../modal/ServiceCategoryModel.dart';
import '../../modal/ServiceSubCategoryModel.dart';
import '../../modal/country_model.dart';
import '../../modal/response/get_profile_response.dart';
import '../../modal/state_model.dart';
import '../../token/app_token_data.dart';
import '../../utility_widget/utility_widget.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/toast_string.dart';
import '../../utils/utility_hlepar.dart';
import '../../utils/widget.dart';
import '../bottom_bar.dart';
import 'package:http/http.dart' as http;

class AddServices extends StatefulWidget {
  const AddServices({Key? key, this.profileResponse}) : super(key: key);

  final GetProfileResponse? profileResponse;

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  TextEditingController onpenTime = new TextEditingController();
  TextEditingController imageC = new TextEditingController();
  TextEditingController closeTime = new TextEditingController();
  TextEditingController serviceCharge = new TextEditingController();
  TextEditingController serviceCategory = new TextEditingController();
  TextEditingController serviceSubCategory = new TextEditingController();
  TextEditingController expertsC = new TextEditingController();
  TextEditingController serviceName = new TextEditingController();
  TextEditingController serviceIssue = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController servicePrice = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController serviceLocation = TextEditingController();
  TextEditingController serviceOfferedController = TextEditingController();
  TextEditingController hourdayController = TextEditingController();
  String? selctedHourDay;

  bool buttonLogin = false;
  String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
  dynamic selectedCategory11;
  //String ?selectedSubCategory11;
  List<String> categorylist = [];
  Set<String> uniqueValues = Set();
  double perMinServiceCharge = 0.0;
  String? visitingCharge;
  String? issue;
  var imagePathList;
  String? selectedMainCurrency;
  List serviceTypeId = [];
  List specilizationTypeId = [];
  List<StateData> stateList = [];
  String finalCharges = "0";
  File? servicePic;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  var storeId;
  DateTime dateTimeSelected = DateTime.now();
  String showImage = '';
  String service_price = "";
  String service_name = "";

  TextEditingController hourController = TextEditingController();
  String? selectedAddonService;
  String? selectedHourDay;

  List<String> addonServiceList = ["Basic", "Standard", "Premium"];

  String? selectedServiceType;

  String? selectedServiceHour;

  List<String?> selectedServiceTypeList = [];

  List<String?> selectedServiceHourList = [];

  List<TextEditingController> addonServicePriceControllerList = [];
  List<TextEditingController> addonHourDayPriceControllerList = [];

  List<String> hourDayList = ["Hour", "Day"];

  Future getState() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
    request.fields.addAll({'country_id': '$selectedCountry'});
    http.StreamedResponse response = await request.send();
    print(request);
    print(request.fields);
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

  Future getCities() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '$selectedState'});
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

  TextEditingController addonServiceController = TextEditingController();
  TextEditingController addonPriceController = TextEditingController();
  final MultiSelectController _controller = MultiSelectController();
  List addonList = [];
  List<Map> addonList2 = [];

  CurrencyModel? currencyModel;
  String? selectedCurrency;

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
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    categorylist.clear();
    getServiceCategories();

    addOnOperation();
    getVerifyUser();
    getCountries();
    Future.delayed(Duration(milliseconds: 200), () {
      return getCurrency();
    });
  }

  String? isPlanAvailable;

  getVerifyUser() async {
    var userId = await MyToken.getUserID();
    var headers = {'Cookie': 'ci_session=srt9h3cbg9qnkvhgnetmb006uqvle65d'};
    var request =
        http.MultipartRequest('POST', Uri.parse(BaseUrl + 'check_user_plan'));
    request.fields.addAll({'user_id': '${userId}'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("result here ${result}");
      final jsonResponse = VerifyUserPlanModel.fromJson(json.decode(result));
      print("final here ${jsonResponse.responseCode}");
      setState(() {
        isPlanAvailable = jsonResponse.responseCode;
      });
      print(
          "checking response here ${jsonResponse.msg} and ${jsonResponse.responseCode}");
    } else {
      print(response.reasonPhrase);
    }
  }

  void addOnOperation() {
    selectedServiceTypeList.add(selectedServiceType);
    selectedServiceHourList.add(selectedServiceHour);
    addonServicePriceControllerList.add(TextEditingController());
    addonHourDayPriceControllerList.add(TextEditingController());
    addonList2.add({"service": '', "price_a": '', "hrly": '', "days_hrs": ''});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 50,
            width: double.maxFinite,
            child: isPlanAvailable == "0" ? SizedBox() : bottomButton()),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        title: Text(
          "Add Services",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Container(
            width: 6.38.w,
            height: 6.38.w,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 7.91.w),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  back,
                  height: 4.0.h,
                  width: 8.w,
                ))),
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
            child: isPlanAvailable == "0"
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height / 1.05,
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
                    child: Center(
                      child: Text(
                        "Do not have any active plan, please activate",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        // Container(
                        //   height: 9.92.h,
                        //   width: 100.w,
                        //   decoration: BoxDecoration(color: AppColor.PrimaryDark),
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
                        //             "Add Services",
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
                        secondSign(context),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget bottomButton() {
    return InkWell(
      onTap: () async {
        var userId = await MyToken.getUserID();
        print(selectedCategory11.id);
        print(serviceName.text.isNotEmpty);
        if (descriptionController.text.trim().toString().length < 100) {
          return UtilityHlepar.getToast(
              "Description must be of at least 100 characters.");
        }

        if (serviceName.text.isNotEmpty &&
            selectedCategory11.id != "null" &&
            selectedCurrency != "" &&
            serviceCharge.text.isNotEmpty) {
          if (selectedCategory11.id.isNotEmpty && categorylist.isNotEmpty ||
              subcateid.isNotEmpty && serviceCharge.text.isNotEmpty) {
            setState(() {
              buttonLogin = true;
            });

            for (int i = 0; i < addonServicePriceControllerList.length; i++) {
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
              'cat_id': selectedCategory11.id ?? '',
              'scat_id': categorylist.isEmpty
                  ? subcateid.map((dynamic value) {
                      return value.toString();
                    }).join(', ')
                  : categorylist.map((String value) {
                      return value.toString();
                    }).join(', '),
              // categorylist.toString().toJ??'',
              'vid': '$userId',
              'price': '${serviceCharge.text.toString()}',
              'country_id': "${selectedCountry.toString()}",
              "state_id": "${selectedState.toString()}",
              "city_id": "${selectedCity.toString()}",
              "service_offered": "${serviceOfferedController.text}",
              "hourdayValue": hourdayController.text,
              "hourdayvalue1": selctedHourDay.toString(),
              "currency": selectedMainCurrency.toString(),
              "addon": addonList.toString(),
            };
            print("ADD SERVICE PARAM=====" + param.toString());
            AddServicesModel addModel = await addServices(param);
            if (addModel.responseCode == "1") {
              Navigator.pop(context);
              UtilityHlepar.getToast('Service added successfully');
            } else {
              UtilityHlepar.getToast(addModel.message);
            }
          } else if (selectedCategory11.id.toString() == "null") {
            UtilityHlepar.getToast(ToastString.msgSelectServiceType);
          } else if (categorylist.isEmpty) {
            UtilityHlepar.getToast(ToastString.msgSelectServiceSubType);
          } else if (serviceCharge.text.isEmpty) {
            UtilityHlepar.getToast(ToastString.msgServiceCharge);
          } else if (servicePic == null) {
            UtilityHlepar.getToast("Service Image Required");
          }
        } else {
          UtilityHlepar.getToast("PLease select fields");
        }
      },
      child: UtilityWidget.lodingButton(
          buttonLogin: buttonLogin, btntext: 'Submit'),
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
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),

          // Card(
          //   elevation: 0,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(14.0)),
          //   color: AppColor().colorEdit(),
          //   child: Container(
          //       width: double.infinity,
          //       height: 6.h,
          //       decoration: boxDecoration(
          //         radius: 14.0,
          //         bgColor: AppColor().colorEdit(),
          //       ),
          //       child: TextFormField(
          //         controller: serviceLocation,
          //         maxLines: 1,
          //         keyboardType: TextInputType.text,
          //         textAlignVertical: TextAlignVertical.center,
          //         decoration: InputDecoration(
          //           hintText: "Service Location",
          //           border: InputBorder.none,
          //           contentPadding:
          //               EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
          //           prefixIcon: Icon(
          //             Icons.miscellaneous_services,
          //             color: AppColor.PrimaryDark,
          //           ),
          //         ),
          //       )),
          // ),
          // SizedBox(
          //   height: 2.5.h,
          // ),
          Container(
              width: double.infinity,
              height: 6.h,
              decoration: boxDecoration(
                radius: 10.0,
                color: AppColor().colorEdit(),
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
                  value: selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value as String;
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
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: stateList
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
                value: selectedState,
                onChanged: (value) {
                  setState(() {
                    selectedState = value as String;
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
                value: selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value as String;
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
          currencyModel == null
              ? SizedBox()
              : Container(
                  width: double.infinity,
                  height: 6.h,
                  decoration: boxDecoration(
                    radius: 10.0,
                    color: AppColor().colorEdit(),
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
                              'Select Currency',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: currencyModel!.data!
                          .map((item) => DropdownMenuItem<String>(
                                value: item.symbol.toString(),
                                child: Text(
                                  item.symbol.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedMainCurrency,
                      onChanged: (value) {
                        setState(() {
                          selectedMainCurrency = value as String;
                          print("selected State===>" +
                              selectedMainCurrency.toString());
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
                  controller: hourdayController,
                  // maxLines: 2,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Enter hours / days",
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
          Container(
            width: double.infinity,
            height: 6.h,
            decoration: boxDecoration(
              radius: 10.0,
              // color: AppColor().colorEdit(),
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
                        'Select Hours / Days',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: ['Hours', 'Days']
                    .map((item) => DropdownMenuItem<String>(
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
                value: selctedHourDay,
                onChanged: (value) {
                  setState(() {
                    selctedHourDay = value as String;
                    print("selected State===>" + selctedHourDay.toString());
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
          serviceModel == null
              ? Center(child: CircularProgressIndicator())
              :
              // Card(
              //   elevation: 0,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(14.0),
              //   ),
              //   color: AppColor().colorEdit(),
              //   child: Container(
              //       width: double.infinity,
              //       height: 6.h,
              //       decoration: boxDecoration(
              //         radius: 14.0,
              //         bgColor: AppColor().colorEdit(),
              //       ),
              //       child: TextFormField(
              //         keyboardType: TextInputType.text,
              //         controller: serviceCategory,
              //         style: const TextStyle(
              //           fontSize: 14,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black,
              //           overflow: TextOverflow.ellipsis,
              //
              //         ),
              //         readOnly: true,
              //         //inputFormatters: [LengthLimitingTextInputFormatter(5)],
              //         textAlignVertical: TextAlignVertical.center,
              //         decoration: InputDecoration(
              //
              //           hintText: "Service Category",
              //           border: InputBorder.none,
              //           contentPadding:
              //           EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
              //           /*prefixIcon: Icon(
              //             Icons.credit_card_outlined,
              //             color: AppColor.PrimaryDark,
              //           ),*/
              //         ),
              //       )),
              // ),

              SizedBox(
                  height: 2.5.h,
                ),
          /*Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 6.h,
              decoration: boxDecoration(
                radius: 10.0,
              ),
              child: DropdownButtonHideUnderline(
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
                  items: serviceModel?.data?.map((item) => DropdownMenuItem<String>(
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
                  )).toList(),
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value as String;
                      selectSubCategory = null;
                      getServicesSubCategory(selectedCategory);
                      // // serviceName.text = serviceModel.data!
                      //     .firstWhere((element) => element.id == value)
                      //     .cName
                      //     .toString();
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xffEEF1F9),
                  ),
                  iconSize: 14,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding:
                  const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor().colorEdit(),
                    //color: Colors.grey.withOpacity(0.05)
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
                  scrollbarRadius: Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                ),
              )
           )*/

          Container(
            width: double.infinity,
            height: 6.h,
            decoration: boxDecoration(
              radius: 10.0,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<dynamic>(
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
                        'Select Category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: serviceModel?.data!
                    .map((item) => DropdownMenuItem<dynamic>(
                          value: item,
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
                value: selectedCategory11,
                // onChanged: (value) {
                //   setState(() {
                //     selectedCategory11 = value;
                //     // // serviceName.text = serviceModel.data!
                //     //     .firstWhere((element) => element.id == value)
                //     //     .cName
                //     //     .toString();
                //     print("selectedCategory=>" +
                //         selectedCategory.toString() +
                //         "serviceName" +
                //         serviceName.text);
                //     getServicesSubCategory(selectedCategory11?.id);
                //   });
                //   print("CATEGORY ID== $selectedCategory");
                // },
                // icon: const Icon(
                //   Icons.arrow_forward_ios_outlined,
                //   color: AppColor.PrimaryDark,
                // ),
                iconSize: 0,
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

          // selectedCategory == "" || selectedCategory == null
          //     ? SizedBox.shrink()
          //     : SizedBox(height: 2.5.h
          // ),
          // SERVICE SUBCATEGORY
          //  subCategory == null
          //     ? SizedBox.shrink()
          //     : Card(
          //   elevation: 0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(14.0),
          //   ),
          //   color: AppColor().colorEdit(),
          //   child: Container(
          //       width: double.infinity,
          //       height: 6.h,
          //       decoration: boxDecoration(
          //         radius: 14.0,
          //         bgColor: AppColor().colorEdit(),
          //       ),
          //       child: TextFormField(
          //         keyboardType: TextInputType.text,
          //         controller: serviceSubCategory,
          //         readOnly: true,
          //         style: const TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //         inputFormatters: [LengthLimitingTextInputFormatter(5)],
          //         textAlignVertical: TextAlignVertical.center,
          //         decoration: InputDecoration(
          //           hintText: "Sub Category",
          //           border: InputBorder.none,
          //           contentPadding:
          //           EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
          //           /*prefixIcon: Icon(
          //             Icons.credit_card_outlined,
          //             color: AppColor.PrimaryDark,
          //           ),*/
          //         ),
          //       ),
          //   ),
          // ),

          subCategory?.data == null
              ? SizedBox.shrink()
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    MultiSelectDropDown(
                      hint: "Select Sub Category",
                      showClearIcon: true,
                      controller: _controller,
                      onOptionSelected: (options) {
                        for (int i = 0; i < options.length; i++) {
                          String value = options[i].value ?? "";

                          // Check if the value is not already in the set
                          if (uniqueValues.add(value)) {
                            print(value);

                            categorylist.add(value);
                            setState(() {});
                          }
                        }
                        debugPrint(categorylist.toString() + "+++++++++++++");

                        // setState(() {
                        //
                        // });
                      },
                      options: <ValueItem>[
                        for (int i = 0; i < subCategory!.data!.length; i++) ...[
                          ValueItem(
                            label: "${subCategory!.data![i].cName}",
                            value: "${subCategory!.data![i].id}",
                          )
                        ]
                      ],

                      selectionType: SelectionType.multi,
                      selectedOptions: [
                        for (int i = 0; i < subCategory!.data!.length; i++) ...[
                          for (int j = 0; j < subcateid.length; j++) ...[
                            "${subCategory!.data![i].id}" ==
                                    subcateid[j].toString()
                                ? ValueItem(
                                    label: "${subCategory!.data![i].cName}",
                                    value: "${subCategory!.data![i].id}",
                                  )
                                : ValueItem(label: "")
                          ]
                        ]
                      ]..removeWhere((element) =>
                          element.label == ""), // Remove null entries
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
                  ],
                ),
          // Container(
          //         width: double.infinity,
          //         height: 6.h,
          //         decoration: boxDecoration(
          //           radius: 10.0,
          //           // bgColor: AppColor().colorEdit(),
          //         ),
          //         child: FutureBuilder(
          //             future: getServicesSubCategory(selectedCategory),
          //             builder: (BuildContext context, AsyncSnapshot snapshot) {
          //               ServiceSubCategoryModel subCatModel = snapshot.data;
          //               print("SUB CAT DATA=== ${subCatModel} and ${subCatModel.data}  and ${snapshot.hasData}");
          //               if (snapshot.hasData) {
          //                 return DropdownButtonHideUnderline(
          //                   child: DropdownButton2(
          //                     isExpanded: true,
          //                     hint: Row(
          //                       children: [
          //                         Image.asset(
          //                           special,
          //                           width: 6.04.w,
          //                           height: 5.04.w,
          //                           fit: BoxFit.fill,
          //                           color: AppColor.PrimaryDark,
          //                         ),
          //                         SizedBox(
          //                           width: 5,
          //                         ),
          //                         Expanded(
          //                           child: Text(
          //                             'Select Sub Category',
          //                             style: TextStyle(
          //                               fontSize: 14,
          //                               fontWeight: FontWeight.normal,
          //                             ),
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     items: subCatModel.data!
          //                         .map((item) => DropdownMenuItem<String>(
          //                               value: item.id,
          //                               child: Text(
          //                                 item.cName!,
          //                                 style: const TextStyle(
          //                                   fontSize: 14,
          //                                   fontWeight: FontWeight.bold,
          //                                   color: Colors.black,
          //                                 ),
          //                                 overflow: TextOverflow.ellipsis,
          //                               ),
          //                             ))
          //                         .toList(),
          //                     value: selectSubCategory,
          //                     onChanged: (value) {
          //                       setState(() {
          //                         selectSubCategory = value as String;
          //                       });
          //                       print("SUB CATEGORY ID== $selectSubCategory");
          //                     },
          //                     icon: const Icon(
          //                       Icons.arrow_forward_ios_outlined,
          //                       color: AppColor.PrimaryDark,
          //                     ),
          //                     iconSize: 14,
          //                     buttonHeight: 50,
          //                     buttonWidth: 160,
          //                     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          //                     buttonDecoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(14),
          //                       color: AppColor().colorEdit(),
          //                     ),
          //                     buttonElevation: 0,
          //                     itemHeight: 40,
          //                     itemPadding:
          //                         const EdgeInsets.only(left: 14, right: 14),
          //                     dropdownMaxHeight: 300,
          //                     dropdownPadding: null,
          //                     dropdownDecoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(14),
          //                     ),
          //                     dropdownElevation: 8,
          //                     scrollbarRadius: const Radius.circular(40),
          //                     scrollbarThickness: 6,
          //                     scrollbarAlwaysShow: true,
          //                   ),
          //                 );
          //               } else if (snapshot.hasError) {
          //                 return Icon(Icons.error_outline);
          //               } else {
          //                 return Center(child: CircularProgressIndicator());
          //               }
          //             })),
          SizedBox(
            height: 2.62.h,
          ),
          //service Description
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
                controller: descriptionController,
                // maxLines: 2,

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
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),

          /*//SERVICE EXPERTS
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
          ),*/

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
                child:
                    // servicePic != null
                    imagePathList != null
                        ? Padding(
                            padding: EdgeInsets.all(10.0),
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
                                // Container(
                                //   width: MediaQuery.of(context).size.width * 0.65,
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //       itemCount: imagePathList.length,
                                //       itemBuilder: (c,i){
                                //     return Container(
                                //       width: MediaQuery.of(context).size.width/2,
                                //       padding:  EdgeInsets.only(top: 5,bottom: 5),
                                //       child: Text("${imagePathList[i]}"),
                                //     );
                                //   })
                                //   // Text(
                                //   //   "$servicePic",
                                //   //   overflow: TextOverflow.ellipsis,
                                //   // ),
                                // SizedBox(
                                //         width: MediaQuery.of(context).size.width * 0.65,
                                //         child: ListView.builder(
                                //           shrinkWrap: true,
                                //             itemCount: imagePathList.length,
                                //             itemBuilder: (context,index){
                                //           return Padding(
                                //             padding: EdgeInsets.only(top: 5,bottom: 5),
                                //             child: Text("${imagePathList[index]}"),
                                //           );
                                //         })
                                //         // Text(
                                //         //   "$servicePic",
                                //         //   overflow: TextOverflow.ellipsis,
                                //         // ),
                                //       ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: imagePathList.length,
                                      itemBuilder: (c, i) {
                                        print(
                                            "checking here ${imagePathList[i]}");
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text("${imagePathList[i]}"),
                                        );
                                      }),
                                ),
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

          SizedBox(
            height: 2.5.h,
          ),

          // addonList.length == 0
          //     ? SizedBox.shrink()
          //     : Container(
          //         padding: EdgeInsets.symmetric(horizontal: 30),
          //         child: Column(
          //           children: [
          //             Container(
          //                 child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "Name",
          //                   style: TextStyle(
          //                     color: AppColor.PrimaryDark,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Text(
          //                   "Price",
          //                   style: TextStyle(
          //                     color: AppColor.PrimaryDark,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Text(
          //                   "Hour/Day",
          //                   style: TextStyle(
          //                     color: AppColor.PrimaryDark,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 Text(
          //                   "Value",
          //                   style: TextStyle(
          //                     color: AppColor.PrimaryDark,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             )),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             /*addonList.length == 0
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
          //           ],
          //         ),
          //       ),

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
                                                    .map((String? item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item.toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ))
                                                    .toList(),
                                                value: selectedServiceTypeList[
                                                    index],
                                                onChanged: (value) {
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
                                                items: ['Hours', 'Days']
                                                    .map((String? item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(
                                                            item.toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ))
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
                                    )
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
                                  addonServicePriceControllerList
                                      .removeAt(index);
                                  addonHourDayPriceControllerList
                                      .removeAt(index);
                                  addonList2.removeAt(index);
                                  setState(() {});
                                },
                                child: Icon(Icons.remove_circle_outline)))
                      ],
                    );
                  },
                )
              ],
            ),
          ),

          SizedBox(
            height: 8.h,
          ),
        ],
      ),
    );
  }

  ServiceCategoryModel? serviceModel;

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
  }

  String? _selectedTime;

  Future<void> showTimePikar() async {
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

  List<String> subcateid = [];
  Future<void> getServiceCategories() async {
    // var userId = await MyToken.getUserID();
    String stringRepresentation =
        "${widget.profileResponse?.user?.subcategoryId}";
    print(stringRepresentation.toString() + "_________");
    subcateid = stringRepresentation.split(', ').map((String value) {
      return value.toString();
    }).toList();
    print(categorylist.toString() + "_________");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${Apipath.BASH_URL}get_categories_list',
        ));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      serviceModel = ServiceCategoryModel.fromJson(jsonDecode(str));
      print(
          '____________${widget.profileResponse?.user?.jsonData?.cat.toString()}');
      setState(() {
        selectedCategory11 = serviceModel?.data?.firstWhere((item) {
          if (item.id.toString() ==
              widget.profileResponse?.user?.jsonData?.cat.toString()) {
            return true;
          }
          return false;
        });
        print(selectedCategory11.cName);

        getServicesSubCategory(selectedCategory11.id);
      });

      // serviceModel?.data?.forEach((element) {
      //
      //
      //   if(element.id.toString() == widget.profileResponse?.user?.jsonData?.cat.toString()){
      //     serviceCategory.text = element.cName ?? '' ;
      //
      //     getServicesSubCategory(element.id.toString());
      //
      //   } else {
      //     selectedCategory = '' ;
      //   }
      // });
    } else {
      return null;
    }
  }

  ServiceSubCategoryModel? subCategory;
  Future<void> getServicesSubCategory(catId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));

    request.fields.addAll({'p_id': '$catId'});

    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();

      subCategory = ServiceSubCategoryModel.fromJson(json.decode(str));

      subCategory?.data?.forEach((element) {
        if (element.id.toString() ==
            widget.profileResponse?.user?.jsonData?.subCat.toString()) {
          serviceSubCategory.text = element.cName ?? '';
        }
      });
      setState(() {});
    } else {
      return null;
    }
  }

  Future addServices(param) async {
    print("ADD SERVICE PARAM=====" + param.toString());
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}add_restaurant'));
    request.fields.addAll(param);
    // List<MultipartFile> newList = [];
    // for(var img in imagePathList){
    //   if(img != ""){
    //     var multipartFile =  await http.MultipartFile.fromPath('res_image' , File(img).path, filename:img.split('/').last);
    //     newList.add(multipartFile);
    //   }
    // }
    // request.files.addAll(newList);
    if (imagePathList != null) {
      for (var i = 0; i < imagePathList.length; i++) {
        imagePathList == null
            ? null
            : request.files.add(await http.MultipartFile.fromPath(
                'res_image[]', imagePathList[i].toString()));
      }
    }
    print(request.files);
    http.StreamedResponse response = await request.send();
    print(request.toString());
    print(request.fields.toString());
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str.toString());
      return AddServicesModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  getImagePicker() async {
    /* var imageTemporary;
    var image = await ImagePickerGC.pickImage(
        context: context, source: ImgSource.Gallery);
    if (image == null) return;
    imageTemporary = File(image.path);
    setState(() {
      showImage = image.path;
    });
    var base64Image = '';
    if (imageTemporary.toString().isNotEmpty) {
      var _image = File(imageTemporary.path);
      File FileCompressed = await FlutterNativeImage.compressImage(_image.path,
          quality: 100, percentage: 50);
      List<int> imagebytes = FileCompressed.readAsBytesSync();
      base64Image = base64Encode(imagebytes);
      setState(() {
        servicePic = _image;
      });
      print("SERVICE PIC === ${servicePic.toString()}");
    }*/
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => servicePic = imageTemp);
      print("SERVICE PIC === $servicePic");
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("SERVICE PIC === ${imagePathList.length}");
    } else {
      // User canceled the picker
    }
  }

  TextEditingController usernameController = TextEditingController();
  File? file;
  String profileUrl = "";
  String url = "";

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
      setState(() {
        dateTimeSelected = result;
        service_price = visitingCharge.toString();
        onpenTime.text =
            "0${dateTimeSelected.hour}:${dateTimeSelected.minute == 0 ? "0${dateTimeSelected.minute}" : dateTimeSelected.minute} ";
      });
      /*if (onpenTime.text.isNotEmpty && serviceCharge.text.isNotEmpty) {
        // var totalCharges = (int.parse(visitingCharge!) + int.parse(serviceCharge.text.toString()));
        // print("TOTAL CHARGES=== $totalCharges");
        // perMinServiceCharge = totalCharges/60;
        // print("PERMINUTE SERVICE CHARGE=== ${perMinServiceCharge.toStringAsFixed(2)}");
        var parts = onpenTime.text.toString().split(':');
        var hrsToMinute = (int.parse(parts[0].padLeft(2, '0')) * 60);
        print("hrs min======$hrsToMinute");
        var finalTime = hrsToMinute + int.parse(parts[1].padLeft(2, '0'));
        print("FINAL TIME===== $finalTime");
        var amount = (int.parse(visitingCharge!) + (int.parse(serviceCharge.text.toString()) * finalTime));
        print("AMOUNT==== $amount");
        setState(() {
          finalCharges = amount.toString();
          servicePrice.text = finalCharges;
        });
      }*/
    }
  }
}
