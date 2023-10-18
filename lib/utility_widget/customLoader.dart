import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {

  final String? text;
  CustomLoader({this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${text}"),
          SizedBox(height: 8,),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
