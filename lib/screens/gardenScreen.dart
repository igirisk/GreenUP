import 'package:flutter/material.dart';
import 'package:template/screens/signInScreen.dart';

import '../widgets/bottomNavBar.dart';
import '../widgets/treeList_separated.dart';

class GardenScreen extends StatefulWidget {
  static String routeName = '/garden';

  @override
  _GardenScreenState createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  int _selectedIndex = 1; // Initialize with the desired selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9;

    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Garden',
        ),
      ),
      body: Center(
          child: Container(
              width: containerWidth,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_ios)),
                      const Expanded(
                          child: Text(
                        'date',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Image.asset(
                        'images/garden.jpg'), // The image to be displayed as the background
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text('0'),
                        const SizedBox(width: 3),
                        SizedBox(
                            width: 20, child: Image.asset('images/grown.jpg')),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        const Text('0'),
                        const SizedBox(width: 3),
                        SizedBox(
                            width: 20,
                            child: Image.asset('images/withered.jpg')),
                      ],
                    ),
                  ],
                ),
              ]))),
    );
  }
}
