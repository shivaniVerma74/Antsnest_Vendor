import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../api/api_path.dart';
import '../../token/app_token_data.dart';
import '../../utils/colors.dart';
import '../bottom_bar.dart';
import '../home_screen.dart';
import 'chat_page.dart';
import 'constants.dart';
import 'models/Model.dart';
import 'models/ticket_model.dart';
import 'models/ticket_type_model.dart';

class CustomerSupport extends StatefulWidget {
  @override
  _CustomerSupportState createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport>
    with TickerProviderStateMixin {
  bool _isLoading = true, _isProgress = false;
  Animation? buttonSqueezeanimation;
  late AnimationController buttonController;
  bool _isNetworkAvail = true;
  List<TicketType> typeList = [];
  List<Tickets> ticketList = [];
  List<Model> statusList = [];
  List<Tickets> tempList = [];
  int timeOut = 50;
  String? type, email, title, desc, status, id;
  FocusNode? nameFocus, emailFocus, descFocus;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool edit = false, show = false;
  bool fabIsVisible = true;
  ScrollController controller = new ScrollController();
  int offset = 0;
  int perPage = 0;
  int total = 0, curEdit = -1;
  bool isLoadingmore = true;
  String? userId;
  checkingLogin() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = await MyToken.getUserID();

    print('___________${userId}__________');

    getTicket();
  }

  @override
  void initState() {
    super.initState();
    //getType();
    statusList = [
      Model(id: "3", title: "Resolved"),
      Model(id: "5", title: "Reopen")
    ];
    getData();
    // checkingLogin();
    // buttonController = new AnimationController(
    //     duration: new Duration(milliseconds: 2000), vsync: this);
    //
    // buttonSqueezeanimation = new Tween(
    //   begin: MediaQuery.of(context).size.width * 0.7,
    //   end: 50.0,
    // ).animate(new CurvedAnimation(
    //   parent: buttonController,
    //   curve: new Interval(
    //     0.0,
    //     0.150,
    //   ),
    // ));
    // controller = ScrollController();
    // controller.addListener(() {
    //   setState(() {
    //     fabIsVisible =
    //         controller.position.userScrollDirection == ScrollDirection.forward;
    //
    //     if (controller.offset >= controller.position.maxScrollExtent &&
    //         !controller.position.outOfRange) {
    //       isLoadingmore = true;
    //
    //       if (offset < total) getTicket();
    //     }
    //   });
    // });
  }

  getData() async {
    await getType();
    await checkingLogin();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBar(
                        index: 0,
                      ),
                    ));
              },
              child: Icon(Icons.arrow_back_outlined)),
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor.PrimaryDark,
          title: Text(
            "Customer Support Tickets",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        // getSimpleAppBar(getTranslated(context, 'CUSTOMER_SUPPORT')!, context),
        // floatingActionButton: AnimatedOpacity(
        //   child: FloatingActionButton(
        //     child: Container(
        //       width: 60,
        //       height: 60,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: backgroundblack,
        //       ),
        //       child: Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ),
        //     ),
        //     onPressed: () async {
        //       setState(() {
        //         edit = false;
        //         show = !show;
        //
        //         clearAll();
        //       });
        //     },
        //     heroTag: null,
        //   ),
        //   duration: Duration(milliseconds: 100),
        //   opacity: fabIsVisible ? 1 : 0,
        // ),
        body:
            // _isNetworkAvail
            //     ? _isLoading
            //     // ? shimmer(context)
            //     ?
            SingleChildScrollView(
                controller: controller,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // show
                      //     ? Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Card(
                      //       elevation: 0,
                      //
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //           border: Border.all(
                      //             color: backgroundblack
                      //           )
                      //         ),
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Column(
                      //           crossAxisAlignment:
                      //           CrossAxisAlignment.end,
                      //           children: [
                      //             setType(),
                      //             // setEmail(),
                      //             //    setTitle(),
                      //             setDesc(),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 edit
                      //                     ? statusDropDown()
                      //                     : Container(),
                      //                 Spacer(),
                      //                 sendButton(),
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       )),
                      //     )
                      //     : SizedBox.shrink(),
                      //     : Container(),
                      ticketList.length > 0
                          ? ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (offset < total)
                                  ? ticketList.length + 1
                                  : ticketList.length,
                              itemBuilder: (context, index) {
                                return
                                    // (index == ticketList.length ) ?
                                    // &&
                                    // isLoadingmore)
                                    ticketItem(index);
                                // : Center(
                                // child:
                                // CircularProgressIndicator());
                              })
                          : Center(
                              child: Container(
                                  // height: MediaQuery.of(context).size.height -
                                  //     kToolbarHeight -
                                  //     MediaQuery.of(context).padding.top,
                                  child: Center(
                                child: Text(
                                  "No items",
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                            )
                      // getNoItem(context))
                    ],
                  ),
                ))
        //     : Center(child: Text("Something went wrong!"))
        // : Center(child:  Text("Something went wrong!"))
        );
  }

  Widget setType() {
    return DropdownButtonFormField(
      iconEnabledColor: Colors.black,
      isDense: true,
      hint: new Text(
        "Select Type",
        // getTranslated(context, 'SELECT_TYPE')!,
        style: Theme.of(this.context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
      ),
      decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          )
          // focusedBorder: OutlineInputBorder(
          //   borderSide:
          //   BorderSide(color: Colors.black),
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide:
          //   BorderSide(color: Colors.white),
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          ),
      value: type,
      style:
          Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.black),
      onChanged: (String? newValue) {
        if (mounted)
          setState(() {
            type = newValue;
          });
      },
      items: typeList.map((TicketType user) {
        return DropdownMenuItem<String>(
          value: user.id,
          child: Text(
            user.title!,
          ),
        );
      }).toList(),
    );
  }

  void validateAndSubmit() async {
    if (type == null)
      setSnackbar('Please Select Type');
    else if (validateAndSave()) {
      // sendRequest();
    }
  }

  // Future<void> checkNetwork() async {
  //   bool avail = true;
  //   //await isNetworkAvailable();
  //   if (avail) {
  //     sendRequest();
  //   } else {
  //     Future.delayed(Duration(seconds: 2)).then((_) async {
  //       if (mounted)
  //         setState(() {
  //           _isNetworkAvail = false;
  //         });
  //       await buttonController.reverse();
  //     });
  //   }
  // }

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;
    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

  setEmail() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 10.0,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        focusNode: emailFocus,
        textInputAction: TextInputAction.next,
        controller: emailController,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        // validator: (val) => validateEmail(
        //     val!,
        //     getTranslated(context, 'EMAIL_REQUIRED'),
        //     getTranslated(context, 'VALID_EMAIL')),
        onSaved: (String? value) {
          email = value;
        },
        onFieldSubmitted: (v) {
          _fieldFocusChange(context, emailFocus!, nameFocus);
        },
        decoration: InputDecoration(
          hintText: "Email",
          //getTranslated(context, 'EMAILHINT_LBL'),
          hintStyle: Theme.of(this.context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  setTitle() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 10.0,
      ),
      child: TextFormField(
        focusNode: nameFocus,
        textInputAction: TextInputAction.next,
        controller: nameController,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        // validator: (val) =>
        // validateField(val!, getTranslated(context, 'FIELD_REQUIRED')),
        onSaved: (String? value) {
          title = value;
        },
        onFieldSubmitted: (v) {
          _fieldFocusChange(context, emailFocus!, nameFocus);
        },
        decoration: InputDecoration(
          hintText: "Title",
          // getTranslated(context, 'TITLE'),
          hintStyle: Theme.of(this.context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  setDesc() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: 10.0,
      ),
      child: TextFormField(
        focusNode: descFocus,
        controller: descController,
        maxLines: null,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        // validator: (val) =>
        //     validateField(val!, getTranslated(context, 'FIELD_REQUIRED')),
        onSaved: (String? value) {
          desc = value;
        },
        onFieldSubmitted: (v) {
          _fieldFocusChange(context, emailFocus!, nameFocus);
        },
        decoration: InputDecoration(
            hintText: "Description",
            // getTranslated(context, 'DESCRIPTION'),
            hintStyle: Theme.of(this.context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            )
            // focusedBorder: OutlineInputBorder(
            //   borderSide:
            //   BorderSide(color: Colors.black),
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            // enabledBorder: UnderlineInputBorder(
            //   borderSide:
            //   BorderSide(color: Colors.white),
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // Future<void> getType() async {
  //   // _isNetworkAvail = await isNetworkAvailable();
  //   // if (_isNetworkAvail) {
  //     try {
  //       Response response = await post(Uri.parse(Apipath.getTicketsTypeApi),
  //           // headers: headers
  //       )
  //           .timeout(Duration(seconds: timeOut));
  //
  //       var getdata = json.decode(response.body);
  //       // bool error = getdata["error"];
  //       String? msg = getdata["message"];
  //       // if (!error) {
  //         var data = getdata["data"];
  //
  //         typeList = (data as List)
  //             .map((data) => new Model.fromSupport(data))
  //             .toList();
  //       // } else {
  //       //   setSnackbar(msg!);
  //       // }
  //       if (mounted)
  //         setState(() {
  //           _isLoading = false;
  //         });
  //     } on TimeoutException catch (_) {
  //       setSnackbar("User");
  //     }
  //   // } else {
  //     if (mounted)
  //       setState(() {
  //         _isNetworkAvail = false;
  //       });
  //   // }
  // }
  Future getType() async {
    print("gettype");

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? userId = prefs.getString(TokenString.userid);

    var request =
        http.MultipartRequest('GET', Uri.parse('${Apipath.getTicketsTypeApi}'));
    request.fields.addAll({
      // "user_id": '${userId.toString()}',
      // "ticket_id": "1",
      // "user_type": "admin",
      // "message": "test",
      // '${userId.toString()}'
    });
    print("this is request !!${Apipath.getTicketsTypeApi} ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    print('==============${request.fields}==============');
    print('==============${request.url}==============');

    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = TicketTypeModel.fromJson(json.decode(str));
      typeList = datas.data!;

      print('this is types ${typeList.length}');

      //     .map((data) => TicketModel.fromJson(json.decode(str))
      //     .toList();
      // tempList = datas.data;
      return TicketTypeModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future getTicket() async {
    print("getid");
    var vendorId = await MyToken.getUserID();
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.getTicketsApi}'));
    request.fields.addAll({
      "user_id": vendorId.toString(),
    });
    print("this is request !! ${request.fields}");
    print("this is request !! ${request.url}");

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var dat = TicketModel.fromJson(json.decode(str));

      setState(() {
        ticketList = dat.data ?? [];
      });

      print("this is ticket list data ${ticketList.length}");
      return TicketModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
  // Future<void> getTicket() async {
  //   // _isNetworkAvail = await isNetworkAvailable();
  //   if (_isNetworkAvail) {
  //     try {
  //       var parameter = {
  //         "user_id": userId,
  //         "ticket_id": "1",
  //         "user_type": "admin",
  //         "message": "test",
  //       };
  //
  //       Response response =
  //       await post(Uri.parse(Apipath.getTicketsApi), body: parameter)
  //           .timeout(Duration(seconds: timeOut));
  //       print(parameter);
  //
  //       print(response.body);
  //       var getdata = json.decode(response.body);
  //       bool error = getdata["error"];
  //       String? msg = getdata["message"];
  //       // if (!error) {
  //         var data = getdata["data"];
  //         total = int.parse(getdata["total"]);
  //
  //         if ((offset) < total) {
  //           tempList.clear();
  //           var data = getdata["data"];
  //           tempList =
  //           (data as List)
  //               .map((data) =>  TicketModel.fromJson(data)).cast<Model>()
  //               .toList();
  //
  //           ticketList.addAll(tempList);
  //
  //           offset = offset + perPage;
  //         }
  //       // }
  //       // else {
  //       //   if (msg != "Ticket(s) does not exist") setSnackbar(msg!);
  //       //   isLoadingmore = false;
  //       // }
  //       if (mounted)
  //         setState(() {
  //           _isLoading = false;
  //         });
  //     } on TimeoutException catch (_) {
  //       setSnackbar("Something went wrong!"
  //           // getTranslated(context, 'somethingMSg')!
  //       );
  //     }
  //   } else {
  //     if (mounted)
  //       setState(() {
  //         _isNetworkAvail = false;
  //       });
  //   }
  // }

  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 1.0,
    ));
  }

  Widget sendButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ElevatedButton(
          onPressed: () {
            validateAndSubmit();
          },
          child: Text("Send"),
          style: ElevatedButton.styleFrom(primary: AppColor.PrimaryDark),
        )
        // AppBtn(
        //     size: 150,
        //     label: "Send",
        //     onPress: () {
        //       validateAndSubmit();
        //     }),
        );
  }

  // Future<void> sendRequest() async {
  //   if (mounted)
  //     setState(() {
  //       _isProgress = true;
  //     });
  //   try {
  //     var data = {
  //       "user_id":userId,
  //       "subject": descController.text.toString(),
  //       "email" : "$email",
  //       //CUR_USERID,
  //       // SUB: "",
  //       // title,
  //       "description": desc,
  //       "ticket_type_id": type,
  //       // EMAIL: ""
  //       //email,
  //     };
  //     if (edit) {
  //       data['ticket_id'] = id;
  //       // data[TICKET_ID] = id;
  //       // data[DESC] = desc;
  //       // data[STATUS] = status;
  //     }
  //     Response response = await post(edit ? Uri.parse(Apipath.editTicketApi) : Uri.parse(Apipath.addTicketApi),
  //         body: data,
  //         // headers: headers
  //     )
  //         .timeout(Duration(seconds: timeOut));
  //
  //
  //     if (response.statusCode == 200) {
  //       var getdata = json.decode(response.body);
  //
  //       bool error = getdata["error"];
  //       String msg = getdata["message"];
  //       if (!error) {
  //         var data = getdata["data"];
  //         _isProgress = false;
  //         if (mounted)
  //           setState(() {
  //             if (edit)
  //               ticketList[curEdit] = Model.fromTicket(data[0]);
  //             else
  //               ticketList.add(Model.fromTicket(data[0]));
  //             edit = false;
  //
  //             clearAll();
  //           });
  //       }
  //       setSnackbar(msg);
  //       _isProgress = false;
  //     }
  //   } on TimeoutException catch (_) {
  //     setSnackbar("Something went wrong!");
  //   }
  // }

  clearAll() {
    type = null;
    email = null;
    title = null;
    desc = null;
    emailController.text = "";
    nameController.text = "";
    descController.text = "";
  }

  Widget ticketItem(int index) {
    Color back;
    String? status = ticketList[index].status;
    //1 -> pending, 2 -> opened, 3 -> resolved, 4 -> closed, 5 -> reopened
    if (status == "PENDING") {
      back = Colors.orange;
      status = "Pending";
    } else if (status == "OPENED") {
      back = Colors.cyan;
      status = "Opened";
    } else if (status == "RESOLVE") {
      back = Colors.green;
      status = "Resolved";
    } else if (status == "REOPEN") {
      back = Colors.cyan;
      status = "Reopen";
    } else {
      back = Colors.red;
      status = "Closed";
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();

            /// Chat
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(
                    datetime: ticketList[index].dateCreated,
                    descruption: ticketList[index].description,
                    subject: ticketList[index].subject,
                    id: ticketList[index].id,
                    status: ticketList[index].status,
                  ),
                ));

            /// Chat
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.PrimaryDark)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date" + " : " + ticketList[index].lastUpdated!),
                    Container(
                      // width: 80,
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                          color: back,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(4.0))),
                      child: Text(
                        status,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                // Text("Title" +
                //     " : " +
                //     ticketList[index].ticketType!),
                Text(
                  "Subject : " + ticketList[index].subject!,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Description" + " : " + ticketList[index].description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      // GestureDetector(
                      //     child: Container(
                      //       margin: EdgeInsetsDirectional.only(start: 8),
                      //       padding:
                      //       EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      //       decoration: BoxDecoration(
                      //         color: backgroundblack,
                      //         borderRadius: new BorderRadius.all(
                      //           const Radius.circular(4.0),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         "Edit",
                      //         // getTranslated(context, 'EDIT')!,
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 11),
                      //       ),
                      //     ),
                      //     onTap: () {
                      //       setState(() {
                      //         edit = true;
                      //         show = true;
                      //         curEdit = index;
                      //         id = ticketList[index].id;
                      //         emailController.text = ticketList[index].email!;
                      //         nameController.text = ticketList[index].ticketType!;
                      //         descController.text = ticketList[index].description!;
                      //         type = ticketList[index].ticketTypeId;
                      //       });
                      //     }),
                      GestureDetector(
                          child: Container(
                            // margin: EdgeInsetsDirectional.only(start: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                                color: AppColor.PrimaryDark,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(4.0))),
                            child: Text(
                              "Chat",
                              // getTranslated(context, 'CHAT')!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          onTap: () {
                            /// Chat
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Chat(
                            //         id: ticketList[index].id,
                            //         status: ticketList[index].status,
                            //       ),
                            //     ));
                            /// Chat
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  statusDropDown() {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      child: DropdownButtonFormField(
        iconEnabledColor: Colors.black,
        isDense: true,
        hint: new Text(
          "Select Type",
          // getTranslated(context, 'SELECT_TYPE')!,
          style: Theme.of(this.context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        value: status,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: Colors.black),
        onChanged: (String? newValue) {
          if (mounted)
            setState(() {
              status = newValue;
            });
        },
        items: statusList.map((Model user) {
          return DropdownMenuItem<String>(
            value: user.id,
            child: Text(
              user.title!,
            ),
          );
        }).toList(),
      ),
    );
  }

  // Widget noInternet(BuildContext context) {
  //   return Center(
  //     child: SingleChildScrollView(
  //       child: Column(mainAxisSize: MainAxisSize.min, children: [
  //         noIntImage(),
  //         noIntText(context),
  //         noIntDec(context),
  //         AppBtn(
  //           title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
  //           btnAnim: buttonSqueezeanimation,
  //           btnCntrl: buttonController,
  //           onBtnSelected: () async {
  //             _playAnimation();
  //
  //             Future.delayed(Duration(seconds: 2)).then((_) async {
  //               _isNetworkAvail = await isNetworkAvailable();
  //               if (_isNetworkAvail) {
  //                 Navigator.pushReplacement(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (BuildContext context) => super.widget));
  //               } else {
  //                 await buttonController.reverse();
  //                 if (mounted) setState(() {});
  //               }
  //             });
  //           },
  //         )
  //       ]),
  //     ),
  //   );
  // }
}
