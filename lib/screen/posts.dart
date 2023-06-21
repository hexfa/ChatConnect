
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../Model/property_model.dart';
import '../constants.dart';
import '../provider/ApiService.dart';


import 'clasifieds_ads.dart';
import 'detailclassifieds.dart';

class Posts extends StatelessWidget {


  Posts();

  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    String city = 'test';
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore fs = FirebaseFirestore.instance;
    String myId = auth.currentUser!.uid;

//------------------------------------------------------------------------//

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Text(
                'My Posts',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
        body: Container(

          child: Consumer<ApiService>(
            builder: (context, value, child) {
              return MaterialApp(
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
                              'Classified',
                              style: TextStyle(
                                  color: kMyPink,
                                  fontFamily: 'Mont',
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 20),
                            ),),
                          Tab(
                            child: Text(
                              'property',
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
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder<DocumentSnapshot>(
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
                                            child: Column(
                                              children: [
                                                Container(
                                                  height:
                                                  MediaQuery.of(context).size.height * 0.8,
                                                  child: MaterialApp(
                                                    debugShowCheckedModeBanner: false,
                                                    home: Scaffold(
                                                      body:  Column(
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
                                                                        (propertydata.description.length > 1 && propertydata.sender==auth.currentUser!.uid)
                                                                            ? Row(
                                                                              children: [
                                                                                Column(
                                                                          children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    // kNavigator(
                                                                                    //     context,
                                                                                    //      DetailClassifieds(category:,));
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
                                                                                              child: (propertydata.image.length > 1)
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
                                                                        ),
                                                                                InkWell(
                                                                                    onTap: (){
                                                                                      fs.collection('apartment').doc(value.groupApartment).collection('property').doc(document.id).delete();
                                                                                    },
                                                                                    child: Icon(Icons.close_outlined,color: Colors.red,))
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
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Widget Menu(String text, IconData icon, bool last,context) {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: () {
            kNavigator(context, SellingItem(category: text,MyIcon: icon,myPosts: true,));

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
}


