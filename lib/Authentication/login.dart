import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';

class Login extends StatelessWidget implements ApiStatusLogin {
   Login({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
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
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Image.asset('assets/images/ressengerlogo2.png'),
                              ),

                              MyTextFiled(
                                text: '            email address',
                                icon: Icons.email,
                                controller: value.emailController,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              MyTextFiled(
                                text: '               Password',
                                icon: Icons.lock,
                                controller: value.password1Controller,
                                passkey: 1,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              roundedButton(
                                  kMyPink, context, 0.08, 0.63, 'Login', Colors.white, () {
                                value.signIn();
                              }),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              const Text(
                                'Forget Password ?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.all(45),
                                  child:  TextButton(onPressed: () {
                                    kNavigator(context, SignUp());
                                  },
                                    child: const Text(  'Don\'t have an account ?\n Register',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                      textAlign: TextAlign.center,),

                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }))
    );
  }

  @override
  void accountAvailable() {

  }

  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(context, 'username or password empty', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(context, 'username or password incorrect', SnackBarMode.warning);
  }

  @override
  void login(){
    //Box b = Hive.box('vet');
    //b.put('vet', false);
    kNavigatorBack(context);
    kNavigator(context,  const Confirm());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}
