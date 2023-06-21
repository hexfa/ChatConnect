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
import '../widgets/my_bottom_navigation_bar.dart';

class ChatScreen extends StatelessWidget implements ApiStatusLogin {
  ChatScreen({Key? key}) : super(key: key);
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        body: SafeArea(

            child: Consumer<ApiService>(
                builder: (context, value, child) {
                  value.apiListener(this);
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
                                    Icons.wifi_protected_setup,
                                    size: 35,
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
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                children:  <Widget>[
                                  RawMaterialButton(
                                    onPressed: () {  },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(25),
                                                child: Image.asset('assets/images/wicon2.png',fit: BoxFit.fill,)),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text('John sims',style: TextStyle(
                                                  color: kMyPink,
                                                  fontSize: 17,
                                                  fontFamily: 'Mont',
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text('last seen recently',style: TextStyle(
                                                color: kMyPink,
                                                fontSize: 12,
                                                fontFamily: 'Mont',

                                              ),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
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
