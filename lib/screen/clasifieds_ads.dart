import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Model/ad.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/post_classified.dart';
import 'package:ressengaer_app/screen/profile.dart';
import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'detailclassifieds.dart';

class SellingItem extends StatelessWidget implements ApiStatusLogin {
  var category;

  var MyIcon;

  var myPosts;

  SellingItem({required this.category,required this.MyIcon,required this.myPosts}) ;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore fs = FirebaseFirestore.instance;
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
                            'Classifieds',
                            style: TextStyle(
                                color: kMyPink,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mont'),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              // showDialog<
                              //     String>(
                              //     context:
                              //     context,
                              //     builder:
                              //         (BuildContext
                              //     context) {
                              //       return Dialog(
                              //         child: ChatDialog(),
                              //       );
                              //     });
                              kNavigator(context, PostClassified());
                            },
                            child: Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: 50,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: kDarkBlue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(child: Text('Post',style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Mont'
                                ),))),
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
                          stream: context.read<ApiService>().getAllClassifiedAds(data['apartmentId'],category),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                            if (snapshot.hasData) {
                              return  Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    height: MediaQuery.of(context).size.height * 0.065,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // IconButton(onPressed: (){}, icon:  FaIcon(
                                      //   MyIcon,
                                      //   size: 40,
                                      //   color: kLightPink,
                                      // )),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        category,
                                        style: const TextStyle(
                                            color: kMyPink,
                                            fontFamily: 'Mont',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(right: 45, left: 14),
                                      child: const Divider(
                                        color: kMyPink,
                                        height: 2,
                                        thickness: 2,
                                        endIndent: 0.1,
                                      )),
                                  (myPosts==true)
                                  ?Expanded(
                                    child: ListView(
                                      children:
                                      snapshot.data!.docs.map((DocumentSnapshot document) {
                                        // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                        adData AdData = adData.fromJson(
                                            document.data()! as Map<String, dynamic>);

                                        return
                                          Column(
                                            children: [
                                              (AdData.description.length>1 && AdData.sender==value.myUser)
                                                  ?Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Column(
                                                children: [
                                                          InkWell(
                                                            onTap: () {
                                                              kNavigator(context, DetailClassifieds(category: category, documentId: document.id,));
                                                            },
                                                            child: Container(
                                                              color: kMyPink,
                                                              margin:
                                                              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width * 0.85,
                                                                height: MediaQuery.of(context).size.height * 0.14,
                                                                margin:
                                                                const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width * 0.19,
                                                                        height: MediaQuery.of(context).size.height * 0.14,
                                                                        child:(AdData.image[0].length>1)

                                                                            ?Image.network(AdData.image[0])
                                                                            :Image.asset(
                                                                          'assets/images/wicon3.png',
                                                                          fit: BoxFit.fill,
                                                                        )
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.6,
                                                                      margin: const EdgeInsets.symmetric(
                                                                          horizontal: 10, vertical: 3),
                                                                      child: Column(
                                                                        children: [
                                                                          Row(
                                                                            children:  [
                                                                              Text( AdData.title,
                                                                                  style: const TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontSize: 18,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontFamily: 'Mont')),
                                                                              Spacer()
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width *
                                                                                    0.6,
                                                                                height:
                                                                                MediaQuery.of(context).size.height *
                                                                                    0.08,
                                                                                child:  Text(
                                                                                    AdData.description,
                                                                                    textAlign: TextAlign.start,
                                                                                    style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 12,
                                                                                        fontFamily: 'Mont')),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                  AdData.time,
                                                                                  style: const TextStyle(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                      fontSize: 12,
                                                                                      fontFamily: 'Mont')),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const Divider(color: kLightPink, thickness: 2),
                                                ],
                                              ),
                                                          InkWell(
                                                            onTap: (){

                                                              value.setClassifiedType(category);
                                                              fs.collection('apartment')
                                                                  .doc(value.groupApartment)
                                                                  .collection('classifieds')
                                                                  .doc(value.classifiedType)
                                                                  .collection('ads').doc(document.id).delete();
                                                            },
                                                              child: Icon(Icons.close_outlined,color: Colors.red,))
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                  :Container()
                                            ],
                                          );

                                        //-------------------------------------------------------------------------//
                                      }).toList(),
                                    ),
                                  )
                                      :Expanded(
                                    child: ListView(
                                      children:
                                      snapshot.data!.docs.map((DocumentSnapshot document) {
                                        // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                        adData AdData = adData.fromJson(
                                            document.data()! as Map<String, dynamic>);

                                        return
                                          Column(
                                            children: [
                                              (AdData.description.length>1)
                                                  ?Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {

                                                      kNavigator(context,  DetailClassifieds(category: category, documentId: document.id,));
                                                    },
                                                    child: Container(
                                                      color: kMyPink,
                                                      margin:
                                                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.85,
                                                        height: MediaQuery.of(context).size.height * 0.14,
                                                        margin:
                                                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(context).size.width * 0.19,
                                                                height: MediaQuery.of(context).size.height * 0.14,
                                                                child:(AdData.image.length>1)

                                                                    ?Image.network(AdData.image[0])
                                                                    :Image.asset(
                                                                  'assets/images/wicon3.png',
                                                                  fit: BoxFit.fill,
                                                                )
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width * 0.6,
                                                              margin: const EdgeInsets.symmetric(
                                                                  horizontal: 10, vertical: 3),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children:  [
                                                                      Text( AdData.title,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'Mont')),
                                                                      Spacer()
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.6,
                                                                        height:
                                                                        MediaQuery.of(context).size.height *
                                                                            0.08,
                                                                        child:  Text(
                                                                            AdData.description,
                                                                            textAlign: TextAlign.start,
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12,
                                                                                fontFamily: 'Mont')),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          AdData.time,
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                              fontFamily: 'Mont')),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(color: kLightPink, thickness: 2),
                                                ],
                                              )
                                                  :Container()
                                            ],
                                          );

                                        //-------------------------------------------------------------------------//
                                      }).toList(),
                                    ),
                                  )
                                ],
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
