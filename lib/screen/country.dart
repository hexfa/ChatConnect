import 'package:flutter/material.dart';
import '../constants.dart';
import 'city.dart';

class SelectCountry extends StatelessWidget {
  const SelectCountry({Key? key}) : super(key: key);

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
              const Text(
                'Select Country',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: kLightPink,
                    fontSize: 20),
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
                          onPressed: () { kNavigator(context, SelectCity()); },
                          child: Row(
                            children: const [
                              Image(
                                image: AssetImage('assets/images/1.png'),
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 80,),
                              Text('South Africa',style: TextStyle(color: kLightPink,fontSize: 18)),
                            ],
                          ),
                        ),
                        Divider(color: kLightPink,thickness: 2),
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
