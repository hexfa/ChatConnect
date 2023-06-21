import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Authentication/login.dart';
import 'package:ressengaer_app/Authentication/sign_up.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/post_classified.dart';
import 'package:ressengaer_app/screen/profile.dart';
import 'package:ressengaer_app/widgets/button.dart';
import 'package:ressengaer_app/widgets/text_fileds.dart';

import '../Utils/custom_snackbar.dart';
import '../provider/ApiService.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import 'chat_dialog.dart';

class DetailClassifieds extends StatelessWidget implements ApiStatusLogin {
  var category;

  var documentId;

  DetailClassifieds({required this.category, required this.documentId});

  late BuildContext context;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(body:
        SafeArea(child: Consumer<ApiService>(builder: (context, value, child) {
      value.apiListener(this);
      return SafeArea(
          child: Container(
        child: Scaffold(
          bottomNavigationBar: SizedBox(
              height: 137,
              child: FutureBuilder<DocumentSnapshot>(
                future: value.getClassifiedAdsDetails(
                    value.groupApartment, category, documentId),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        const Divider(thickness: 3),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: RichText(
                                text: TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: kLightPink,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(text: 'Posted by:\n'),
                                    TextSpan(
                                        text: '${data['senderName']} ,\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: kDarkBlue)),
                                    TextSpan(
                                        text: data['time'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                value.setMessageSent('');
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: ChatDialog(
                                          category: category,
                                          documentId: documentId,
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kDarkBlue,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 8),
                                child: const Text(
                                  'Send Message',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                       // mYBottomNavigationBar(context),
                      ],
                    );
                  }

                  return const Center(
                    child: Text(
                      "loading...",
                      style: TextStyle(
                          color: kMyPink, fontSize: 20, fontFamily: 'Mont'),
                    ),
                  );
                },
              )),
          body: FutureBuilder<DocumentSnapshot>(
            future: value.getClassifiedAdsDetails(
                value.groupApartment, category, documentId),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                List list = data['image'];
                print(data);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                kNavigatorBack(context);
                              },
                              icon: const Icon(
                                Icons.wifi_protected_setup,
                                color: kMyPink,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Classifieds',
                              style: TextStyle(
                                  color: kLightPink,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            RawMaterialButton(
                              onPressed: () {
                                kNavigator(context, PostClassified());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kDarkBlue,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: const Center(
                                    child: Text(
                                  'Post',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){
                                kNavigator(context, ProFileScreen());
                              },
                              child: const Image(
                                image: AssetImage('assets/images/wicon.png'),
                                width: 50,
                                height: 50,
                                color: kLightPink,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey, thickness: 2),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Image(
                          image: AssetImage('assets/images/banner.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: kLightPink),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '\R' + data['price'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kLightPink,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: (data['image'].toString().length > 2)
                                  ? Center(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Stack(
                                          children: [
                                            CarouselSlider.builder(
                                              carouselController: carouselController,
                                              options: CarouselOptions(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                enlargeCenterPage: true,
                                              ),
                                              itemCount: list.length,
                                              itemBuilder: (context, itemIndex,
                                                  realIndex) {
                                                return InkWell(
                                                  onTap: () {
                                                    print(realIndex);
                                                  },
                                                  child: Container(
                                                    child: Image(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            data['image']
                                                                [itemIndex])),
                                                  ),
                                                );
                                              },
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      carouselController.previousPage();
                                                    },
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      width: 70,
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.3,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .arrow_back_ios_outlined,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      carouselController.nextPage();
                                                    },
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      width: 70,
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.3,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.arrow_forward_ios,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ]),
                                            Positioned(
                                              bottom: 5,
                                              left: 10,
                                              child: InkWell(
                                                onTap: () {
                                                },
                                                child: Icon(
                                                  Icons.zoom_in,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: Image.asset(
                                              'assets/images/wicon2.png')),
                                    ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              data['description'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kLightPink,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(
                child: Text(
                  "loading...",
                  style: TextStyle(
                      color: kMyPink, fontSize: 20, fontFamily: 'Mont'),
                ),
              );
            },
          ),
        ),
      ));
    })));
  }

  @override
  void accountAvailable() {}

  @override
  void error() {
    ModeSnackBar.show(context, 'something go wrong', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(
        context, 'username or password empty', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(
        context, 'username or password incorrect', SnackBarMode.warning);
  }

  @override
  void login() {
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
