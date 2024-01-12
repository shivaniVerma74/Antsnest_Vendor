import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../api/api_path.dart';
import '../modal/ReviewModel.dart';
import '../token/app_token_data.dart';
import '../utils/colors.dart';


class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {


  ReviewModel? reviewModel;

  getReview()async{
    var userid = await MyToken.getUserID();
    var headers = {
      'Cookie': 'ci_session=993cc18bb591b215f28f268af317bf0f9f4455e6'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}reviews_seller'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = ReviewModel.fromJson(json.decode(finalResult));
      setState(() {
        reviewModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200),(){
      return getReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Reviews",style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        child: reviewModel == null ? Center(child: Image.asset(
            "images/icons/loader.gif"),) : reviewModel!.data!.length == 0 ? Center(child: Text("No data to show"),) : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
            itemCount: reviewModel!.data!.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (c,i){
          return Card(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${reviewModel!.data![i].username}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),),
                      Text("${DateFormat('dd/MM/yyyy').format(DateTime.parse(reviewModel!.data![i].createdAt!.split(" ")[0].toString()))}"),
                    ],
                  ),
                    SizedBox(height: 10,),
                   Row(
                    children: [
                      Icon(Icons.star,color: Colors.yellow,),
                      SizedBox(width: 5,),
                      Text("${reviewModel!.data![i].revStars}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("${reviewModel!.data![i].revText}",maxLines: 2,),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
