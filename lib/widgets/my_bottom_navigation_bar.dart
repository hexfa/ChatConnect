import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ressengaer_app/screen/notices.dart';

import '../Authentication/confirm.dart';
import '../constants.dart';

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
      items: const [
        TabItem(icon: Icons.notifications, title: ''),
        TabItem(icon: FontAwesomeIcons.thumbtack, title: '',),
        TabItem(icon: Icons.work_rounded, title: ''),
        TabItem(icon: FontAwesomeIcons.bullhorn, title: ''),
        TabItem(icon: Icons.message, title: ''),

      ],
      initialActiveIndex: 0,
      //optional, default as 0
      onTap: (int i) {
        if (i == 0) {
          kNavigator(context, Notices());
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
