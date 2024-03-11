import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditAddBlogScreen extends StatefulWidget {
  final bool forEdit;
  final String title;
  final String description;
  final String blog_id;
  final String status;
  final String image;
  const EditAddBlogScreen(
      {super.key,
      required this.forEdit,
      required this.title,
      required this.description,
      required this.blog_id,
      required this.status,
      required this.image});

  @override
  State<EditAddBlogScreen> createState() => _EditAddBlogScreenState();
}

class _EditAddBlogScreenState extends State<EditAddBlogScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.title;
    emailController.text = widget.description;
  }

  Future<Map<String, dynamic>> multipartRequestReview(
      String api, File userImage, MediaType mediaType,
      {required String title,
      required String description,
      required String blog_id,
      required String status}) async {
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
    print("${userImage.path.split('/').last}");

    final length = await userImage.length();

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

    request.files.add(http.MultipartFile(
        'images', userImage.readAsBytes().asStream(), length,
        filename: userImage.path.split('/').last, contentType: mediaType));

    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    print(res.body);

    final Map<String, dynamic> json = await jsonDecode(res.body);

    return json;
  }

  Future<Map<String, dynamic>> multipartRequestWithoutImage(String api,
      {required String title,
      required String description,
      required String blog_id,
      required String status}) async {
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

    return json;
  }

  bool buttonLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 2,
        title: Text(
          widget.forEdit ? "Edit Blog" : "Add Blog",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Blog Title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Blog title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 15),
              child: Text(
                "Blog Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Blog Description"),
                minLines: 1, // Normal textInputField will be displayed
                maxLines: 5, // When user presses enter it will adapt to it
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 15),
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                child: image == null
                    ? Padding(
                        padding: EdgeInsets.all(widget.image == "" ? 30.0 : 0),
                        child: GestureDetector(
                            onTap: () {
                              _showImagePickerOptions(context);
                            },
                            child: widget.image == ""
                                ? Text("Select Image")
                                : Image.network(
                                    widget.image,
                                    height: 120,
                                    width: 120,
                                  )),
                      )
                    : Image.file(
                        image!,
                        height: 120,
                        width: 120,
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (image == null) {
                    multipartRequestWithoutImage('${Apipath.BASH_URL}add_blog',
                        title: nameController.text,
                        description: emailController.text,
                        blog_id: widget.blog_id,
                        status: "1");
                  } else {
                    multipartRequestReview('${Apipath.BASH_URL}add_blog',
                        image!, MediaType('image', 'jpeg'),
                        title: nameController.text,
                        description: emailController.text,
                        blog_id: widget.blog_id,
                        status: "1");
                  }

                  Navigator.pop(context);
                },
                child: UtilityWidget.lodingButton(
                    buttonLogin: buttonLogin, btntext: 'Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Colors.black,
                ),
                title: Text(
                  'Choose from Gallery',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                title: Text(
                  'Take a Picture',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  //  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          ;
          // profileProvider.uploadFile(context);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
