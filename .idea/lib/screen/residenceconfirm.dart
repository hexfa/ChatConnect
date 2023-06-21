import 'package:flutter/material.dart';

import '../constants.dart';

class ResidenceConfirm extends StatelessWidget {
  const ResidenceConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Image(
              image: AssetImage('assets/images/screen6.fw.png'),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: const [
                Text(
                  'Residence Confirm',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: kLightPink,
                      fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            RichText(
              text: const TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: TextStyle(
                  fontSize: 14.0,
                  color: kLightPink,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'l, '),
                  TextSpan(
                      text: 'Ron Cribb ,',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'with email address '),
                  TextSpan(
                      text: 'roncribb@gmail.com ,',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'confirm that iam a resident of '),
                  TextSpan(
                      text: 'Albury Estate ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'and my \nunit / house number is: '),
                ],
              ),
            ),
            SizedBox(height: 20,),
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.house,
                  color: kLightPink,
                ),
                hintText: 'enter unit / house number',
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: kLightPink),),
                hintStyle: TextStyle(color: kLightPink,fontFamily: 'Mont'),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: kLightPink),),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  color: kLightPink,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Center(child: Text('Confirm',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
          ],
        ),
      ),
    ));
  }
}
