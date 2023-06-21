import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';
import 'dart:io';
import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';

class SendImageDialog extends StatelessWidget implements ApiStatusLogin {
  SendImageDialog();

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
        child: Consumer<ApiService>(builder: (context, value, child) {
      value.apiListener(this);
      return SafeArea(
          child: Container(
        child: Container(
          color: kMyPink,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: InkWell(
                onTap: () {
                  _pickImageFromGallery(
                    context,
                  );
                },
                child: (value.imagePath.isNotEmpty)
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            child: Row(
                              children: [
                                const Text(
                                  'Send Image',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mont'),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: (){
                                    value.sendMessage(context);
                                    kNavigatorBack(context);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.04,
                                    width: MediaQuery.of(context).size.width*0.25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const Center(child: Text('Send',style: TextStyle(
                                        color: kMyPink,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Mont'))),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Image.file(File(value.imagePath)),
                        ],
                      )
                    : Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.grey.shade300,
                        size: 50,
                      )),
          ),
        ),
      ));
    }));
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<ApiService>().setImagePath(pickedFile.path);
    }
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
