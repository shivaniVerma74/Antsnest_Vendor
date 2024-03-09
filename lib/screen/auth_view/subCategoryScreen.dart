import 'package:fixerking/modal/ServiceSubCategoryModel.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';

class FruitSelectionDialog extends StatefulWidget {
  final Map<String, List<SubData>> customMap;

  const FruitSelectionDialog({super.key, required this.customMap});
  @override
  _FruitSelectionDialogState createState() => _FruitSelectionDialogState();
}

class _FruitSelectionDialogState extends State<FruitSelectionDialog> {
  List<SubData> selectedSubCategories = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Sub Categories'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: widget.customMap.length,
          itemBuilder: (context, index) {
            final key = widget.customMap.keys.elementAt(index);
            final entries = widget.customMap[key]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      bool isSelected = selectedSubCategories.contains(entry);
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          onTap: () {
                            if (selectedSubCategories.contains(entry)) {
                              setState(() {
                                selectedSubCategories.remove(entry);
                              });
                              print(
                                  "removed language list ${selectedSubCategories}");
                            } else {
                              setState(() {
                                selectedSubCategories.add(entry);
                              });
                              print(
                                  "added language list ${selectedSubCategories}");
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              selectedSubCategories.contains(entry)
                                  ? Icon(Icons.check_box,
                                      size: 20, color: AppColor.PrimaryDark)
                                  : Icon(Icons.check_box_outline_blank,
                                      size: 20, color: AppColor.PrimaryDark),
                              // Container(
                              //     height: 15,
                              //     width: 15,
                              //     padding: EdgeInsets.all(2),
                              //     decoration: BoxDecoration(
                              //         color: Colors.transparent,
                              //         border: Border.all(
                              //             color: AppColor.PrimaryDark),
                              //         borderRadius:
                              //             BorderRadius.circular(0)),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           color: selectedSubCategories
                              //                   .contains(
                              //                       entry)
                              //               ? AppColor().colorPrimary()
                              //               : Colors.transparent,
                              //           borderRadius:
                              //               BorderRadius.circular(2)),
                              //     ),
                              //   ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(entry.cName!),
                            ],
                          ),
                        ),
                      );
                    })
                // return CheckboxListTile(
                //     title: Text(entry.cName!),
                //     // subtitle: Text('ID: ${entry.id}'),
                //     value: isSelected,
                //     onChanged: (bool? value) {
                //       setState(() {
                //         if (value != null && value) {
                //           selectedSubCategories.add(entry);
                //         } else {
                //           selectedSubCategories.remove(entry);
                //         }
                //       });
                //     });
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
