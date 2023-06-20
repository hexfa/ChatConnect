import 'package:flutter/material.dart';
import 'package:ressengaer_app/screen/notices.dart';

import '../constants.dart';

class SearchApartment extends StatelessWidget {
  const SearchApartment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Select Residence',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: kLightPink,
                        fontSize: 25),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: kLightPink,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: kLightPink,
                    width: 1.0,
                  ),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.only(bottom: 10,right: 25),
                    hintText: 'search',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: <Widget>[
                    Column(
                      children: [
                        RawMaterialButton(
                          onPressed: (){
                            kNavigator(context, Notices());
                          },
                          child: Row(
                            children: const [
                              Text('Aliway (Randburg)',
                                  style:
                                      TextStyle(color: kLightPink, fontSize: 18)),
                            ],
                          ),
                        ),
                        Divider(color: kLightPink, thickness: 2),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
