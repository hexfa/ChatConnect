import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/widgets/button.dart';

class LoginOrSignup extends StatelessWidget {
  const LoginOrSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: kMyPink,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset('assets/images/wicon.png'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              roundedButton(
                  Colors.white, context, 0.08, 0.63, 'Sign Up', kMyPink, ()
              {
                kNavigator(context, SignUp());
              },30.0
                  ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              const Text(
                'Already have a Ressenger account?',style: TextStyle(
                fontFamily: 'Mont',
                color: Colors.white,
              ),),
              roundedButton(
                  kMyPink, context, 0.08, 0.63, 'Log In', Colors.white, ()
              {
                    kNavigator(context, Login());
              },30.0
              ),
              Center(
                child: Container(
                       margin: EdgeInsets.all(45),
                  child: const Text(
                    'By using this app you agree to Ressenger\'s Terms of Use and Privacy Policy' ,style: TextStyle(
                    fontFamily: 'Mont',
                    color: Colors.white,

                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),

            ],
          ),
        ),
      ),
    );
  }
}
