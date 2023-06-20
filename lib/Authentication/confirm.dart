import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../screen/country.dart';

class Confirm extends StatelessWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kMyPink,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Image.asset('assets/images/ressengerlogo2.png'),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(45),
                    child:  const Text(  'Please enter the confirmation code that was sent to the email address you have used to register ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,),
                  ),
                ),

                MyTextFiled(
                  text: '               ',
                  icon: Icons.lock_clock,
                  controller: null,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                roundedButton(
                    kMyPink, context, 0.08, 0.63, 'Confirm', Colors.white, () {
                    kNavigator(context, SelectCountry());
                },30.0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
