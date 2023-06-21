import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/country.dart';
import 'package:ressengaer_app/screen/profile.dart';
import 'package:ressengaer_app/screen/searchapartment.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'chat_dialog.dart';

class ServicesItem extends StatelessWidget implements ApiStatusLogin {
  var category;

  ServicesItem({required this.category});

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<ApiService>().getAllServiceAds(category),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //print(snapshot.data!.docs.length);
            if (snapshot.hasError) {
              print('hasError');
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(),
              );
            }

            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.1),
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'No Contact...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                );
              }
              // return Text('data');

              return SafeArea(
                  child: Consumer<ApiService>(builder: (context, value, child) {
                value.apiListener(this);
                return SafeArea(
                    child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    actions: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              kNavigatorBack(context);
                            },
                            child: const Icon(
                              Icons.wifi_protected_setup,
                              color: kMyPink,
                              size: 40,
                            ),
                          ),
                          const Text(
                            'Services   ',
                            style: TextStyle(
                                color: kMyPink,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mont'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
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
                      )
                    ],
                  ),
                 // bottomNavigationBar: mYBottomNavigationBar(context),
                  body: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.065,
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 2,
                        thickness: 2,
                        endIndent: 0.1,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: 45, left: 14, top: 10),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Text(
                              category,
                              style: const TextStyle(
                                  color: kMyPink,
                                  fontFamily: 'Mont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 2,
                        thickness: 2,
                        endIndent: 0.1,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 3),
                                  child: (snapshot.data!.docs[index]
                                              .get('category').toString().length>2)
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.14,
                                                      child: (snapshot.data!
                                                                  .docs[index]
                                                                  .get('image')
                                                                  .toString()
                                                                  .length >
                                                              2)
                                                          ? Image.network(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get('image'),
                                                              fit: BoxFit.fill,
                                                            )
                                                          : Image.asset(
                                                              'assets/images/wicon3.png',
                                                              fit: BoxFit.fill,
                                                            )),
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children:  [
                                                        Text( snapshot.data!
                                                            .docs[index]
                                                            .get('title'),
                                                            style: const TextStyle(
                                                                color: kMyPink,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Mont')),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Text('Description',
                                                            style: TextStyle(
                                                                color: kMyPink,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Mont')),
                                                        Spacer()
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          child:  Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get('description'),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  color:
                                                                      kMyPink,
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Mont')),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children:  [
                                                        const Text('Telephone : ',
                                                            style: TextStyle(
                                                                color: kMyPink,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        Text( snapshot.data!
                                                            .docs[index]
                                                            .get('telephone'),
                                                            style: const TextStyle(
                                                                color: kMyPink,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                    Row(
                                                      children:  [
                                                        const Text('Mobile : ',
                                                            style: TextStyle(
                                                                color: kMyPink,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        Text(snapshot.data!
                                                            .docs[index]
                                                            .get('mobile'),
                                                            style: const TextStyle(
                                                                color: kMyPink,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text('Email : ',
                                                            style: TextStyle(
                                                                color: kMyPink,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        Text(snapshot.data!
                                                            .docs[index]
                                                            .get('email'),
                                                            style: const TextStyle(
                                                                color: kMyPink,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                    Row(
                                                      children:  [
                                                        const Text('Website : ',
                                                            style: TextStyle(
                                                                color: kMyPink,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        Text(snapshot.data!
                                                            .docs[index]
                                                            .get('website'),
                                                            style: const TextStyle(
                                                                color: kMyPink,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Mont')),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        socialMediaButton(
                                                            context,
                                                            'assets/images/instegram.png',
                                                            () async{
                                                              final url=snapshot.data!
                                                                  .docs[index]
                                                                  .get('instagram');
                                                              if(await canLaunch(url) ){
                                                              await launch(url);
                                                              }
                                                            }),
                                                        socialMediaButton(
                                                            context,
                                                            'assets/images/facebook.png',
                                                                () async{
                                                              final url=snapshot.data!
                                                                  .docs[index]
                                                                  .get('facebook');
                                                              if(await canLaunch(url) ){
                                                                await launch(url);
                                                              }
                                                            }),
                                                        socialMediaButton(
                                                            context,
                                                            'assets/images/twitter.png',
                                                                () async{
                                                              final url=snapshot.data!
                                                                  .docs[index]
                                                                  .get('twitter');
                                                              if(await canLaunch(url) ){
                                                                await launch(url);
                                                              }
                                                            }),
                                                        socialMediaButton(
                                                            context,
                                                            'assets/images/linkdin.png',
                                                                () async{
                                                              final url=snapshot.data!
                                                                  .docs[index]
                                                                  .get('linkedin');
                                                              if(await canLaunch(url) ){
                                                                await launch(url);
                                                              }
                                                            }),
                                                        const Spacer()
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'there is no ad in this categoy',
                                            style: TextStyle(
                                                color: kMyPink,
                                                fontFamily: 'Mont'),
                                          ),
                                        )),
                            );
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      // ElevatedButton(onPressed: (){
                      //   kNavigator(context, SelectCountry(previusScreen: 'confirm'));
                      //
                      //  // kNavigator(context, SearchApartment(previusScreen: '',));
                      // },child: const Text('hi'),)
                    ],
                  ),
                ));
              }));
            }

            return Center(
              child: Container(),
            );
          }),
    );
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
