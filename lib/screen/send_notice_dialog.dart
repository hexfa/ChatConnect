import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/constants.dart';
import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/button.dart';

class SendNoticeDialog extends StatelessWidget implements UploadStatus {
  var userEmail;

  var name;

  var uid;


  SendNoticeDialog({required this.userEmail,required this.uid,required this.name}) ;

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
                     children: [
                       Text(
                          'admin : $name',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Mont')),
                     ],
                   ),
                  const Text(
                      'send notice message to your buildings member',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Mont')),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child:   TextField(
                       controller:value.sendNoticeTitleController ,
                      decoration: const InputDecoration(border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15), hintText: "title...",
                          hintStyle: TextStyle(
                              fontSize: 12,
                              color: kMyPink,
                              fontFamily: 'Mont'

                          )),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child:   TextField(

                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                       controller:value.sendNoticeController ,
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
                         value.sendNoticeService(context);
                  },16.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void error() {
    // TODO: implement error
  }

  @override
  void uploaded() {
    ModeSnackBar.show(context, 'sent', SnackBarMode.success);
    kNavigatorBack(context);
  }

  @override
  void uploading() {
    // TODO: implement uploading
  }
}

