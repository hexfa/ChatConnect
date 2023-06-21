import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFiled extends StatefulWidget {
  final controller;
  var text;
  var icon;

  var passkey;

   MyTextFiled({
     required this.controller,
     required this.text,
     required this.icon,
     this.passkey,
   }) ;

  @override
  _MyTextFiledState createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 290,
        padding: EdgeInsets.all(10.0),
        child:  TextField(
            obscureText: (widget.passkey == 1) ? true : false,
          controller: widget.controller,
            autocorrect: true,
            decoration:  InputDecoration(

              prefixIcon: Icon(widget.icon,color: Colors.white,size: 40,),
              hintText: widget.text,
              hintStyle: const TextStyle(color: Colors.white,fontFamily: 'Mont'),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            )));
  }
}
