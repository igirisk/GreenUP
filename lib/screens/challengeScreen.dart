import 'package:flutter/material.dart';
import '../models/challenge.dart';
import '../services/challenges_Service.dart';
import '../widgets/bottomNavBar.dart';
import '../widgets/challengeList_separated.dart';
import 'createPostScreen.dart';

class ChallengeScreen extends StatefulWidget {
  static String routeName = '/challenge';

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int _selectedIndex = 0; // Initialize with the desired selected index
  ChallengesService fsService = ChallengesService();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9;

    return StreamBuilder<List<Challenge>>(
      stream: fsService.getChallenges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          bottomNavigationBar: MyBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Challenge'),
          ),
          body: Center(
            child: SizedBox(
              width: containerWidth,
              child: snapshot.data!.isNotEmpty
                  ? ChallengeListSeparated()
                  : const Text("no challenges"),
            ),
          ),
        );
      },
    );
  }
}
