import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/chat_details.dart';
import 'package:ressengaer_app/screen/chat_screen.dart';
import 'package:ressengaer_app/screen/profile.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';

class ChatList extends StatelessWidget implements ApiStatusLogin {
  ChatList({Key? key}) : super(key: key);
  late BuildContext context;
  FirebaseFirestore fs = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
                  return StreamBuilder<QuerySnapshot>(
                      stream: context.read<ApiService>().getAllMessageList(),
                      builder:
                          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            return Container(

                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.center,

                                child: Scaffold(
                                 // bottomNavigationBar: mYBottomNavigationBar(context),
                                  body: Column(
                                    children: [
                                      Row(
                                        children:  [
                                          const Image(image: const AssetImage('assets/images/chat.png'),color: kLightPink,width: 35,),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Messages',
                                            style: TextStyle(
                                                color: kLightPink,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),

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
                                      const Divider(color: Colors.grey, thickness: 2),
                                      const SizedBox(
                                        height: 250,
                                      ),
                                      const Center(
                                        child: Text(
                                          'No Content...',
                                          style: TextStyle(color: kMyPink, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          }
                          // return Text('data');

                          return SafeArea(child:Container(

                            child: Scaffold(
                              //bottomNavigationBar: mYBottomNavigationBar(context),
                              body: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.message,
                                            color: kLightPink,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Messages',
                                            style: TextStyle(
                                                color: kLightPink,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),

                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image(
                                            image: AssetImage('assets/images/wicon.png'),
                                            width: 50,
                                            height: 50,
                                            color: kLightPink,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(color: Colors.grey, thickness: 2),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child:ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (BuildContext context, index) {

                                          return  Dismissible(
                                            direction: DismissDirection.endToStart,
                                            background: Container(color: Colors.red,child: const Center(child: const Icon(Icons.delete,color: Colors.white,)),),
                                            key: ValueKey(snapshot.data!.docs[index]),
                                            onDismissed: (DismissDirection direction) {
                                              fs.collection('users').doc(snapshot.data!.docs[index].get('senderUidDoc')).collection('message').doc(snapshot.data!.docs[index].id).delete();

                                              print(snapshot.data!.docs[index].id);
                                            },
                                            child: Column(
                                              children: [
                                                (snapshot.data!.docs[index]
                                                    .get('getterUidDoc')==value.myUser || snapshot.data!.docs[index]
                                                    .get('senderUidDoc')==value.myUser)
                                                ?  Column(
                                                  children: [
                                                    RawMaterialButton(
                                                      onPressed: () {
                                                        print(snapshot.data!.docs[index].get('senderUidDoc'));
                                                        String selectUid=(snapshot.data!.docs[index].get('getterUidDoc')==value.myUser )
                                                            ?snapshot.data!.docs[index].get('senderUidDoc')
                                                            :snapshot.data!.docs[index].get('getterUidDoc');
                                                        kNavigator(context, ChatDetails(whichDoc:selectUid ));
                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            // CircleAvatar(
                                                            //   radius: 25,
                                                            //   child: ClipRRect(
                                                            //       borderRadius: BorderRadius.circular(25),
                                                            //       child: Image.asset('assets/images/wicon2.png',fit: BoxFit.fill,)),
                                                            // ),
                                                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text( (snapshot.data!.docs[index].get('getterUidDoc')==value.myUser )
                                                             ?snapshot.data!.docs[index].get('senderDoc')
                                                             :snapshot.data!.docs[index].get('getterDoc')
                                                            ,style: const TextStyle(
                                                                    color: kMyPink,
                                                                    fontSize: 17,
                                                                    fontFamily: 'Mont',
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                                const Text('last seen recently',style: TextStyle(
                                                                  color: kMyPink,
                                                                  fontSize: 12,
                                                                  fontFamily: 'Mont',

                                                                ),),

                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(color: kMyPink,thickness: 0.4,)
                                                  ],
                                                )
                                                    :Container()
                                              ],
                                            ),
                                          );
                                        },
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        }

                        return Center(
                          child: Container(),
                        );
                      });
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
    kNavigator(context, Confirm());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'password is weak', SnackBarMode.warning);
  }
}
