import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class ResidenceConfirm extends StatelessWidget implements ApiStatusLogin {
  ResidenceConfirm({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String myId = auth.currentUser!.uid;
    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
                  return SafeArea(child:Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child:    FutureBuilder<
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
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Image(
                                  image: AssetImage('assets/images/screen6.fw.png'),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Residence Confirm',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: kLightPink,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                RichText(
                                  text:  TextSpan(
                                    // Note: Styles for TextSpans must be explicitly defined.
                                    // Child text spans will inherit styles from parent
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: kLightPink,
                                    ),
                                    children: <TextSpan>[
                                      const TextSpan(text: 'I, '),
                                      TextSpan(
                                          text: data['name'] ,
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: ' with email address '),
                                      TextSpan(
                                          text: data['email'],
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: ' confirm that iam a resident of '),
                                      TextSpan(
                                          text: data['apartment'],
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: ' and my \nunit / house number is: '),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                 TextField(
                                   controller: value.unitConfirmController,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.house,
                                      color: kLightPink,
                                    ),
                                    hintText: 'enter unit / house number',
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kLightPink),),
                                    hintStyle: TextStyle(color: kLightPink,fontFamily: 'Mont'),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kLightPink),),
                                  ),
                                ),
                                const SizedBox(height: 50,),
                                RawMaterialButton(
                                  onPressed: (){
                                    context.read<ApiService>().updateUnit(
                                      context,
                                    );
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: kLightPink,
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: const Center(child: const Text('Confirm',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return const Center(
                          child: Text(
                            "loading...",style: TextStyle(color: kMyPink,fontSize: 20,fontFamily: 'Mont'),),
                        );
                      },
                    )
                  ));
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
    kNavigator(context, Notices());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}
