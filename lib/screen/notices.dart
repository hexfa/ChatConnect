import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/constants.dart';
import 'package:ressengaer_app/widgets/my_bottom_navigation_bar.dart';

class Notices extends StatelessWidget {
  const Notices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        bottomNavigationBar:mYBottomNavigationBar(context)
    ));
  }

}
