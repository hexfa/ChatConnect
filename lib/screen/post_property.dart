import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/profile.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../Utils/drop_downs.dart';
import '../provider/ApiService.dart';
import '../widgets/post_form.dart';
import 'dart:io';

class PostProperty extends StatelessWidget implements ApiStatusLogin {


  PostProperty() ;
  late BuildContext context;
  List multiPickedImage = [];


  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.wifi_protected_setup,
                      color: kMyPink,
                      size: 40,
                    ),
                    onPressed: () {
                      kNavigatorBack(context);
                    },
                  ),
                  const Text(
                    'Post Property',
                    style: TextStyle(
                        color: kMyPink,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mont'),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
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
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Consumer<ApiService>(builder: (context, value, child) {
              value.apiListener(this);
              return SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        // -------------------------we should add controller-----------------------------------
                        children: [
                          PropertyCtegory(
                            onChanged: (String? val) {
                              value.setPropertyType(val.toString());
                            },
                            myHint: '',
                          ),
                          postForm(
                              context,
                              'Property Post title',
                              "Type your Classified title(required)",
                              0.9,
                              0.05,
                              value.postPropertyTitleController),
                          postForm(context, 'Price', "Enter the price in R (optional)",
                              0.9, 0.05, value.postPropertyPriceController),
                          postForm(
                              context,
                              'Description',
                              " Type a detailed description between 30 to\n 3000 characters(required)",
                              0.9,
                              0.2,
                              value.postPropertyDescriptionController),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                'Pictures',
                                style: TextStyle(
                                    color: kMyPink,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Mont'),
                              ),
                              Text(
                                '(optional)',
                                style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Mont'),
                              ),
                              const Spacer()
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                  onTap: () {
                                    _pickImageFromGallery2(
                                      context,
                                    );
                                  },
                                  child: (value.imagePath.isNotEmpty)
                                      ? Image.file(File(value.imagePath))
                                      : Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.grey.shade300,
                                    size: 50,
                                  )),
                              const Spacer()
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 45,
                              ),
                              Text(
                                'By submitting your classified your are agreeing to\nRessenger\s Terms & Conditions',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Mont'),
                              ),
                              Spacer()
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          roundedButton(
                              kMyPink, context, 0.08, 0.63, 'Submit', Colors.white, () {
                            // if (value.postClassifiedTitleController.text.isNotEmpty &&
                            //     value.postClassifiedDescriptionController.text.isEmpty &&
                            //      value.classifiedType.isNotEmpty
                            // ){
                            value.submitPropertyPost(context);
                            // }
                            // else{
                            //   print(value.postClassifiedTitleController.text);
                            //   print(value.postClassifiedDescriptionController.text);
                            //   print( value.classifiedType);
                            //   ModeSnackBar.show(context, 'fill all required part', SnackBarMode.error);
                            // }

                            // kNavigator(context, Confirm());
                          }, 30.0),
                        ],
                      ),
                    ),
                  ));
            })));
  }


  Future<List<XFile>> _pickImageFromGallery2(BuildContext context) async {
    multiPickedImage = [];
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        multiPickedImage.add(images[i].path);
      }
      print(multiPickedImage);
      context.read<ApiService>().setListImagePathproperty(multiPickedImage);
      return images;
    }
    print(images?.length);
    return [];
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
