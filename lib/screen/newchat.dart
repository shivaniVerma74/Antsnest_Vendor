import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_app/pages/gallary_page.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../modal/UploadImageModel.dart';
import '../modal/User_Model.dart';
import '../modal/VendorOrderModel.dart';
import '../utils/colors.dart';

class ChatPage extends StatefulWidget {
  //final SharedPreferences prefs;
  // VendorOrderModel? receiver;
  final String senderId;
  final String chatId;
  final String name;
  ChatPage({required this.senderId, required this.chatId, required this.name});
  @override
  ChatPageState createState() {
    return new ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  final db = FirebaseFirestore.instance;
  CollectionReference? chatReference;
  CollectionReference? currentChatReference;
  CollectionReference? assetReference;
  TextEditingController _textController = new TextEditingController();
  bool _isWritting = false;

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // DocumentReference docSnap = db.collection("chats").doc(widget.chatId).collection('messages').doc(widget.chatId);
    chatReference =
        db.collection("chats").doc(widget.chatId).collection('messages');
    assetReference =
        db.collection('chats').doc(widget.chatId).collection('images');
    //checkChat(AsyncSnapshot<QuerySnapshot> snapshot);
  }
  // checkChat(AsyncSnapshot<QuerySnapshot> snapshot){
  //   return snapshot.data!.docs
  //       .map((doc){
  //     doc['id'] == widget.senderId ?
  //     currentChatReference = db.collection("chats").doc(widget.chatId).collection('messages')
  //    : chatReference ;
  //   }
  //   );
  // }

  String? fileName;

  Future uploadImage() async {
    // int status = 1;
    // String fileName = Uuid().generateV4();
    //  await db.collection('chats').doc(widget.chatId).collection("messages").doc(fileName).set({
    //   "sendby": widget.name,
    //   "message":"",
    //   "type":"img",
    //   "time":FieldValue.serverTimestamp(),
    // });
    // var ref = FirebaseStorage.instance.ref().child('images').child("$fileName");
    // var uploadTask = await ref.putFile(imageFiles!).catchError((error)async{
    //   await db.collection('chats').doc(widget.chatId).collection("messages").doc(fileName).delete();
    //   status = 0;
    // });
    // if(status == 1){
    //   String imageUrl = await uploadTask.ref.getDownloadURL();
    //   await db.collection('chats').doc(widget.chatId).collection("messages").doc(fileName).update({
    //     "message":imageUrl
    //   });
    // }

    //String imageUrl = await uploadTask.ref.getDownloadURL();
    var headers = {
      'Authorization':
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjU2NTc2NTMsImlzcyI6ImVzaG9wIiwiZXhwIjoxNjY1NjU5NDUzfQ.C-OFpLdZsFB0vvLM5QJQlAUkGy8KSBHHHu8au7LYunk',
      'Cookie': 'ci_session=3ddd3c0c14f8a73b4925d7a92d041f2a9bd6162c'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/antsnest/api/upload_image'));
    print("working here");
    imageFiles == null
        ? SizedBox.shrink()
        : request.files.add(await http.MultipartFile.fromPath(
        'chat', imageFiles!.path.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
      UploadImageModel.fromJson(json.decode(finalResponse));
      print(
          "json response here ${jsonResponse.message} and ${jsonResponse.fileName}");
      print(
          'https://developmentalphawizz.com/antsnest/uploads/chats/${jsonResponse.fileName}');
      setState(() {
        fileName = jsonResponse.fileName;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text("",
                //documentSnapshot.data['text'].toString(),
                // widget.user!.name.toString(),
                //documentSnapshot.data['sender_name'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            // new Container(
            //   margin: const EdgeInsets.only(top: 5.0),
            //   child: documentSnapshot.data['image_url'] != ''
            //       ? InkWell(
            //     child: new Container(
            //       child: Image.network(
            //         documentSnapshot.data['image_url'],
            //         fit: BoxFit.fitWidth,
            //       ),
            //       height: 150,
            //       width: 150.0,
            //       color: Color.fromRGBO(0, 0, 0, 0.2),
            //       padding: EdgeInsets.all(5),
            //     ),
            //     onTap: () {
            //       // Navigator.of(context).push(
            //       //   MaterialPageRoute(
            //       //     builder: (context) => GalleryPage(
            //       //       imagePath: documentSnapshot.data['image_url'],
            //       //     ),
            //       //   ),
            //       // );
            //     },
            //   )
            //       : new Text(documentSnapshot.data['text']),
            // ),
          ],
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // new Container(
          //     margin: const EdgeInsets.only(left: 8.0),
          //     child: new CircleAvatar(
          //       backgroundImage:
          //       new NetworkImage(documentSnapshot.data['profile_photo']),
          //     )),
        ],
      ),
    ];
  }

  List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
    return <Widget>[
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // new Container(
          //     margin: const EdgeInsets.only(right: 8.0),
          //     child: new CircleAvatar(
          //       backgroundImage:
          //       new NetworkImage(documentSnapshot.data['profile_photo']),
          //     )),
        ],
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("",
                //documentSnapshot.data['sender_name'],
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            // new Container(
            //   margin: const EdgeInsets.only(top: 5.0),
            //   child: documentSnapshot.data['image_url'] != ''
            //       ? InkWell(
            //     child: new Container(
            //       child: Image.network(
            //         documentSnapshot.data['image_url'],
            //         fit: BoxFit.fitWidth,
            //       ),
            //       height: 150,
            //       width: 150.0,
            //       color: Color.fromRGBO(0, 0, 0, 0.2),
            //       padding: EdgeInsets.all(5),
            //     ),
            //     onTap: () {
            //       // Navigator.of(context).push(
            //       //   MaterialPageRoute(
            //       //     builder: (context) => GalleryPage(
            //       //       imagePath: documentSnapshot.data['image_url'],
            //       //     ),
            //       //   ),
            //       // );
            //     },
            //   )
            //       : new Text(documentSnapshot.data['text']),
            // ),
          ],
        ),
      ),
    ];
  }

  generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map<Widget>((doc) => Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(children: [
        Expanded(
          child: new Column(
            crossAxisAlignment: doc['received'] == false
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              //   doc['sender_id'] != widget.senderId ?
              //  // generateReceiverLayout(doc)
              //   Text("this is not a correct sender")
              // :
              //   fileName == null || fileName == "" || doc['image_url'] == "" ? SizedBox.shrink() :    doc['id'] == widget.senderId ?
              //   Container(
              //       height:90,
              //       width: 90,
              //       child: Image.network('https://developmentalphawizz.com/antsnest/uploads/chats/${fileName}')) : SizedBox.shrink(),
              //
              doc['id'] == widget.senderId
                  ? Text(doc['text'].toString(),
                  // widget.user!.name.toString(),
                  //documentSnapshot.data['sender_name'],
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))
                  : Container(height: 0),
              // Row(
              //   children: doc.data['sender_id'] != widget.prefs.getString('uid')
              //       ? generateReceiverLayout(doc)
              //       : Expanded(
              //     child: new Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: <Widget>[
              //         new Text("",
              //             //documentSnapshot.data['text'].toString(),
              //             // widget.user!.name.toString(),
              //             //documentSnapshot.data['sender_name'],
              //             style: new TextStyle(
              //                 fontSize: 14.0,
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold)),
              //         // new Container(
              //         //   margin: const EdgeInsets.only(top: 5.0),
              //         //   child: documentSnapshot.data['image_url'] != ''
              //         //       ? InkWell(
              //         //     child: new Container(
              //         //       child: Image.network(
              //         //         documentSnapshot.data['image_url'],
              //         //         fit: BoxFit.fitWidth,
              //         //       ),
              //         //       height: 150,
              //         //       width: 150.0,
              //         //       color: Color.fromRGBO(0, 0, 0, 0.2),
              //         //       padding: EdgeInsets.all(5),
              //         //     ),
              //         //     onTap: () {
              //         //       // Navigator.of(context).push(
              //         //       //   MaterialPageRoute(
              //         //       //     builder: (context) => GalleryPage(
              //         //       //       imagePath: documentSnapshot.data['image_url'],
              //         //       //     ),
              //         //       //   ),
              //         //       // );
              //         //     },
              //         //   )
              //         //       : new Text(documentSnapshot.data['text']),
              //         // ),
              //       ],
              //     ),
              //   ),
              //
              //   // Text(doc['text'].toString(),
              //   //     // widget.user!.name.toString(),
              //   //     //documentSnapshot.data['sender_name'],
              //   //     style: new TextStyle(
              //   //         fontSize: 14.0,
              //   //         color: Colors.black,
              //   //         fontWeight: FontWeight.bold)),
              //       // : generateSenderLayout(doc),
              // )

              // new Container(
              //   margin: const EdgeInsets.only(top: 5.0),
              //   child: documentSnapshot.data['image_url'] != ''
              //       ? InkWell(
              //     child: new Container(
              //       child: Image.network(
              //         documentSnapshot.data['image_url'],
              //         fit: BoxFit.fitWidth,
              //       ),
              //       height: 150,
              //       width: 150.0,
              //       color: Color.fromRGBO(0, 0, 0, 0.2),
              //       padding: EdgeInsets.all(5),
              //     ),
              //     onTap: () {
              //       // Navigator.of(context).push(
              //       //   MaterialPageRoute(
              //       //     builder: (context) => GalleryPage(
              //       //       imagePath: documentSnapshot.data['image_url'],
              //       //     ),
              //       //   ),
              //       // );
              //     },
              //   )
              //       : new Text(documentSnapshot.data['text']),
              // ),
            ],
          ),
        ),
      ]
        //doc.data['sender_id']
        // "11" != widget.user!.id.toString()
        //getString('uid')
        //     ? generateReceiverLayout(doc)
        //     :
        // generateSenderLayout(doc),
      ),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().colorPrimary(),
        title: Text(widget.name),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: new Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              // stream: db.collection("chats").doc(widget.chatId).collection("messages").snapshots(),
              //FirebaseFirestore.instance.collection("chats").doc(widget.chatId).collection('messages').snapshots(),
              stream:
              chatReference!.orderBy('time', descending: true).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // DocumentSnapshot message =
                // snapshot.data!.docs[0];
                if (!snapshot.hasData) return new Text("No Chat");
                return Expanded(
                  child: new ListView(
                    reverse: true,
                    children: snapshot.data!.docs.map<Widget>((doc) {
                      return doc['id'] == widget.senderId
                          ? Container(
                        margin:
                        const EdgeInsets.symmetric(vertical: 10.0),
                        child: new Row(children: [
                          Expanded(
                            child: new Column(
                              crossAxisAlignment: doc['received'] == false
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: <Widget>[
                                //   doc['sender_id'] != widget.senderId ?
                                //  // generateReceiverLayout(doc)
                                //   Text("this is not a correct sender")
                                // :
                                // fileName == null || fileName == "" || doc['image_url'] == "" ? SizedBox.shrink() :    doc['id'] == widget.senderId ?
                                //         Container(
                                //             height:90,
                                //             width: 90,
                                //             child: Image.network('https://developmentalphawizz.com/antsnest/uploads/chats/${fileName}')) : Container(),
                                doc['id'] == widget.senderId
                                    ? Text(doc['text'].toString(),
                                    // widget.user!.name.toString(),
                                    //documentSnapshot.data['sender_name'],
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                                    : Container(height: 0),
                                // Row(
                                //   children: doc.data['sender_id'] != widget.prefs.getString('uid')
                                //       ? generateReceiverLayout(doc)
                                //       : Expanded(
                                //     child: new Column(
                                //       crossAxisAlignment: CrossAxisAlignment.end,
                                //       children: <Widget>[
                                //         new Text("",
                                //             //documentSnapshot.data['text'].toString(),
                                //             // widget.user!.name.toString(),
                                //             //documentSnapshot.data['sender_name'],
                                //             style: new TextStyle(
                                //                 fontSize: 14.0,
                                //                 color: Colors.black,
                                //                 fontWeight: FontWeight.bold)),
                                //         // new Container(
                                //         //   margin: const EdgeInsets.only(top: 5.0),
                                //         //   child: documentSnapshot.data['image_url'] != ''
                                //         //       ? InkWell(
                                //         //     child: new Container(
                                //         //       child: Image.network(
                                //         //         documentSnapshot.data['image_url'],
                                //         //         fit: BoxFit.fitWidth,
                                //         //       ),
                                //         //       height: 150,
                                //         //       width: 150.0,
                                //         //       color: Color.fromRGBO(0, 0, 0, 0.2),
                                //         //       padding: EdgeInsets.all(5),
                                //         //     ),
                                //         //     onTap: () {
                                //         //       // Navigator.of(context).push(
                                //         //       //   MaterialPageRoute(
                                //         //       //     builder: (context) => GalleryPage(
                                //         //       //       imagePath: documentSnapshot.data['image_url'],
                                //         //       //     ),
                                //         //       //   ),
                                //         //       // );
                                //         //     },
                                //         //   )
                                //         //       : new Text(documentSnapshot.data['text']),
                                //         // ),
                                //       ],
                                //     ),
                                //   ),
                                //
                                //   // Text(doc['text'].toString(),
                                //   //     // widget.user!.name.toString(),
                                //   //     //documentSnapshot.data['sender_name'],
                                //   //     style: new TextStyle(
                                //   //         fontSize: 14.0,
                                //   //         color: Colors.black,
                                //   //         fontWeight: FontWeight.bold)),
                                //       // : generateSenderLayout(doc),
                                // )

                                // new Container(
                                //   margin: const EdgeInsets.only(top: 5.0),
                                //   child: documentSnapshot.data['image_url'] != ''
                                //       ? InkWell(
                                //     child: new Container(
                                //       child: Image.network(
                                //         documentSnapshot.data['image_url'],
                                //         fit: BoxFit.fitWidth,
                                //       ),
                                //       height: 150,
                                //       width: 150.0,
                                //       color: Color.fromRGBO(0, 0, 0, 0.2),
                                //       padding: EdgeInsets.all(5),
                                //     ),
                                //     onTap: () {
                                //       // Navigator.of(context).push(
                                //       //   MaterialPageRoute(
                                //       //     builder: (context) => GalleryPage(
                                //       //       imagePath: documentSnapshot.data['image_url'],
                                //       //     ),
                                //       //   ),
                                //       // );
                                //     },
                                //   )
                                //       : new Text(documentSnapshot.data['text']),
                                // ),
                              ],
                            ),
                          ),
                        ]
                          //doc.data['sender_id']
                          // "11" != widget.user!.id.toString()
                          //getString('uid')
                          //     ? generateReceiverLayout(doc)
                          //     :
                          // generateSenderLayout(doc),
                        ),
                      )
                          : SizedBox(
                        height: 0,
                      );
                    }).toList(),

                    //   generateMessages(snapshot),
                  ),
                );
              },
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
            new Builder(builder: (BuildContext context) {
              return new Container(width: 0.0, height: 0.0);
            })
          ],
        ),
      ),
    );
  }

  File? imageFiles;
  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(
        Icons.send,
        color: AppColor().colorPrimary(),
      ),
      onPressed: _isWritting ? () => _sendText(_textController.text) : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isWritting
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: AppColor().colorPrimary(),
                    ),
                    onPressed: () async {
                      // var image = await ImagePicker.platform.
                      // pickImage(
                      //     source: ImageSource.gallery);
                      PickedFile? image = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      imageFiles = File(image!.path);
                      if (imageFiles != null) {
                        print("it is working here");
                        uploadImage();
                        // FirebaseFirestore.instance.collection('images').doc(widget.chatId).set(
                        //     {
                        //       'sender_id' : widget.chatId,
                        //       'name': widget.name,
                        //       'image': imageFiles.toString()
                        //     }
                        // );
                        // var ref = FirebaseFirestore.instance.collection('images').doc(widget.chatId);
                        // print("checking refs here ${ref.path}");
                      }
                      //   print("checking files here ${imageFiles}");
                      //   int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      //   // Reference storageReference = FirebaseStorage
                      //   //     .instance
                      //   //     .ref()
                      //   //     .child('chats/images' + timestamp.toString() + '.jpg');
                      // //  var snapShot =  await FirebaseStorage.instance.ref().child('upload/').putFile(imageFiles!);
                      //   // UploadTask uploadTask =
                      //   // storageReference.putFile(imageFiles!);
                      //   // await uploadTask.storage;
                      //
                      //   // print("checking download url ${fileUrl}");
                      //   Reference ref = storage.ref().child('images/');
                      //   UploadTask uploadTask = ref.putFile(imageFiles!);
                      //    String fileUrl = await uploadTask.snapshot.ref.getDownloadURL();
                      //    print("download url here ${fileUrl}");
                      //_sendImage(messageText: null, imageUrl: 'https://developmentalphawizz.com/antsnest/uploads/chats/${fileName}');
                    }),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isWritting = messageText.length > 0;
                    });
                  },
                  onSubmitted: _sendText,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _sendText(String text) async {
    _textController.clear();
    chatReference!.add({
      'text': text,
      'id': widget.senderId,
      'sender_id': widget.chatId,
      'name': widget.name,
      'profile_photo': "",
      'image_url':
      'https://developmentalphawizz.com/antsnest/uploads/chats/${fileName}',
      'received': false,
      'time': FieldValue.serverTimestamp(),
    }).then((documentReference) {
      setState(() {
        _isWritting = false;
      });
    }).catchError((e) {});

    assetReference!.add({
      'sender_id': widget.chatId,
      'name': widget.name,
      'image': imageFiles.toString()
    });
  }

  void _sendImage({String? messageText, String? imageUrl}) {
    chatReference!.add({
      'text': messageText,
      'sender_id': widget.chatId,
      //  .getString('uid'),
      'sender_name': widget.name.toString(),
      //.getString('name'),
      'profile_photo': '',
      //.getString('profile_photo'),
      'image_url': imageUrl,
      'time': FieldValue.serverTimestamp(),
    });

    assetReference!.add({
      'sender_id': widget.chatId,
      'name': widget.name,
      'image': imageFiles.toString()
    });
  }
}
