import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressengaer_app/screen/chat_details.dart';
import 'package:ressengaer_app/screen/chat_list.dart';
import 'package:ressengaer_app/screen/notices.dart';
import 'package:ressengaer_app/screen/property.dart';

import 'package:ressengaer_app/screen/services_item.dart';

import '../Authentication/confirm.dart';
import '../constants.dart';
import '../screen/classifieds.dart';
import '../screen/services.dart';

mYBottomNavigationBar(context) {
  return StyleProvider(
    style: Style(),
    child: ConvexAppBar(
      color: kMyPink,
      activeColor: kMyPink,
      height: 50,
      top: 0,

      //curveSize: 100,
      backgroundColor: Colors.white,
      items: [
        TabItem(icon: Image(image: AssetImage('assets/images/notification.png'),color: kLightPink,), title: ''),
        TabItem(
          icon: Image(image: AssetImage('assets/images/newspaper.png'),color: kLightPink,),
          title: '',
        ),
        TabItem(
            icon: Image(image: AssetImage('assets/images/suitcase.png'),color: kLightPink,),
            title: ''),
        TabItem(icon: Image(image: AssetImage('assets/images/house.png'),color: kLightPink,), title: ''),
        TabItem(icon: Image(image: AssetImage('assets/images/chat.png'),color: kLightPink,), title: ''),
      ],
      //initialActiveIndex: 0,
      //optional, default as 0
      onTap: (int i) {
        if (i == 0) {
          kNavigator(context, Notices());
        } else if (i == 1) {
          kNavigator(context, ClassiFieds());
        } else if (i == 2) {
          kNavigator(context, Services());
        }
        else if (i == 3) {
          kNavigator(context, PropertyItems());
        }
        else if (i == 4) {
          kNavigator(context, ChatList());
        }
      },
    ),
  );
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 28;

  @override
  double get activeIconMargin => 5;

  @override
  double get iconSize => 28;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 10, color: color);
  }
}

class Home extends StatefulWidget {
  int currentTab;

 Home({Key? key,required this.currentTab}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Notices(),
    ClassiFieds(),
    Services(),
    PropertyItems(),
    ChatList(),

  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Notices(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        Notices(); // if user taps on this dashboard tab will be active
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      size: 30,
                      color: currentTab == 0 ? kMyPink  : Colors.grey,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: currentTab == 0 ? Colors.lightGreen  : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        ClassiFieds(); // if user taps on this dashboard tab will be active
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.thumbtack,
                      color: currentTab == 1 ? kMyPink  : Colors.grey,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: currentTab == 1 ? Colors.lightGreen  : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        Services(); // if user taps on this dashboard tab will be active
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.briefcase,
                      color: currentTab == 2 ? kMyPink : Colors.grey,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: currentTab == 2 ? Colors.lightGreen : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  // bottomSheetDisplay(context);
                  setState(() {
                    currentScreen =
                        PropertyItems(); // if user taps on this dashboard tab will be active
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.bullhorn,
                      color: currentTab == 3 ? kMyPink: Colors.grey,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: currentTab == 3 ? Colors.lightGreen  : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                 minWidth: 40,
                onPressed: () {
                  // bottomSheetDisplay(context);
                  setState(() {
                    currentScreen =
                        ChatList(); // if user taps on this dashboard tab will be active
                    currentTab = 4;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.message,
                      color: currentTab == 4 ? kMyPink  : Colors.grey,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        color: currentTab == 3 ? Colors.lightGreen  : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }

}