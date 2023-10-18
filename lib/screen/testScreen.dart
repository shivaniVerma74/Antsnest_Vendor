import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {

  @override
  State < TestScreen > createState() => _TestScreenState();
}

class _TestScreenState extends State < TestScreen > {
  Color caughtColor = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeeksforGeeks'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: < Widget > [
            // Draggable Widget
            Draggable(
                data: Colors.orangeAccent,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.orangeAccent,
                  child: const Center(
                    child: Text('box'),
                  ),
                ),
                // calling onDraggableCanceled property

                onDraggableCanceled: (velocity, offset) {},
                feedback: Container(
                  width: 150,
                  height: 150,
                  color: Colors.orangeAccent.withOpacity(0.5),
                  child: const Center(
                    child: Text(
                      'Box...',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                )
            ),
            // building Drag Target Widget
            DragTarget(

                onAccept: (Color color) {
                  caughtColor = color;
                }, builder: (BuildContext context, List <dynamic> accepted, List <dynamic> rejected,){
                  print("checking now here ${accepted} and ${rejected} and ${caughtColor} ");
              return Container(
                width: 200,
                height: 200,
                color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                child: const Center(
                  child: Text('Drag here'),
                ),
              );
            }
            )
          ],
        ),
      ),
    );
  }
}