import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/button.dart';
import 'package:http/http.dart' as http;

class EmailDialog extends StatelessWidget {
  var userEmail;

  var name;

  var uid;


  EmailDialog({required this.userEmail,required this.uid,required this.name}) ;

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
                  Row(
                    children: const [
                      Text(
                          'to : itayichi@gmail.com',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Mont')),
                    ],
                  ),
                   Row(
                     children: [
                       Text(
                          'from : $userEmail',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Mont')),
                     ],
                   ),
                  Row(
                    children: const [
                      Text(
                          'subject : admin request',
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
                    child:  const Center(
                      child: Text(
                                     'I want to be admin in ressenger app so\nthat I can better manage my building',


                            style: TextStyle(
                                fontSize: 12,
                                color: kMyPink,
                                fontFamily: 'Mont'

                            )),
                    ),
                    ),

                  roundedButton(
                      kMyPink, context, 0.05, 0.55, 'Send Message', Colors.white, () {
                   sendEmail(email: userEmail, uid: uid, name:name );
                  },16.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  Future sendEmail({
    required String name,
    required String email,
    required String uid,
    // required String message,
  })async{
    final servicId='service_067hxdl';
    final tempateId='template_k3q42bw';
    final userId='v77Uk95cFfzSF7oGo';
    final url =Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
        url,
        headers: {
          'origin':'http://localhost',
          'Content-Type': 'application/json'
        },
        body:json.encode( {

          'service_id':servicId,
          'template_id':tempateId,
          'user_id':userId,
          'template_params':{
            'user_name':name,
            'user_email':email,
            'uid':uid,
            //'user_message':message,
          }
        })
    );
    print(response.body);
    if(response.body=='OK'){
     return ModeSnackBar.show(context, 'email sent', SnackBarMode.success);
    }
    // if(await canLaunch('https://api.emailjs.com/api/v1.0/email/send')){
    //   await launch('https://api.emailjs.com/api/v1.0/email/send');
    // }
  }
}

