import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../provider/ApiService.dart';
import 'city.dart';

class SelectCountry extends StatelessWidget {
  const SelectCountry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, value, child) {
        value.getAllVetEvents();
        return StreamBuilder<QuerySnapshot>(
            stream: context.read<ApiService>().getCountry(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('hasError');
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(),
                );
              }

              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(15)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'No Contact...',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  );
                }
                // return Text('data');

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
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context,index){
                                return Column(
                                  children: [
                                    RawMaterialButton(
                                      onPressed: () {
                                        kNavigator(context, SelectCity());
                                      },
                                      child: Row(
                                        children: [
                                          Image(
                                            image: NetworkImage(
                                                snapshot.data!.docs[index].get('image')),
                                            height: 40,
                                            width: 40,
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Text(snapshot.data!.docs[index].get('country'),
                                              style: TextStyle(
                                                  color: kLightPink,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                    Divider(color: kLightPink, thickness: 2),
                                  ],
                                );
                              },
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Center(
                child: Container(),
              );
            });
      },
    );
  }
}
