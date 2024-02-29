import 'package:flutter/material.dart';

class FruitSelectionDialog extends StatefulWidget {
  @override
  _FruitSelectionDialogState createState() => _FruitSelectionDialogState();
}

class _FruitSelectionDialogState extends State<FruitSelectionDialog> {
  List<String> selectedFruits = [];

  final List<String> allFruits = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Fruits'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: allFruits.map((fruit) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Photographers",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedFruits.contains(fruit)) {
                        selectedFruits.remove(fruit);
                      } else {
                        selectedFruits.add(fruit);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          selectedFruits.contains(fruit)
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: selectedFruits.contains(fruit)
                              ? Colors.green
                              : Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(fruit),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Done'),
          onPressed: () {
            Navigator.of(context).pop(selectedFruits);
          },
        ),
      ],
    );
  }
}
