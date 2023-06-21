import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/button.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import '../widgets/post_form.dart';
import 'chat_dialog.dart';

class PostClassified extends StatelessWidget {
  const PostClassified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: mYBottomNavigationBar(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.wifi_protected_setup,
                    color: kMyPink,
                    size: 40,), onPressed: () {
                    kNavigatorBack(context);
                },
                ),
                const Text(
                  'Post Classifieds',
                  style: TextStyle(
                      color: kMyPink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mont'),
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/images/wicon3.png'),
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              postForm(context,'Select category of classified',"Select (required)",0.9,0.05),
              postForm(context,'Classified title',"Type your Classified title(required)",0.9,0.05),
              postForm(context,'Price',"Enter the price in R (optional)",0.9,0.05),
              postForm(context,'Description'," Type a detailed description between 30 to\n 3000 characters(required)",0.9,0.2),
              SizedBox(
                height: 10,
              ),
              Row(
                children:   [
                  SizedBox(width: 30,),
                  const Text(
                    'Pictures',
                    style: TextStyle(
                        color: kMyPink,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mont'),
                  ),
                  Text(
                    '(optional)',
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mont'),
                  ),
                  Spacer()
                ],
              ),
              Row(
                children:  [
                  SizedBox(width: 30,),
                  Icon(Icons.add_a_photo_outlined,color: Colors.grey.shade300,size: 50,),
                  Spacer()
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children:  const [
                  SizedBox(width: 45,),
                  Text(
                    'By submitting your classified your are agreeing to\nRessenger\s Terms & Conditions',
                    textAlign: TextAlign.center,
                    style: TextStyle(

                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mont'),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(height: 10,),
              roundedButton(
                  kMyPink, context, 0.08, 0.63, 'Submit', Colors.white, () {

                // kNavigator(context, Confirm());
              },30.0),
            ],
          ),
        ),
      )
    );
  }
}
