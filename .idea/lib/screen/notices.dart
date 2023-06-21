import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/searchapartment.dart';
import 'package:ressengaer_app/widgets/my_bottom_navigation_bar.dart';

import 'classifieds.dart';
import 'detailclassifieds.dart';
import 'detailproperty.dart';

class Notices extends StatelessWidget {
  const Notices({Key? key}) : super(key: key);

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
                Icons.notifications,
                color: kMyPink,
                size: 40,
              ),
              const Text(
                'Notices',
                style: TextStyle(
                    color: kMyPink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mont'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 14),
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text('Title',
                              style: TextStyle(
                                  color: kLightPink,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Mont'
                                 )),


                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text('Once registered and / or logged in a user is taken to the Notices screen of the app.This is where notices posted by the residence admin are displayed.The residence admin is able to log into the Residence admin panel which is web based using an email address and password that will be created by the Ressenger admin.',
                          style: TextStyle(
                              color: kLightPink,
                              fontSize: 14,

                              fontFamily: 'Mont'
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children:  [
                            Text(DateFormat.yMMMMEEEEd().add_Hm().format(DateTime.now()),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                    color: kLightPink,
                                    fontSize: 12,
                                    fontFamily: 'Mont'
                                )),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 2),
                // ElevatedButton(onPressed: (){
                //   kNavigator(context, ClassiFieds());
                // }, child: const Text('hhhhhh'))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
