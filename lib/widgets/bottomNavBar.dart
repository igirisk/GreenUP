import 'package:flutter/material.dart';
import 'package:template/screens/newsScreen.dart';

import '../main.dart';
import '../screens/challengeScreen.dart';
import '../screens/friendScreen.dart';
import '../screens/gardenScreen.dart';
import '../screens/profileScreen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyBottomNavigationBar(
      {required this.selectedIndex, required this.onItemTapped});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    Color sliver = Color.fromARGB(255, 227, 227, 227);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: sliver,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          label: 'Challenges',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_outlined),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_rounded),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        setState(() {
          widget.onItemTapped(index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(
                  context, ChallengeScreen.routeName);
              break;

            case 1:
              Navigator.pushReplacementNamed(context, NewsScreen.routeName);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, FriendScreen.routeName);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
              break;
          }
        });
      },
    );
  }
}
