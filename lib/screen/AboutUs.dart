import 'dart:convert';
import 'package:fixerking/modal/Aboutusmodel.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String? description;
  String? title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          backgroundColor: AppColor.PrimaryDark,
          elevation: 0,
          title: Text(
            'About Us',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Padding(
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
          )),
      body: SingleChildScrollView(
        child: title != null
            ? Column(children: [
                Image.asset(aboutUImage),
                Container(
                    margin: EdgeInsets.all(5.0),
                    child: Html(
                      data: title,

                      /*style:Map<String, Style> => {TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                    ),}*/
                    )),
                Container(
                    margin: EdgeInsets.all(5.0),
                    child: Html(data: description)),
              ])
            : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  child: Image.asset("images/loader.gif"),
                )),
      ),
    );
  }

  Future<Aboutusmodel?> getAboutUs() async {
    var request = http.Request('GET',
        Uri.parse('https://developmentalphawizz.com/antsnest/api/about_us'));

    http.StreamedResponse response = await request.send();
    print(request);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = Aboutusmodel.fromJson(json.decode(str));
      print(jsonResponse);
      if (jsonResponse.responseCode == "1") {
        setState(() {
          title = jsonResponse.data?.title;
          description = jsonResponse.data?.html;
        });
      }
      return Aboutusmodel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
}
