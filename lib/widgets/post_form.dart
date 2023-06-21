import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

postForm(context,title,hintText,width,height,controller){
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      children: [
        Row(
          children:  [
            SizedBox(width: 30,),
            Text(
              title,
              style: const TextStyle(
                  color: kMyPink,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mont'),
            ),
            Spacer()
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width:MediaQuery.of(context).size.width*width,
          height: MediaQuery.of(context).size.height*height,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11,  right: 15),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 15,color: Colors.grey.shade400)),
          ),
        ),
      ],
    ),
  );
}