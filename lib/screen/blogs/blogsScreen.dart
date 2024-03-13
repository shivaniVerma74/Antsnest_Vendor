import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/blogsModel.dart';
import 'package:fixerking/screen/blogs/editAddBlogScreen.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  Future getMyBlogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = await MyToken.getUserID();
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}my_blog'));
    request.fields.addAll({'vendor_id': '$userId'});
    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str.toString());
      return BlogsModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        Future.delayed(Duration(seconds: 2));
        return getMyBlogs();
      },
      child: Scaffold(
          backgroundColor: AppColor().colorBg1(),
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: AppColor.PrimaryDark,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: EditAddBlogScreen(
                      forEdit: false,
                      title: '',
                      description: '',
                      blog_id: '',
                      status: '',
                      image: '',
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 500),
                  ));
            },
          ),
          appBar: AppBar(
            backgroundColor: AppColor.PrimaryDark,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            elevation: 2,
            title: Text(
              "My Blogs",
              style: TextStyle(
                fontSize: 20,
                color: AppColor().colorBg1(),
              ),
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
            ),
          ),
          body: FutureBuilder(
              future: getMyBlogs(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  BlogsModel his = snapshot.data;
                  return his.responseCode == "1"
                      ? GridView.builder(
                          shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          padding: EdgeInsets.all(8),
                          itemCount: his!.data!.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 95 / 110,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var isActive =
                                his.data[index].status == "0" ? false : true;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                              child: EditAddBlogScreen(
                                                forEdit: true,
                                                title: his.data[index].title,
                                                description:
                                                    his.data[index].description,
                                                blog_id: his.data[index].id,
                                                status: his.data[index].status,
                                                image: his.data[index].image,
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              duration:
                                                  Duration(milliseconds: 500),
                                            ));
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 150,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          child: Image.network(
                                            "${his.data[index].image}",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      his.data[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: EditAddBlogScreen(
                                                      forEdit: true,
                                                      title:
                                                          his.data[index].title,
                                                      description: his
                                                          .data[index]
                                                          .description,
                                                      blog_id:
                                                          his.data[index].id,
                                                      status: his
                                                          .data[index].status,
                                                      image:
                                                          his.data[index].image,
                                                    ),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                  ));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.edit),
                                            )),
                                        CupertinoSwitch(
                                          // thumbColor: Colors.red,
                                          trackColor: Colors.red,
                                          value: isActive,

                                          onChanged: (value) async {
                                            isActive = !isActive;
                                            setState(() {});
                                            multipartRequestWithoutImage(
                                                '${Apipath.BASH_URL}add_blog',
                                                blog_id: his.data[index].id,
                                                status:
                                                    his.data[index].status ==
                                                            "0"
                                                        ? "1"
                                                        : "0",
                                                title: his.data[index].title,
                                                description: his
                                                    .data[index].description);
                                            getMyBlogs();
                                            setState(() {});
                                            // enablelist[index] =
                                            //     value == true ? "1" : "0";
                                            // setState(() {});
                                            // activeDeactiveService(
                                            //     "${vendorServiceModel?.restaurants?[index].resId}",
                                            //     "${enablelist[index]}");
                                            // getVendorAllServices();
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text("No Blogs"),
                        );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return Center(child: Image.asset("images/icons/loader.gif"));
                }
              })),
    );
  }

  Future<Map<String, dynamic>> multipartRequestWithoutImage(
    String api, {
    required String blog_id,
    required String status,
    required String title,
    required String description,
  }) async {
    final url = Uri.parse(api);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = await MyToken.getUserID();
    print(
        "========================================================================================================");
    print(
        "-------------------------------------------- URL --------------------------------------------");
    print("$url");
    print(
        "-------------------------------------------- PARAMETERS --------------------------------------------");

    final request = http.MultipartRequest(
      "POST",
      url,
    );
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    request.fields["vendor_id"] = userId.toString();
    request.fields["title"] = title.toString();
    request.fields["description"] = description.toString();
    request.fields["blog_id"] = blog_id.toString();
    request.fields["status"] = status.toString();

    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    print(res.body);

    final Map<String, dynamic> json = await jsonDecode(res.body);
    getMyBlogs();

    return json;
  }
}
