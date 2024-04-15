import 'package:flutter/material.dart';
import 'package:demo_poll/Providers/authentication_provider.dart';
import 'package:demo_poll/Providers/bottom_nav_provider.dart';
import 'package:demo_poll/Screens/BottomNavPages/Account/accounts_page.dart';
import 'package:demo_poll/Screens/BottomNavPages/Home/home_page.dart';
import 'package:demo_poll/Screens/BottomNavPages/MyPolls/my_polls.dart';
import 'package:provider/provider.dart';

class MainActivityPage extends StatefulWidget {
  const MainActivityPage({super.key});

  @override
  State<MainActivityPage> createState() => _MainActivityPageState();
}

class _MainActivityPageState extends State<MainActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(builder: (context, nav, child) {
      return Scaffold(
        body: _pages[nav.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting, //shifting
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFFC7E7F3),

          items: _items,
          currentIndex: nav.currentIndex,
          onTap: (value) {
            nav.changeIndex = value;
          },
        ),
      );
    });
  }

  List<Widget> _pages = [HomePage(), MyPolls(), AccountPage()];

  List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: Color(0xFF5AC7F0),),
    BottomNavigationBarItem(icon: Icon(Icons.poll), label: "My Polls", backgroundColor: Color(0xFF5AC7F0),),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Accounts", backgroundColor: Color(0xFF5AC7F0)),
  ];
}
