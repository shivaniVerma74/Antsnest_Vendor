import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../modal/MessageModel.dart';
import '../modal/User_Model.dart';
import '../utils/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  User? user;

  ChatDetailScreen({this.user});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final db = FirebaseFirestore.instance;
  CollectionReference? chatReference;
  TextEditingController _textController = new TextEditingController();
  bool _isWritting = false;

  @override
  void initState() {
    super.initState();
    chatReference = db
        .collection("chats")
        .doc(widget.user!.id.toString())
        .collection('messages');
  }

  String? chatSenderId;
  TextEditingController messageController = TextEditingController();
  DateTime dateTime = DateTime.now();
  Message? userMessage;
  String? messageTime;

  sendChat() async {
    User users = User(
      id: widget.user!.id,
      name: "${widget.user!.name}",
      imageUrl: "",
      isOnline: widget.user!.isOnline,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("senderId", "${users.id}");
    String? idChek = prefs.getString("senderId");
    print("idCheck here ${idChek}");
    String? senderName;
    senderName = widget.user!.name.toString();
    print("sender name here ${senderName}");
    messageTime = DateFormat("hh:mm a").format(DateTime.now());
    setState(() {
      messages.add(Message(
          text: messageController.text.toString(),
          time: messageTime.toString(),
          sender: users));
    });
    setState(() {
      messageController.clear();
    });
    chatSenderId = prefs.getString("senderId");
  }

  _chatBubble(Message message, bool isMe, bool isSameUser) {
    print("its me check ${isMe}");
    if (!isMe) {
      print("yes its me");
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.PrimaryDark,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Text(
                "${message.text.toString()}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      message.time.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColor.PrimaryDark,
                        // backgroundImage: AssetImage(message.sender!.imageUrl.toString()),
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    } else {
      print("Its not me");
      return Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Text(
                "${message.text.toString()}",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          !isSameUser
              ? Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15,
                        //.backgroundImage: AssetImage(message.sender!.imageUrl.toString()),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      message.time.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              : Container(
                  child: null,
                ),
        ],
      );
    }
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: AppColor.PrimaryDark,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: AppColor.PrimaryDark,
            onPressed: () {
              if (_textController.text.isEmpty) {
                print('Text is empty');
                Fluttertoast.showToast(msg: "Please enter text");
              } else if (!containsNoEmailOrPhoneNumber(_textController.text)) {
                showWarningDialog(context);
              } else {
                sendChat();
              }
            },
          ),
        ],
      ),
    );
  }

  bool containsNoEmailOrPhoneNumber(String text) {
    // Regex pattern for a simple email validation
    final emailRegex = RegExp(
      r'[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    // Regex pattern for a simple phone number validation
    // Adjust the regex according to the phone number formats you need to detect
    final phoneRegex = RegExp(
      r'\+?\d[\d -]{8,12}\d',
    );

    // Check if the text does not match either regex
    return !emailRegex.hasMatch(text) && !phoneRegex.hasMatch(text);
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
                  Icons.cancel_outlined,
                  size: 50,
                  color: AppColor.PrimaryDark,
                ),
                SizedBox(
                    height:
                        10), // Provides spacing between the icon and the text.
                Text(
                  "Warning",
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
                  "We advise not sharing your contact number on AntsNest as it may violate our Terms of Service and lead to suspension of your account. To stay safe, always book services through AntsNest.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
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
                // ElevatedButton(
                //   onPressed: () => Navigator.of(context).pop(),
                //   child: Text('OK'),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.red, // Button color
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int? prevUserId;
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: widget.user!.name.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
              TextSpan(text: '\n'),
              widget.user!.isOnline == true
                  ? TextSpan(
                      text: 'Online',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : TextSpan(
                      text: 'Offline',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    )
            ],
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                // final bool isMe = message.sender!.id == currentUser.id;
                final bool isMe = message.sender!.id == currentUser.id;
                print("checking isMe ${isMe}");
                final bool isSameUser = prevUserId == message.sender!.id;
                prevUserId = message.sender!.id;
                return _chatBubble(message, isMe, isSameUser);
              },
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
