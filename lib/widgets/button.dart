import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ressengaer_app/constants.dart';

roundedButton(color, context, height, width, text,textColor,onPressed) {
  return RawMaterialButton(
    onPressed: onPressed,
    child: Container(
      height: MediaQuery.of(context).size.height*height,
      width: MediaQuery.of(context).size.width*width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white,width: 2)
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}
