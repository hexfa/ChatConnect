import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ClassifiedCtegory extends StatefulWidget {
  ClassifiedCtegory({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Select (required)',
    'Electronics',
    'Home & Garden',
    'Automotive Vehicles',
    'Baby & Kids',
    'Fashion',
    'Pets',
    'Sports & Leisure',
    'Services',
    'Lost & Found',
    'Charity',
    'Community',

  ];
  String currentSelectedValue = 'Select (required)';

  @override
  _ClassifiedCtegoryState createState() => _ClassifiedCtegoryState();
}
class _ClassifiedCtegoryState extends State<ClassifiedCtegory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(width: 30,),
            Text(
    'Select category of classified',
              style: TextStyle(
                  color: kMyPink,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mont'),
            ),
          ],
        ),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return Container(
              width:MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
                //left: 20,
              ),
              child: DropdownButtonHideUnderline(
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 15),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(
                      widget.myHint,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    dropdownColor: Colors.white,
                    value: widget.currentSelectedValue,
                    //iconEnabledColor: Colors.red,
                    icon: Container(
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    iconSize: 22,
                    elevation: 16,

                    style:  TextStyle(fontSize: 15,color: Colors.grey.shade400),

                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.currentSelectedValue = newValue!;
                        widget.onChanged!.call(widget.currentSelectedValue);
                      });
                    },
                    items: ClassifiedCtegory.deviceTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}


//-----------------------------------------------------------------------
class PropertyCtegory extends StatefulWidget {
  PropertyCtegory({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Select (required)',
     'sale',
    'rent'

  ];
  String currentSelectedValue = 'Select (required)';

  @override
  _PropertyCtegoryState createState() => _PropertyCtegoryState();
}
class _PropertyCtegoryState extends State<PropertyCtegory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(width: 30,),
            Text(
              'Select rental or for sale',
              style: TextStyle(
                  color: kMyPink,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mont'),
            ),
          ],
        ),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return Container(
              width:MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.05,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
                //left: 20,
              ),
              child: DropdownButtonHideUnderline(
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 15),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(
                      widget.myHint,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    dropdownColor: Colors.white,
                    value: widget.currentSelectedValue,
                    //iconEnabledColor: Colors.red,
                    icon: Container(
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    iconSize: 22,
                    elevation: 16,

                    style:  TextStyle(fontSize: 15,color: Colors.grey.shade400),

                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.currentSelectedValue = newValue!;
                        widget.onChanged!.call(widget.currentSelectedValue);
                      });
                    },
                    items: PropertyCtegory.deviceTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}