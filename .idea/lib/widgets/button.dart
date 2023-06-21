import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ressengaer_app/constants.dart';

roundedButton(
    color, context, height, width, text, textColor, onPressed, fontsize) {
  return RawMaterialButton(
    onPressed: onPressed,
    child: Container(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white, width: 2)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Mont',
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}

socialMediaButton(context, image, onPressed) {
  return Row(
    children: [
      InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      )
    ],
  );
}
