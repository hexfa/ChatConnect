import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/chat_image_display.dart';
import 'package:ressengaer_app/screen/chat_screen.dart';
import 'package:ressengaer_app/screen/send_image.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';

class ChatDetails extends StatelessWidget implements ApiStatusLogin {
  var whichDoc;

  ChatDetails({required this.whichDoc});
  late BuildContext context;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference refMessage;
  TextEditingController pmController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    FirebaseFirestore fs = FirebaseFirestore.instance;
    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
                  return StreamBuilder<QuerySnapshot>(
                      stream: context.read<ApiService>().getAllMessageDetails(whichDoc),
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

                          return SafeArea(child:Container(

                            child: Scaffold(
                             // bottomNavigationBar: mYBottomNavigationBar(context),
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
                                      child: ListView(

                                        reverse: true,
                                        controller: scrollController,
                                        children: snapshot.data!.docs.map((doc) {
                                          Map data = doc.data() as Map;
                                          bool isMe =
                                          (auth.currentUser!.uid == data['getterUid']);
                                          String id = doc.id;
                                          String select=(data['getterUid']==value.myUser )
                                              ?'sender'
                                              :'getter';
                                          value.setMessageGetter(data['${select}']);
                                          value.setMessageGetterUid(data['${select}Uid']);
                                          value.setMessageSender(value.myUserName);
                                          value.setMessageSenderUid(value.myUser);
                                          value.setMessageTime(DateTime.now().toString());
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onLongPress: () {

                                                  if(data['senderUid']==value.myUser){
                                                    print(  fs.collection('users').doc(data['getterUid']).collection('message').doc(data['senderUid']).collection('chats').doc(id));
                                                    print(  fs.collection('users').doc(data['senderUid']).collection('message').doc(data['getterUid']).collection('chats').doc(id));
                                                    // fs.collection('users').doc(data['senderUid']).collection('message').doc(data['getterUid']).collection('chats').doc(id).delete()
                                                    //     .then((value) =>
                                                    // {      fs.collection('users').doc(data['getterUid']).collection('message').doc(data['senderUid']).collection('chats').doc(id).delete()});

                                                  }

                                                //  onPmTapped(data, id);
                                                },
                                                child: Bubble(
                                                  margin: BubbleEdges.only(
                                                      top: 15,
                                                      left: (10 + (isMe ? 20 : 0)),
                                                      right: 10),
                                                  alignment: isMe
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                                  nipWidth: 9,
                                                  nipHeight: 14,
                                                  nip: isMe
                                                      ? BubbleNip.rightTop
                                                      : BubbleNip.leftTop,
                                                  color: isMe
                                                      ? const Color.fromRGBO(
                                                      225, 255, 199, 1.0)
                                                      : Colors.white30,
                                                  child: (data['image']=='')
                                                    ?Text( data['pm'],
                                                      textAlign: TextAlign.right)
                                                      :InkWell(
                                                    onTap: (){
                                                      kNavigator(context, ChatImageDisplay(Src: data['image'],));
                                                    },
                                                      child: Image.network(data['image'])
                                                  )
                                                ),
                                              ),
                                              Container(
                                                  alignment: isMe
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                                  margin: EdgeInsets.only(left: 25,right: 25,top: 3),
                                                  child: Text( data['time'].toString().substring(11,16),style: TextStyle(color: kMyPink,fontSize: 10,),))
                                            ],
                                          );
                                        }).toList())
                                    ),
                                    Row(
                                      children: [
                                        Theme(
                                            data: ThemeData(
                                              primaryColor: Colors.black,
                                              primaryColorDark: Colors.red,
                                            ),
                                            child: Expanded(
                                              child: Row(
                                                children: [

                                                  Expanded(
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(80.0))),
                                                      height: 60,
                                                      margin: const EdgeInsets.all(10),
                                                      child: TextField(

                                                        minLines: 1,
                                                        maxLines: 5,
                                                        onTap: () {
                                                          Timer(
                                                              const Duration(milliseconds: 300),
                                                                  () {
                                                                scrollController.jumpTo(
                                                                    scrollController
                                                                        .position.minScrollExtent);
                                                              });
                                                        },
                                                        controller:value.messageController,

                                                        decoration: InputDecoration(
                                                          //suffixIcon: Icon(icon1),
                                                          //icon: Icon(Icons.person),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(35.0),
                                                            borderSide: BorderSide(
                                                                color: Colors.grey.shade300,
                                                                width: 1),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(35.0),
                                                            borderSide: BorderSide(
                                                                color: Colors.grey.shade300,
                                                                width: 2),
                                                          ),

                                                          hintText: 'message...',
                                                          hintStyle: const TextStyle(
                                                              color: Colors.black12,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              showDialog<
                                                  String>(
                                                  context:
                                                  context,
                                                  builder:
                                                      (BuildContext
                                                  context) {
                                                    return Dialog(
                                                      child: SendImageDialog()
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.image_outlined,
                                              color: Colors.grey.shade300,
                                              size: 35,
                                            )),
                                        IconButton(
                                            onPressed: () {

                                              // print(value.sender);
                                              // print(value.senderUid);
                                              // print(value.getter);
                                              // print(value.getterUid);
                                              // print(value.messageTime);
                                              // print(value.messageController.text);
                                              value.sendMessage(context);
                                            },
                                            icon: Icon(
                                              Icons.send_sharp,
                                              size: 30,
                                              color: Colors.pink.shade800,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        }

                        return Center(
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
                                ],
                              ),
                            ),
                          ),
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
