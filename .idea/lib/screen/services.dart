import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ressengaer_app/widgets/button.dart';

import '../constants.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'chat_dialog.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              const Icon(
                Icons.wifi_protected_setup,
                color: kMyPink,
                size: 40,
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
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              RawMaterialButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: ChatDialog(),
                        );
                      });
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                width: 50,
                height: 50,
                child: Image.asset('assets/images/wicon3.png'),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: mYBottomNavigationBar(context),
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
                margin: const EdgeInsets.only(right: 45, left: 14, top: 10),
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Text(
                  'Automotive',
                  style: TextStyle(
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
            child: ListView(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  child: Image.asset(
                                    'assets/images/wicon3.png',
                                    fit: BoxFit.fill,
                                  )),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text('Title test test',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Mont')),
                                    Spacer()
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Text('Description',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontSize: 13,
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
                                      child: const Text(
                                          'When a user clicks on a category they are taken to a screen that shows the list of When a user clicks on a category they are taken to a screen that shows the list of When a user clicks on a category they are taken to a screen that shows the list of ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: kMyPink,
                                              fontSize: 12,
                                              fontFamily: 'Mont')),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: const [
                                    Text('Telephone : ',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Text('011 890 00000 ',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Spacer()
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text('Mobile : ',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Text('083 300 6573 ',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Spacer()
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text('Email : ',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Text('info@ben.co.com',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Spacer()
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text('Website : ',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Text('www.ben.co.za',
                                        style: TextStyle(
                                            color: kMyPink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: 'Mont')),
                                    Spacer()
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    socialMediaButton(context,
                                        'assets/images/instegram.png', () {}),
                                    socialMediaButton(context,
                                        'assets/images/facebook.png', () {}),
                                    socialMediaButton(context,
                                        'assets/images/twitter.png', () {}),
                                    socialMediaButton(context,
                                        'assets/images/linkdin.png', () {}),
                                    Spacer()
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
