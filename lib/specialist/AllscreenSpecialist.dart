import 'package:flutter/material.dart';
import 'package:highlights/UserScreens/userProfile/profile.dart';
import 'package:highlights/screens/chat_screen.dart';
import 'package:highlights/specialist/specialistprofile.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class SpecialistMain extends StatefulWidget {
  const SpecialistMain({Key? key}) : super(key: key);

  @override
  _SpecialistMainState createState() => _SpecialistMainState();
}

class _SpecialistMainState extends State<SpecialistMain> {
  late PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        activeColor: const Color(0xFF560027),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.chat,
            title: 'Chat',
          ),
        ],
      ),
    );
  }
}

// icon size:24 for fontAwesomeIcons
// icons size: 30 for MaterialIcons

List<Widget> _listOfWidget = <Widget>[
  Specialistprofileforedit(),
  ChatScreen(),
];