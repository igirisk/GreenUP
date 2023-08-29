import 'package:flutter/material.dart';

import '../widgets/bottomNavBar.dart';
import '../widgets/myPostList_sperated.dart';
import '../widgets/postList_separated.dart';

class FriendScreen extends StatefulWidget {
  static String routeName = '/friend';

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  int _selectedIndex = 2; // Initialize with the desired selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Friends',
          ),
        ),
        body: DefaultTabController(
            length: 2,
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: [
                  const TabBar(
                      indicatorColor: Colors.black,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      labelColor: Colors.black,
                      unselectedLabelStyle: TextStyle(fontSize: 20),
                      unselectedLabelColor: Colors.black38,
                      tabs: [
                        Tab(text: 'Inbox'),
                        Tab(text: 'My Post'),
                      ]),
                  Expanded(
                    child: TabBarView(
                      children: [PostListSeparated(), MyPostListSeparated()],
                    ),
                  ),
                ]))));
  }
}
