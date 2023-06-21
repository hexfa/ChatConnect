import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/screen/seling_items.dart';
import 'package:ressengaer_app/widgets/my_bottom_navigation_bar.dart';

class ClassiFieds extends StatelessWidget {
  const ClassiFieds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: mYBottomNavigationBar(context),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.push_pin_rounded,
                    color: kLightPink,
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
                    image: const AssetImage('assets/images/wicon.png'),
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: <Widget>[
                  Menu('Electronics', FontAwesomeIcons.tv,true,context),
                  Menu('Home & Garden', FontAwesomeIcons.couch,true,context),
                  Menu('Automotive Vehicles', Icons.monitor,true,context),
                  Menu('Baby & Kids', Icons.monitor,true,context),
                  Menu('Fashion', Icons.monitor,true,context),
                  Menu('Pets', Icons.monitor,true,context),
                  Menu('Sports & Leisure', Icons.monitor,true,context),
                  Menu('Services', Icons.monitor,true,context),
                  Menu('Lost & Found', Icons.monitor,true,context),
                  Menu('Charity', Icons.monitor,true,context),
                  Menu('Community', Icons.monitor,false,context),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

Widget Menu(String text, IconData icon, bool last,context) {
  return Column(
    children: [
      RawMaterialButton(
        onPressed: () {
          kNavigator(context, SellingItem());
        },
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(
                  icon,
                  color: kLightPink,
                )),
            // Icon(FaIcon(FontAwesomeIcons.tv),color: kLightPink,),
            const SizedBox(
              width: 20,
            ),
            Text(text,
                style: const TextStyle(
                    color: kLightPink,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      Visibility(
        visible: last,
          child: const Divider(
        color: kLightPink,
        thickness: 2,
        height: 0,
      )),
    ],
  );
}
