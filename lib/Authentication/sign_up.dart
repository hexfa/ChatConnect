
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Utils/custom_snackbar.dart';
import 'package:ressengaer_app/provider/ApiService.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';
import '../constants.dart';
import 'confirm.dart';
import 'login.dart';

class SignUp extends StatelessWidget implements ApiStatusLogin {
  SignUp({Key? key}) : super(key: key);
  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text,style: TextStyle(fontFamily: 'Mont'),),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

//------------------------------------------------------------------------//

    return Scaffold(
      body: SafeArea(
    child: Consumer<ApiService>(
    builder: (context, value, child) {
      value.apiListener(this);
      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: kMyPink,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Image.asset('assets/images/ressengerlogo2.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                MyTextFiled(
                  text: '               full name',
                  icon: Icons.supervisor_account_sharp,
                  controller: value.fullNameController,
                  validateController: value.fullNameController.text,
                  vKey: 'name',

                ),
                MyTextFiled(
                  text: '            email address',
                  icon: Icons.email,
                  controller: value.emailController,
                  validateController: value.emailController.text,
                  vKey: 'email',
                ),
                MyTextFiled(
                  text: '                password',
                  icon: Icons.lock,
                  controller: value.password1Controller,
                  passkey: 1,
                  validateController: value.password1Controller.text,
                  vKey: 'pass',
                ),

                MyTextFiled(
                  text: '           confirm Password',
                  icon: Icons.lock,
                  controller: value.password2Controller,
                  passkey: 1,
                  validateController: value.password2Controller.text,
                  vKey: 'pass2',
                  pass1: value.password1Controller.text,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Text(
                  'By signing up you are agreeing to \n Reesenger\'s Terms & Conditions ',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontFamily: 'Mont',
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.023,
                ),
                roundedButton(
                    kMyPink, context, 0.08, 0.63, 'Sign Up', Colors.white, () {
                  Provider.of<ApiService>(
                      context,
                      listen: false).notifyListeners();
                      print(value.password2Controller.text);
                    value.signUpUser();
                  // kNavigator(context, Confirm());
                },30.0),



                Center(
                  child: Container(
                    margin: EdgeInsets.all(45),
                    child:  TextButton(onPressed: () {
                      kNavigator(context, Login());
                    },
                      child: const Text(  'Already have an account ?\n Login',
                        style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Mont'),
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
      );
    }))
    );
  }

  @override
  void accountAvailable() {
    ModeSnackBar.show(
        context, 'you signed in before with this email', SnackBarMode.error);
  }

  @override
  void error() {
    ModeSnackBar.show(context, 'something get wrong', SnackBarMode.error);
  }

  @override
  void inputEmpty() {

  }

  @override
  void inputWrong() {
    ModeSnackBar.show(
        context,
        'username or password wrong',
        SnackBarMode.warning);
  }


  //bool push = false;
  @override
  void login() {
    kNavigatorBack(context);
    kNavigator(context,  Confirm());

  }

  @override
  void passwordWeak() {

    ModeSnackBar.show(context, 'password is weak',
        SnackBarMode.warning);
  }


}



