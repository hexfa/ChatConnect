import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Model/ad.dart';
import 'package:ressengaer_app/Model/property_model.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/detailproperty.dart';
import 'package:ressengaer_app/screen/post_classified.dart';
import 'package:ressengaer_app/screen/post_property.dart';
import 'package:ressengaer_app/screen/profile.dart';
import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'detailclassifieds.dart';

class PropertyItems extends StatelessWidget implements ApiStatusLogin {
  PropertyItems();

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore fs = FirebaseFirestore.instance;
    String myId = auth.currentUser!.uid;
    return MaterialApp(
      home: Scaffold(
          body: Consumer<ApiService>(builder: (context, value, child) {
        value.apiListener(this);
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  actions: [
                    Row(
                      children: [
                        Image(image: AssetImage('assets/images/house.png'),color: kLightPink,width: 35,),
                        SizedBox(
                          width: 15,
                        ),
                        const Text(
                          'Property',
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

                            kNavigator(context, PostProperty());
                          },
                          child: Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 50,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: kDarkBlue,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                'Post',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'Mont'),
                              ))),
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
                //bottomNavigationBar: mYBottomNavigationBar(context),
                body: FutureBuilder<DocumentSnapshot>(
                  future: users.doc(myId).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return StreamBuilder<QuerySnapshot>(
                        stream: context
                            .read<ApiService>()
                            .getAllPropertyItems(data['apartmentId']),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 10),
                                    color: Colors.grey,
                                    width:
                                        MediaQuery.of(context).size.width * 0.85,
                                    height:
                                        MediaQuery.of(context).size.height * 0.25,
                                  ),

                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.5,
                                    child: MaterialApp(
                                      debugShowCheckedModeBanner: false,
                                      home: DefaultTabController(

                                        length: 2,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            foregroundColor: kMyPink,
                                            backgroundColor: Colors.white,
                                            toolbarHeight: 0,

                                            // title: Text('hs'),
                                            bottom: const TabBar(
                                              tabs: [
                                                Tab(
                                                    child: Text(
                                                      'For sale',
                                                      style: TextStyle(
                                                          color: kMyPink,
                                                          fontFamily: 'Mont',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),),
                                                Tab(
                                                  child: Text(
                                                    'For rent',
                                                    style: TextStyle(
                                                        color: kMyPink,
                                                        fontFamily: 'Mont',
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 20),
                                                  ),),
                                              ],
                                            ),
                                          ),
                                          body: TabBarView(
                                            children: [
                                              Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      children: snapshot.data!.docs.map(
                                                          (DocumentSnapshot document) {
                                                         Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                                        PropertyData propertydata =
                                                            PropertyData.fromJson(
                                                                document.data()! as Map<
                                                                    String, dynamic>);

                                                        return Column(
                                                          children: [
                                                            (propertydata.description.length > 1 && propertydata.sale=='sale')
                                                                ? Column(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          kNavigator(
                                                                              context,
                                                                              DetailProperty(documentId: document.id));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              kMyPink,
                                                                          margin: const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  14,
                                                                              vertical:
                                                                                  10),
                                                                          child:
                                                                              Container(
                                                                            width: MediaQuery.of(context)
                                                                                    .size
                                                                                    .width *
                                                                                0.85,
                                                                            height: MediaQuery.of(context)
                                                                                    .size
                                                                                    .height *
                                                                                0.14,
                                                                            margin: const EdgeInsets
                                                                                    .symmetric(
                                                                                horizontal:
                                                                                    3,
                                                                                vertical:
                                                                                    3),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                    width: MediaQuery.of(context).size.width *
                                                                                        0.19,
                                                                                    height:
                                                                                        MediaQuery.of(context).size.height * 0.14,
                                                                                    child: (propertydata.image[0].length > 1)
                                                                                        ? Image.network(propertydata.image[0])
                                                                                        : Image.asset(
                                                                                            'assets/images/wicon3.png',
                                                                                            fit: BoxFit.fill,
                                                                                          )),
                                                                                Container(
                                                                                  width:
                                                                                      MediaQuery.of(context).size.width * 0.6,
                                                                                  margin: const EdgeInsets.symmetric(
                                                                                      horizontal: 10,
                                                                                      vertical: 3),
                                                                                  child:
                                                                                      Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(propertydata.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Mont')),
                                                                                          Spacer()
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.6,
                                                                                            height: MediaQuery.of(context).size.height * 0.08,
                                                                                            child: Text(propertydata.description, textAlign: TextAlign.start, style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Mont')),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(propertydata.time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12, fontFamily: 'Mont')),
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
                                                                      const Divider(
                                                                          color:
                                                                              kLightPink,
                                                                          thickness: 2),
                                                                    ],
                                                                  )
                                                                : Container()
                                                          ],
                                                        );

                                                        //-------------------------------------------------------------------------//
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView(

                                                      children: snapshot.data!.docs.map(
                                                          (DocumentSnapshot document)

                                                          {
                                                         Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                                        PropertyData propertydata =
                                                            PropertyData.fromJson(
                                                                document.data()! as Map<
                                                                    String, dynamic>);

                                                        return Column(
                                                          children: [
                                                            (propertydata.description.length > 1 && propertydata.rent=='rent')
                                                                ? Column(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: () {
                                                                          kNavigator(
                                                                              context,
                                                                              DetailProperty(documentId: document.id));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              kMyPink,
                                                                          margin: const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  14,
                                                                              vertical:
                                                                                  10),
                                                                          child:
                                                                              Container(
                                                                            width: MediaQuery.of(context)
                                                                                    .size
                                                                                    .width *
                                                                                0.85,
                                                                            height: MediaQuery.of(context)
                                                                                    .size
                                                                                    .height *
                                                                                0.14,
                                                                            margin: const EdgeInsets
                                                                                    .symmetric(
                                                                                horizontal:
                                                                                    3,
                                                                                vertical:
                                                                                    3),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                    width: MediaQuery.of(context).size.width *
                                                                                        0.19,
                                                                                    height:
                                                                                        MediaQuery.of(context).size.height * 0.14,
                                                                                    child: (propertydata.image[0].length > 1)
                                                                                        ? Image.network(propertydata.image[0])
                                                                                        : Image.asset(
                                                                                            'assets/images/wicon3.png',
                                                                                            fit: BoxFit.fill,
                                                                                          )),
                                                                                Container(
                                                                                  width:
                                                                                      MediaQuery.of(context).size.width * 0.6,
                                                                                  margin: const EdgeInsets.symmetric(
                                                                                      horizontal: 10,
                                                                                      vertical: 3),
                                                                                  child:
                                                                                      Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(propertydata.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Mont')),
                                                                                          Spacer()
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.6,
                                                                                            height: MediaQuery.of(context).size.height * 0.08,
                                                                                            child: Text(propertydata.description, textAlign: TextAlign.start, style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Mont')),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Text(propertydata.time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12, fontFamily: 'Mont')),
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
                                                                      const Divider(
                                                                          color:
                                                                              kLightPink,
                                                                          thickness: 2),
                                                                    ],
                                                                  )
                                                                : Container()
                                                          ],
                                                        );

                                                        //-------------------------------------------------------------------------//
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            //;
                          } else if (snapshot.hasError) {
                            return Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
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
                        "loading...",
                        style: TextStyle(
                            color: kMyPink, fontSize: 20, fontFamily: 'Mont'),
                      ),
                    );
                  },
                )));
      })),
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
