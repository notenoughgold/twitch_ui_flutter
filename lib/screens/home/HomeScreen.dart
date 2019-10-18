import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitch_ui_flutter/screens/home/BrowsePage.dart';
import 'package:twitch_ui_flutter/screens/home/DiscoverPage.dart';
import 'package:twitch_ui_flutter/screens/home/FollowingPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _createPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return FollowingPage();
        break;
      case 1:
        return DiscoverPage();
        break;
      default:
        return BrowsePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart),
              activeIcon: Icon(FontAwesomeIcons.solidHeart),
              title: Text('Following'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.compass),
              activeIcon: Icon(
                FontAwesomeIcons.solidCompass,
              ),
              title: Text('Discover'),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.clone),
              activeIcon: Icon(FontAwesomeIcons.solidClone),
              title: Text('Browse'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: _createPage(context, _selectedIndex));
  }
}
