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

class Notices extends StatelessWidget implements ApiStatusLogin {
  Notices({Key? key}) : super(key: key);
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
                  Icons.notifications,
                  color: kMyPink,
                  size: 40,
                ),
                const Text(
                  'Notices',
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
        body:    FutureBuilder<
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
              return StreamBuilder<QuerySnapshot>(
                stream: context.read<ApiService>().getAllNotice(data['apartmentId']),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView(
                        children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                          // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          //value.setGroupApartment(data['apartmentId']);
                          NoticeData noticeData = NoticeData.fromJson(
                              document.data()! as Map<String, dynamic>);

                          return Column(
                            children: [
                              (noticeData.description.length>1)
                                  ? Column(
                                children: [
                                 // Text(data['apartmentId']),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(noticeData.title,
                                                style: const TextStyle(
                                                    color: kLightPink,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Mont')),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(noticeData.description,
                                                style: const TextStyle(
                                                    color: kLightPink,
                                                    fontSize: 14,
                                                    fontFamily: 'Mont')),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                          const EdgeInsets.symmetric(vertical: 10),
                                          child: Row(
                                            children: [
                                              Text(noticeData.time,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: kLightPink,
                                                      fontSize: 12,
                                                      fontFamily: 'Mont')),
                                            ],
                                          ),
                                        ),
                                        const Divider(color: Colors.grey, thickness: 2),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                                  :Container(),

                            ],
                          );

                          //-------------------------------------------------------------------------//
                        }).toList(),
                      ),
                    );
                    //;
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Text(snapshot.error.toString()),
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                },
              );
            }

            return const Center(
              child: Text(
                "loading...",style: TextStyle(color: kMyPink,fontSize: 20,fontFamily: 'Mont'),),
            );
          },
        )
      ));
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
