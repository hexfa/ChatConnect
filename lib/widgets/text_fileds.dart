import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';

class MyTextFiled extends StatefulWidget {
  final controller;
  var text;
  var icon;

  var passkey;

  var validateController;

  var vKey;

  var pass1;

  MyTextFiled({
    required this.controller,
    required this.text,
    required this.icon,
    required this.vKey,
    this.pass1 = '-1',
    this.passkey,
    required this.validateController,

  });

  @override
  _MyTextFiledState createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Container(
        width: 290,
        padding: EdgeInsets.all(10.0),
        child: TextField(
            obscureText: (widget.passkey == 1) ? true : false,
            controller: widget.controller,
            autocorrect: true,
            decoration: InputDecoration(
              errorText: validate(
                  widget.validateController, widget.vKey, widget.pass1),
              errorStyle:
                  TextStyle(color: Colors.purple.shade900, fontFamily: 'Mont'),
              prefixIcon: Icon(
                widget.icon,
                color: Colors.white,
                size: 40,
              ),
              hintText: widget.text,
              hintStyle:
                  const TextStyle(color: Colors.white, fontFamily: 'Mont'),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
            )));
  }

  String validate(String value, vKey, pass1) {
    setState(() {});
    if (vKey == 'name') {
      if ((value.isEmpty)) {
        return "* ";
      }
    }
    if (vKey == 'email') {
      if ((value.isEmpty)) {
        return "*";
      } else if (!RegExp(
              r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
          .hasMatch(value)) {
        return 'Please enter a valid Email';
      }
    }
    if (vKey == 'pass') {
      if ((value.isEmpty)) {
        return "* ";
      } else if (value.length < 6) {
        return 'your password is weak';
      }
    }
    if (vKey == 'pass2') {
      if ((value.isEmpty)) {
        return "*";
      }
      if (value != pass1) {
        return 'dosen\'t  match password';
      }
    }
    if (vKey == 'loginEmail') {
      if ((value.isEmpty)) {
        return "*";
      } else if (!RegExp(
              r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
          .hasMatch(value)) {
        return 'your email is wrong';
      }
    }
    if (vKey == 'loginPass') {
      if ((value.isEmpty)) {
        return "* ";
      } else if (value.length < 6) {
        return 'your password is wrong';
      }
    }

    return '';
  }
}
