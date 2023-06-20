import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/notices.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../screen/country.dart';

class Confirm extends StatelessWidget implements ApiStatusLogin {
  Confirm({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(body:
        SafeArea(child: Consumer<ApiService>(builder: (context, value, child) {
      bool isEmailVerified = false;
      value.apiListener(this);
      return SafeArea(
        child: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return VerifyEmailPage();
              } else {
                return SelectCountry(previusScreen: 'confirm',);
              }
            },
          ),
        ),
      );
    })));
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
    kNavigator(context, SelectCountry(previusScreen: 'confirm'));
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  String email = '';

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email!;
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => chekEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future chekEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? SelectCountry(previusScreen: 'confirm',)
      : Container(
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
                    child: const Text(
                      'Please click on the link that was emailed to you ',
                      style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Mont'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                Text(email,   style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Mont'),),
                // MyTextFiled(
                //   text: '               ',
                //   icon: Icons.lock_clock,
                //   controller: null,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                roundedButton(
                    kMyPink, context, 0.08, 0.63, 'resend email', Colors.white,
                    () {
                      sendVerificationEmail();
                  //value.verifiedEmail();
                  // kNavigator(context, SelectCountry());
                }, 30.0),
              ],
            ),
          ),
        );
}
