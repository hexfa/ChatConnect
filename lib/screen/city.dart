import 'package:flutter/material.dart';
import 'package:ressengaer_app/screen/searchapartment.dart';

import '../constants.dart';

class SelectCity extends StatelessWidget {
  const SelectCity({Key? key}) : super(key: key);

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
                    'Select City',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: kLightPink,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Image(
                    image: AssetImage('assets/images/1.png'),
                    height: 40,
                    width: 40,
                  ),
                ],
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
                          onPressed: () {
                            kNavigator(context, SearchApartment());
                          },
                          child: Row(
                            children: const [
                              Text('Johannesburg',
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
