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
import '../widgets/post_form.dart';

class AddBuilding extends StatelessWidget implements ApiStatusLogin {
  AddBuilding({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(body:
        SafeArea(
            child:
        Consumer<ApiService>(
            builder: (context, value, child) {
      value.apiListener(this);
      return SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              postForm(context, 'your name', "please enter your name", 0.9,
                  0.08, value.fullNameController),
              postForm(context, 'building name', "please enter building name",
                  0.9, 0.08, value.buildingNameController),
              postForm(
                  context,
                  'Address',
                  " please enter your building address",
                  0.9,
                  0.2,
                  value.addressController),
              const SizedBox(
                height: 10,
              ),
              roundedButton(kMyPink, context, 0.08, 0.63, 'Add', Colors.white,
                  () {
                    value.setApartment(value.buildingNameController.text);
                    value.setApartmentId(value.myUser);
                    value.updateApartment(context);
                    value.setApartment(value.buildingNameController.text);

                value.addMyBuilding(context);



              }, 30.0),
            ],
          ),
        ),
      ));
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

    kNavigator(context, Notices());
    ModeSnackBar.show(
        context, 'building added', SnackBarMode.success);

  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}
