import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/chat_dialog.dart';
import 'package:ressengaer_app/screen/detailclassifieds.dart';
import 'package:ressengaer_app/screen/post_classified.dart';
import 'package:ressengaer_app/screen/searchapartment.dart';
import 'package:ressengaer_app/widgets/my_bottom_navigation_bar.dart';

class SellingItem extends StatelessWidget {
  const SellingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
          Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.tv_outlined,
                color: kMyPink,
                size: 45,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                'Electronics',
                style: TextStyle(
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
          Expanded(
            child: ListView(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    kNavigator(context, DetailClassifieds());
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
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: Image.asset(
                                'assets/images/wicon3.png',
                                fit: BoxFit.fill,
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text('Title ',
                                        style: TextStyle(
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
                                      child: const Text(
                                          'When a user clicks on a category they are taken to a screen that shows the list of ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Mont')),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        DateFormat.yMMMMEEEEd()
                                            .format(DateTime.now()),
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
                const Divider(color: Colors.grey, thickness: 2),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
