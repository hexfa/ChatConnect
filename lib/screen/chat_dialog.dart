import 'package:cloud_firestore/cloud_firestore.dart';
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

class ChatDialog extends StatelessWidget implements ApiStatusLogin {
  var documentId;

  var category;

  ChatDialog({required this.category, required this.documentId});

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
        child: Consumer<ApiService>(builder: (context, value, child) {
      value.apiListener(this);
      return SafeArea(
          child: Container(
        child: Container(
          color: kMyPink,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          child: FutureBuilder<DocumentSnapshot>(
            future: value.getClassifiedAdsDetails(
                value.groupApartment, category, documentId),
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
                return Scaffold(
                  backgroundColor: kMyPink,
                  body: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    color: kMyPink,
                    // height: MediaQuery.of(context).size.height * 0.7,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Consumer<ApiService>(
                      builder: (context, value, child) {
                        return Container(
                          child: (value.messageSent=='sent')
                              ?Container(
                            color: kMyPink,
                            child: const Center(
                              child: Text('Message successfully sent!' , style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Mont')),
                            ),

                          )
                              :Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: kLightPink,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'send message to \n',
                                            style: TextStyle(color: Colors.white)),
                                        TextSpan(
                                            text: '${data['senderName']}\n ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        const TextSpan(
                                            text: 'to enquire on : \n',
                                            style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      data['title'],
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Mont')),
                                ],
                              ),
                              Row(
                                children:  [
                                  Text('\R${data['price']}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          fontFamily: 'Mont')),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child:  TextField(
                                  controller: value.messageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "your message...",
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color: kMyPink,
                                          fontFamily: 'Mont')),
                                ),
                              ),
                              roundedButton(kMyPink, context, 0.05, 0.55,
                                  'Send Message', Colors.white, () {
                                    value.setMessageSent('');
                                    value.setMessageGetter(data['senderName']);
                                    value.setMessageGetterUid(data['sender']);
                                    value.setMessageSender(value.myUserName);
                                    value.setMessageSenderUid(value.myUser);
                                    value.setMessageTime(DateTime.now().toString());


                                    value.sendMessage(context);
                                    value.notifyListeners();
                                    value.setMessageSent('sent');


                                  }, 16.0),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
          ),
        ),
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
