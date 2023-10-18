import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();


  submitPage()async{
    var headers = {
      'Cookie': 'ci_session=38d9dee8bbf98d0b37628267475ee7e117536a8d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}/send_contact'));
    request.fields.addAll({
      'name': nameController.text,
      'email': emailController.text,
      'message': messageController.text
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult  = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['status'] == true){
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        nameController.clear();
        emailController.clear();
        messageController.clear();
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
///  user data test widget

  getUserData(){
    return Container(
      child: Column(
        children: [
          Text("Hello here"),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
              )
          ),
          backgroundColor: AppColor.PrimaryDark,
          elevation: 0,
          title: Text(
            'Contact Us',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading:  Padding(
            padding: const EdgeInsets.all(12),
            child: RawMaterialButton(
              shape: CircleBorder(),
              padding: const EdgeInsets.all(0),
              fillColor: Colors.white,
              splashColor: Colors.grey[400],
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: AppColor.PrimaryDark,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
        children: [
          TextFormField(
            controller: nameController,
            decoration:InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Name"
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: emailController,
            decoration:InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Email"
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: messageController,
            maxLines: 3,
            decoration:InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Message"
            ),
          ),
          SizedBox(height: 20,),

          MaterialButton(
            height: 45,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            onPressed: (){
              if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && messageController.text.isNotEmpty) {
                submitPage();
              }
              else{
                UtilityHlepar.getToast("Please select all fields");
              }
            },color: AppColor.PrimaryDark,child: Text("Submit",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),),

        ],),
    );
  }
}
