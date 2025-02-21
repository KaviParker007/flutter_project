import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import 'ActivityScreen.dart';
import 'ExploreScreen.dart';
import 'MarketPlaceScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  List<dynamic> marketplaceRequests = [];
  bool isLoading = true;
  String errorMessage = '';
  final List _pages = const [
    ExploreScreen(),
    MarketplaceScreen(),
    SearchScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  int _currentIndex = 1;
  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Marketplace',
                style: TextStyle(
                  color: HexColor("#F7F2F9"),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )
            ),
            Image.asset("assets/images/Vector2.png",
              width: 15,
              height: 15,
              fit: BoxFit.cover,
            ),
          ],
        ),
        gradient: LinearGradient(
          colors: [HexColor("#FF7304"), HexColor("#FB2A77")],
        ),
      ),

      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          // selectedLabelStyle: TextStyle(color: primaryColor),
          selectedFontSize: 12,
          selectedItemColor: HexColor("#1F1F1F"),
          unselectedItemColor: HexColor("#AAAAAA"),
          items:  [
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.building_broadcast_tower, color:HexColor("#AAAAAA")),
              activeIcon:  Icon(TablerIcons.building_broadcast_tower, color: HexColor("#E71313")),
              label: "Explore",
            ),

            BottomNavigationBarItem(
              icon: Stack(
                children: <Widget>[
                   Icon(TablerIcons.home, color: HexColor("#AAAAAA")),
                   Positioned(
                    top: 0,
                    left: 5,
                    child:  Container(

                      padding: const EdgeInsets.all(1),
                      decoration:  BoxDecoration(
                        color: HexColor("#E71313"),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 12,
                      ),
                      child:  Text(
                        'NEW',
                        style:  TextStyle(
                          color: HexColor("#FFFFFF"),
                          fontSize: 6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              activeIcon: Stack(
                children: <Widget>[
                   Icon(TablerIcons.home, color: HexColor("#E71313")),
                   Positioned(
                    top: 0,
                    left: 5,
                    child:  Container(

                      padding: const EdgeInsets.all(1),
                      decoration:  BoxDecoration(
                        color: HexColor("#E71313"),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 12,
                      ),
                      child:  Text(
                        'NEW',
                        style:  TextStyle(
                          color: HexColor("#FFFFFF"),
                          fontSize: 6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              label: "Marketplace",
            ),

            BottomNavigationBarItem(
              icon: Icon(TablerIcons.search, color: HexColor("#AAAAAA")),
              activeIcon:  Icon(TablerIcons.search, color: HexColor("#E71313")),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.clock_exclamation, color: HexColor("#AAAAAA"),),
              activeIcon:  Icon(TablerIcons.clock_exclamation, color: HexColor("#E71313")),
              label: "Activity",
            ),
            BottomNavigationBarItem(
              icon: Icon(TablerIcons.user, color: HexColor("#AAAAAA"),),
              activeIcon:  Icon(TablerIcons.user, color: HexColor("#E71313")),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

