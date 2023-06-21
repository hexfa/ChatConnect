import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/country.dart';
import 'package:ressengaer_app/screen/legal.dart';
import 'package:ressengaer_app/screen/posts.dart';
import 'package:ressengaer_app/screen/send_notice_dialog.dart';
import 'package:ressengaer_app/screen/setting_screen.dart';

import '../widgets/my_bottom_navigation_bar.dart';

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
import 'email_dialog.dart';

class ProFileScreen extends StatelessWidget implements ApiStatusLogin {
  ProFileScreen({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String myId = auth.currentUser!.uid;
    this.context = context;
    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
                  return SafeArea(
                    child:
                    FutureBuilder<
                        DocumentSnapshot>(
                      future: users
                          .doc(myId)
                          .get(),
                      builder: (BuildContext
                      context,
                          AsyncSnapshot<
                              DocumentSnapshot>
                          snapshot) {
                        if (snapshot
                            .hasError) {
                          return const Text(
                              "Something went wrong");
                        }

                        if (snapshot
                            .hasData &&
                            !snapshot
                                .data!
                                .exists) {
                          return const Text(
                              "Document does not exist");
                        }

                        if (snapshot
                            .connectionState ==
                            ConnectionState
                                .done) {
                          Map<String,
                              dynamic> data = snapshot
                              .data!
                              .data()
                          as Map<
                              String,
                              dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: (){
                                  kNavigatorBack(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: const CircleAvatar(
                                    backgroundColor: kLightPink,
                                    child: Center(
                                      child: Text(
                                        'x',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 2,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          child: (data['image'].toString().length>3)
                                              ? Container(
                                            height:MediaQuery.of(context).size.height*0.09 ,
                                            width:MediaQuery.of(context).size.width*0.17 ,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                                                child: ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    40),
                                                child: Image
                                                    .network(
                                                data['image'],
                                                  fit: BoxFit
                                                      .fill,)),
                                              )
                                              :const CircleAvatar(
                                            child: const Icon(Icons.person),
                                            radius: 40,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: kLightPink,
                                            child: InkWell(
                                              onTap: () async {
                                                _pickImageFromGallery(
                                                  true,
                                                  context,);
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          Text(
                                            data['name'],
                                            style: const TextStyle(
                                                color: kLightPink,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Mont'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                           Text(
                                            data['apartment'],
                                            style: const TextStyle(
                                                color: kDarkBlue,
                                                fontFamily: 'Mont',
                                                fontWeight: FontWeight.w900),
                                          ),
                                           Text(
                                            'Number :${data['unit']}',
                                            style: const TextStyle(
                                                color: kDarkBlue,
                                                fontFamily: 'Mont',
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  children: [
                                    profileOptions(FontAwesomeIcons.briefcase, 'My Posts', () {
                                      kNavigator(context, Posts());
                                    }),
                                    profileOptions(Icons.settings, 'Settings', () {
                                      kNavigator(context, SettingPage());
                                    }),
                                    profileOptions(Icons.announcement_outlined, 'Legal', () {
                                      kNavigator(context, Legal());
                                    }),
                                    Container(
                                        child: (data['admin']=='true')
                                            ?Column(
                                          children: [
                                            profileOptions(Icons.add_business_sharp, 'add your apartment', () {
                                              kNavigator(context, SelectCountry(previusScreen: 'profile'));
                                            }),
                                            profileOptions(Icons.send_and_archive, 'send notice', () {
                                              showDialog<
                                                  String>(
                                                  context:
                                                  context,
                                                  builder:
                                                      (BuildContext
                                                  context) {
                                                    return Dialog(
                                                      child: SendNoticeDialog(userEmail: data['email'],uid:myId,name: data['name'], ),
                                                    );
                                                  });
                                            }),
                                          ],
                                        )
                                            :Container()
                                    ),
                                    profileOptions(FontAwesomeIcons.signOutAlt, 'Logout', () {
                                      value.signOut(context);
                                    }),
                                    Container(
                                      child: (data['admin']=='false')
                                          ?profileOptions(Icons.send, 'admin request', () {
                                        showDialog<
                                            String>(
                                            context:
                                            context,
                                            builder:
                                                (BuildContext
                                            context) {
                                              return Dialog(
                                                child: EmailDialog(userEmail: data['email'],uid:myId,name: data['name'], ),
                                              );
                                            });
                                      })
                                          :Container()
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        return const Center(
                          child: Text(
                              "loading...",style: TextStyle(color: kMyPink,fontSize: 20,fontFamily: 'Mont'),),
                        );
                      },
                    )
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

  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
  Future<void> _pickImageFromGallery(bool profile, BuildContext context,) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (profile) {
        context
            .read<ApiService>()
            .updateProfileUserImage(pickedFile.path);
      } else {
        context.read<ApiService>().setImagePath(pickedFile.path);
      }
    }
  }
}


profileOptions(icon, text,onPressed) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      InkWell(
        onTap:onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: kLightPink,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: kLightPink,
                  fontFamily: 'Mont',
                  fontWeight: FontWeight.w900,
                  fontSize: 15),
            ),
          ],
        ),
      ),
    ],
  );
}
