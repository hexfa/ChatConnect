import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/Model/notice_model.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/post_classified.dart';
import 'package:ressengaer_app/screen/profile.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'clasifieds_ads.dart';

class ClassiFieds extends StatelessWidget implements ApiStatusLogin {
  ClassiFieds({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String myId = auth.currentUser!.uid;
    return Scaffold(
        body: Consumer<ApiService>(builder: (context, value, child) {
          value.apiListener(this);
          return SafeArea(
              child: Scaffold(
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
                              return Scaffold(
                                //bottomNavigationBar: mYBottomNavigationBar(context),
                                body: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                                        child: Row(
                                          children: [
                                            Image(image: AssetImage('assets/images/newspaper.png'),color: kLightPink,width: 35,),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Classifieds',
                                              style: TextStyle(
                                                  color: kLightPink,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: (){
                                                kNavigator(context, PostClassified());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: kDarkBlue,
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                                child: const Center(
                                                    child: Text(
                                                      'Post',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 15),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
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
                                        ),
                                      ),
                                      const Divider(color: Colors.grey, thickness: 2),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: const Image(
                                          image: AssetImage('assets/images/banner.png'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: ListView(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          children: <Widget>[
                                            Menu('Electronics', FontAwesomeIcons.tv,true,context),
                                            Menu('Home & Garden', FontAwesomeIcons.couch,true,context),
                                            Menu('Automotive Vehicles', Icons.car_repair,true,context),
                                            Menu('Baby & Kids', Icons.bedroom_baby,true,context),
                                            Menu('Fashion', FontAwesomeIcons.tshirt,true,context),
                                            Menu('Pets', Icons.pets,true,context),
                                            Menu('Sports & Leisure', Icons.sports_baseball,true,context),
                                            Menu('Services', Icons.settings,true,context),
                                            Menu('Lost & Found', Icons.device_unknown_outlined,true,context),
                                            Menu('Charity', Icons.card_giftcard,true,context),
                                            Menu('Community', Icons.supervised_user_circle_outlined,false,context),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
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
    // kNavigatorBack(context);
    // kNavigator(context, Confirm());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}
Widget Menu(String text, IconData icon, bool last,context) {
  return Column(
    children: [
      RawMaterialButton(
        onPressed: () {
          kNavigator(context, SellingItem(category: text,MyIcon: icon,myPosts: false,));

        },
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(
                  icon,
                  color: kLightPink,
                )),
            // Icon(FaIcon(FontAwesomeIcons.tv),color: kLightPink,),
            const SizedBox(
              width: 20,
            ),
            Text(text,
                style: const TextStyle(
                    color: kLightPink,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      Visibility(
          visible: last,
          child: const Divider(
            color: kLightPink,
            thickness: 2,
            height: 0,
          )),
    ],
  );
}