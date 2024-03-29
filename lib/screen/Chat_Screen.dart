import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../api/api_helper/ApiList.dart';
import '../api/api_path.dart';
import '../modal/MessageModel.dart';
import '../modal/VendorOrderModel.dart';
import '../token/app_token_data.dart';
import 'package:http/http.dart' as http;
import '../utils/app_strings.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/widget.dart';
import 'chat_page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var userId;
  List<Data> vendorList = [];

  Future<VendorOrderModel?> getVendorBooking() async {
    userId = await MyToken.getUserID();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_bookings'));
    request.fields.addAll({'user_id': '$userId'});
    print("@@@ $request");
    print(request.fields);
    print(request.headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      vendorList =
          VendorOrderModel.fromJson(json.decode(str)).data!.cast<Data>();

      print(vendorList.length.toString() + "________________");
      log(vendorList.toString());

      print(str);
      return VendorOrderModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  checkDouble(List<Data>? data) {
    if (vendorList.every((item) => data!.contains(item))) {
      return false;
    } else {
      return true;
    }
  }

  readMessageCount() async {
    var vendorId = await MyToken.getUserID();
    var request = http.MultipartRequest(
        'POST', Uri.parse(BaseUrl + 'read_chat_message_user'));
    request.fields.addAll({
      'user_id': '${vendorId.toString()}',
      // 'type':"provider"
    });
    http.StreamedResponse response = await request.send();
    var finalResponse = await response.stream.bytesToString();
    print(finalResponse);
  }

  @override
  void initState() {
    readMessageCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColor.PrimaryDark,
          elevation: 8,
          title: Text(
            'Users List',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     color: Colors.white,
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: FutureBuilder(
            future: getVendorBooking(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              VendorOrderModel? model = snapshot.data;
              print(model.toString());
              if (snapshot.hasData) {
                return model!.responseCode == "1"
                    ? Container(
                        child: ListView.builder(
                          itemCount: model.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Message chat = chats[0];
                            return
                                // model.data![index].id == model.data![index].id
                                //     ? SizedBox(height: 0) :
                                //  vendorList[0].username == model.data![index].username.toString()
                                //vendorList.any(item) == model.data!.contains(item)
                                //   return true;
                                // } else {
                                //   return false;
                                // }
                                checkDouble(model.data)
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ChatPage(
                                                  bookingId: model
                                                      .data![index].id
                                                      .toString(),
                                                  providerName: model
                                                      .data![index].username
                                                      .toString()
                                                  //  ChatDetailScreen(
                                                  // user: chat.sender,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 15,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration:
                                                    //chat.unread!
                                                    //     ? BoxDecoration(
                                                    //   borderRadius: BorderRadius.all(Radius.circular(40)),
                                                    //   border: Border.all(
                                                    //     width: 2,
                                                    //     color: Theme.of(context).primaryColor,
                                                    //   ),
                                                    //   // shape: BoxShape.circle,
                                                    //   boxShadow: [
                                                    //     BoxShadow(
                                                    //       color: Colors.grey.withOpacity(0.5),
                                                    //       spreadRadius: 0.2,
                                                    //       blurRadius: 0.2,
                                                    //     ),
                                                    //   ],
                                                    // )
                                                    //     :
                                                    BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 0.2,
                                                      blurRadius: 0.2,
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor:
                                                      AppColor.PrimaryDark,
                                                  backgroundImage: NetworkImage(
                                                    "${model.data![index].profilePic}",
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.65,
                                                padding: EdgeInsets.only(
                                                  left: 20,
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              "${model.data![index].username}",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        // Text(
                                                        //   chat.time.toString(),
                                                        //   style: TextStyle(
                                                        //     fontSize: 11,
                                                        //     fontWeight: FontWeight.w300,
                                                        //     color: Colors.black54,
                                                        //   ),
                                                        // ),

                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (_) => ChatPage(
                                                                      bookingId: model
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      providerName: model
                                                                          .data![
                                                                              index]
                                                                          .username
                                                                          .toString()
                                                                      //  ChatDetailScreen(
                                                                      // user: chat.sender,
                                                                      ),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              width: 60,
                                                              height: 25,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .PrimaryDark,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2)),
                                                              child: Center(
                                                                  child: Text(
                                                                "Chat",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                            )),
                                                      ],
                                                    ),
                                                    // SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    // Container(
                                                    //   alignment: Alignment.topLeft,
                                                    //   child: Text(
                                                    //     chat.text.toString(),
                                                    //     style: TextStyle(
                                                    //       fontSize: 13,
                                                    //       color: Colors.black54,
                                                    //     ),
                                                    //     overflow: TextOverflow.ellipsis,
                                                    //     maxLines: 2,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 0,
                                      );
                          },
                        ),
                      )
                    : Center(
                        child: Container(
                        child: Text("No Chat Found!!"),
                      ));
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(
                  child: Image.asset("images/icons/loader.gif"),
                );
              }
            })
        // ListView.builder(
        //   itemCount: chats.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     final Message chat = chats[index];
        //     return GestureDetector(
        //       onTap: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (_) => ChatPage(receiver: chat.sender, chatId: "1", title: "title"
        //             //  ChatDetailScreen(
        //            // user: chat.sender,
        //           ),
        //         ),
        //       ),
        //       child: Container(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: 20,
        //           vertical: 15,
        //         ),
        //         child: Row(
        //           children: <Widget>[
        //             Container(
        //               padding: EdgeInsets.all(2),
        //               decoration: chat.unread!
        //                   ? BoxDecoration(
        //                 borderRadius: BorderRadius.all(Radius.circular(40)),
        //                 border: Border.all(
        //                   width: 2,
        //                   color: Theme.of(context).primaryColor,
        //                 ),
        //                 // shape: BoxShape.circle,
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.grey.withOpacity(0.5),
        //                     spreadRadius: 2,
        //                     blurRadius: 2,
        //                   ),
        //                 ],
        //               )
        //                   : BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.grey.withOpacity(0.5),
        //                     spreadRadius: 2,
        //                     blurRadius: 2,
        //                   ),
        //                 ],
        //               ),
        //               child: CircleAvatar(
        //                 radius: 25,
        //                 backgroundColor: AppColor.PrimaryDark,
        //                 backgroundImage: AssetImage(chat.sender!.imageUrl.toString()),
        //               ),
        //             ),
        //             Container(
        //               width: MediaQuery.of(context).size.width * 0.65,
        //               padding: EdgeInsets.only(
        //                 left: 20,
        //               ),
        //               child: Column(
        //                 children: <Widget>[
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: <Widget>[
        //                       Row(
        //                         children: <Widget>[
        //                           Text(
        //                             chat.sender!.name.toString(),
        //                             style: TextStyle(
        //                               fontSize: 16,
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                           ),
        //                           chat.sender!.isOnline == true
        //                               ? Container(
        //                             margin: const EdgeInsets.only(left: 5),
        //                             width: 7,
        //                             height: 7,
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               color: AppColor.PrimaryDark,
        //                             ),
        //                           )
        //                               : Container(
        //                             child: null,
        //                           ),
        //                         ],
        //                       ),
        //                       Text(
        //                         chat.time.toString(),
        //                         style: TextStyle(
        //                           fontSize: 11,
        //                           fontWeight: FontWeight.w300,
        //                           color: Colors.black54,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Container(
        //                     alignment: Alignment.topLeft,
        //                     child: Text(
        //                       chat.text.toString(),
        //                       style: TextStyle(
        //                         fontSize: 13,
        //                         color: Colors.black54,
        //                       ),
        //                       overflow: TextOverflow.ellipsis,
        //                       maxLines: 2,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
