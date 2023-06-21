import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/constants.dart';
import '../provider/ApiService.dart';
import '../widgets/button.dart';

class ChatDialog extends StatelessWidget {

  ChatDialog({Key? key}) : super(key: key);

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

//------------------------------------------------------------------------//

    return Container(
      color: kMyPink,

      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Scaffold(
backgroundColor: kMyPink,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: kMyPink,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Consumer<ApiService>(
            builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               const Text(
                  'When a user clicks on a category they are taken  ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Mont')),
              const Text(
                  'When a user clicks on samsoung 10443-4532 ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Mont')),
              Row(
                children: const [
                  Text(
                      '231\$',
                      textAlign: TextAlign.start,
                      style: TextStyle(
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
                  controller: value.getRecordTextController,
                  decoration: const InputDecoration(border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15), hintText: "your message...",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: kMyPink,
                        fontFamily: 'Mont'

                      )),
                ),
              ),
              roundedButton(
                  kMyPink, context, 0.05, 0.55, 'Send Message', Colors.white, () {
                value.signIn();
              },16.0),
            ],
          );
            },
          ),
        ),
      ),
    );
  }
}

