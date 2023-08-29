import 'package:flutter/material.dart';
import 'package:template/screens/challengeInfoScreen.dart';
import 'package:template/screens/createPostScreen.dart';

import '../models/challenge.dart';
import '../services/challenges_Service.dart';

class ChallengeListSeparated extends StatelessWidget {
  ChallengesService fsService = ChallengesService();

  @override
  Widget build(BuildContext context) {
    //declare color
    Color buttonColor = const Color.fromARGB(255, 240, 229, 75);
    Color textBackground = const Color.fromARGB(153, 0, 0, 0);

    return StreamBuilder<List<Challenge>>(
      stream: fsService.getChallenges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        } else {
          return ListView.separated(
            itemBuilder: (ctx, i) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70.0, // Adjust the height as needed
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(snapshot.data![i].image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: textBackground,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data![i].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            ChallengeInfoScreen.routeName,
                            arguments: i.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.0, // Adjust the height as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          CreatePostScreen.routeName,
                          arguments: snapshot.data![i].name,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(buttonColor),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            '5',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ), // Adjust the spacing between text and image
                          SizedBox(
                            width: 24, // Adjust the width as needed
                            height: 24, // Adjust the height as needed
                            child: Image.asset(
                              'images/coin.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (ctx, i) {
              return const Divider(
                height: 20,
                color: Colors.transparent,
              );
            },
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }
}
