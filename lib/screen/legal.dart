import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/Model/notice_model.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/profile.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';

class Legal extends StatelessWidget implements ApiStatusLogin {
  Legal({Key? key}) : super(key: key);
  late BuildContext context;


  @override
  Widget build(BuildContext context) {
    context.read<ApiService>().checktoken();
    this.context = context;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String myId = auth.currentUser!.uid;
    return Scaffold(
        body: Consumer<ApiService>(builder: (context, value, child) {
          value.apiListener(this);
          return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    actions: [
                      Row(
                        children: [
                          const Icon(
                            Icons.menu_book,
                            color: kMyPink,
                            size: 40,
                          ),
                          const Text(
                            'Legal',
                            style: TextStyle(
                                color: kMyPink,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mont'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          InkWell(
                            onTap: () {
                              kNavigator(context, ProFileScreen());
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 14),
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/images/wicon3.png'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //bottomNavigationBar: mYBottomNavigationBar(context),
                  body:   Container(

                  )
              ));
        }));
  }

  @override
  void accountAvailable() {}

  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(
        context, 'username or password empty', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(
        context, 'username or password incorrect', SnackBarMode.warning);
  }

  @override
  void login() {
    //Box b = Hive.box('vet');
    //b.put('vet', false);
    kNavigatorBack(context);
    kNavigator(context, Confirm());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}
