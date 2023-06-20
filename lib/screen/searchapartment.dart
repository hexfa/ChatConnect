import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/AddBuilding/add_building.dart';
import 'package:ressengaer_app/screen/searchapartment.dart';

import '../constants.dart';
import '../provider/ApiService.dart';

class SearchApartment extends StatefulWidget {
  var previusScreen;

  SearchApartment({required this.previusScreen});

  @override
  State<SearchApartment> createState() => _SearchApartmentState();
}

class _SearchApartmentState extends State<SearchApartment> {
  TextEditingController searchapartment = TextEditingController();


  late Future resultsLoaded;
  List<DocumentSnapshot> _allResults = [];
  List _resultsList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   searchapartment.addListener(_onSearchChanged);
  // }

  // @override
  // void dispose() {
  //   searchapartment.removeListener(_onSearchChanged);
  //   searchapartment.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   resultsLoaded = getUsersPastTripsStreamSnapshots();
  // }


  // _onSearchChanged() {
  //   searchResultsList();
  // }

  // searchResultsList() {
  //   var showResults = [];
  //
  //   if(searchapartment.text != "") {
  //     for(var tripSnapshot in _allResults){
  //       var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();
  //
  //       if(title.contains(searchapartment.text.toLowerCase())) {
  //         showResults.add(tripSnapshot);
  //       }
  //     }
  //
  //   } else {
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }

  // getUsersPastTripsStreamSnapshots() async {
  //   final uid = await Provider.of(context).auth.getCurrentUID();
  //   var data = await Firestore.instance
  //       .collection('userData')
  //       .document(uid)
  //       .collection('trips')
  //       .where("endDate", isLessThanOrEqualTo: DateTime.now())
  //       .orderBy('endDate')
  //       .getDocuments();
  //   setState(() {
  //     _allResults = data.documents;
  //   });
  //   searchResultsList();
  //   return "complete";
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Consumer<ApiService>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Image(
                      image: AssetImage(
                          'assets/images/screen6.fw.png'),
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
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 40,
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value){
                        setState(() {
                          searchapartment.text = value.toLowerCase();
                          print(searchapartment.text);
                        });

                      },
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kLightPink),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: kLightPink,
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search_outlined,
                            color: Colors.white,),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kLightPink),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kLightPink),
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),

                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: (searchapartment.text == '')? context.read<ApiService>().getApartment() : context.read<ApiService>().getApartment2(searchapartment.text),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              );
                            }
                            // return Text('data');
                            print(snapshot.data!.docs);
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (BuildContext context, index) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                value.setApartment(snapshot.data!
                                                    .docs[index]
                                                    .get('name'));

                                                value.setApartmentId(snapshot
                                                    .data!.docs[index]
                                                    .get('id'));

                                                context.read<ApiService>()
                                                    .updateApartment(
                                                  context,
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                      snapshot.data!.docs[index]
                                                          .get('name'),
                                                      style: const TextStyle(
                                                          color: kLightPink,
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            const Divider(color: kLightPink,
                                              thickness: 2,
                                              height: 0,),
                                            SizedBox(
                                              height: 18,
                                            ),
                                          ],
                                        );
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                    ),
                                    // height: MediaQuery.of(context).size.height * 0.55,
                                    height: 435,
                                  )
                                ],
                              ),
                            );
                          }

                          return Center(
                            child: Container(),
                          );
                        })

                  ],
                );
              },
              child: Container(
                color: Colors.black,
                child: Center(child: Text('salam')),
              ),
            ),
          ),
        ),
      ),
    );
  }


}