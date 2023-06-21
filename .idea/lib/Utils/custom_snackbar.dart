

import 'package:flutter/material.dart';



enum SnackBarMode {
  error,warning,success
}

class ModeSnackBar {

 static show(BuildContext context,String text , SnackBarMode snackBarMode){

   Color textColor = Colors.white;
   Color backGroundColor = Colors.green;

   switch(snackBarMode){
     case SnackBarMode.error:
       backGroundColor = Colors.redAccent;
       textColor = Colors.grey;
       break;
     case SnackBarMode.warning:
       backGroundColor = Colors.yellowAccent;
       textColor = Colors.grey;
       break;
     case SnackBarMode.success:
       backGroundColor = Colors.green;
       textColor = Colors.grey;
       break;
   }

    SnackBar snackBar = SnackBar(
      content: Text(text ,style: TextStyle(fontFamily: 'Mont'),),
      backgroundColor: backGroundColor,
      duration: const Duration(seconds: 2),
      elevation: 2,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}