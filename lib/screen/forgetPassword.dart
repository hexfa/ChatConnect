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

class ForgetPassword extends StatelessWidget implements ApiStatusLogin {
  ForgetPassword({Key? key}) : super(key: key);
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
                        Icons.lock_reset_outlined,
                        color: kMyPink,
                        size: 40,
                      ),
                      const Text(
                        'Reset',
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
              body: Center(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please type something';
                          } else {
                            return null;
                          }
                        },
                        // inputFormatters: [
                        //   LengthLimitingTextInputFormatter(50),
                        // ],

                        controller: value.emailNameController,
                        decoration: const InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kMyPink, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kMyPink, width: 3),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3),
                          ),
                          labelText: 'Enter your Email',
                          labelStyle:
                              TextStyle(color: kMyPink, fontSize: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: '',
                          hintStyle: TextStyle(
                              color: kMyPink,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      onPressed: ()  {
                        //kNavigator(context, Navigator());
                        value.auth.sendPasswordResetEmail(email: value.emailNameController.text).whenComplete((){
                          ModeSnackBar.show(context, 'Check your email', SnackBarMode.success);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kMyPink,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: const Center(
                            child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),
                        )),

                      ),
                    )
                  ],
                ),
              )));
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
