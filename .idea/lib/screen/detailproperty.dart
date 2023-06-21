import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../widgets/my_bottom_navigation_bar.dart';
class DetailProperty extends StatelessWidget {
  const DetailProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: SizedBox(
            height: 137,
            child: Column(
              children: [
                const Divider(thickness: 3),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: RichText(
                        text: const TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                            fontSize: 14.0,
                            color: kLightPink,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Posted by:\n'),
                            TextSpan(
                                text: 'Ron Cribb ,\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: kDarkBlue)),
                            TextSpan(
                                text: '23 February 2022',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kDarkBlue,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: const Text(
                        'Send Message',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                mYBottomNavigationBar(context),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowCircleLeft,
                          color: kLightPink,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Property',
                      style: TextStyle(
                          color: kLightPink,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: kDarkBlue,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: const Center(
                          child: Text(
                            'Post',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Image(
                      image: AssetImage('assets/images/wicon.png'),
                      width: 50,
                      height: 50,
                      color: kLightPink,
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
                  children: const [
                    Text(
                      '3 Bedroom , 3 bsthroom for rent\nR17900',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kLightPink),
                    ),
                    Text(
                      '\nDescription',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kLightPink,
                          fontSize: 15),
                    ),
                    Text(
                      '\ntest',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kLightPink,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
