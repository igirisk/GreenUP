import 'package:flutter/material.dart';
import 'package:template/widgets/yourImpact.dart';

import '../models/challenge.dart';
import '../services/challenges_Service.dart';
import 'challengeScreen.dart';

class ChallengeInfoScreen extends StatefulWidget {
  static String routeName = '/challengeInfo';

  @override
  _ChallengeInfoScreenState createState() => _ChallengeInfoScreenState();
}

class _ChallengeInfoScreenState extends State<ChallengeInfoScreen> {
  late int i;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    i = int.parse(ModalRoute.of(context)!.settings.arguments as String? ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    ChallengesService fsService = ChallengesService();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth * 0.9;

    return StreamBuilder<List<Challenge>>(
        stream: fsService.getChallenges(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  body: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.3,
                            width: double.infinity,
                            child: Image.asset(
                              snapshot.data![i].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 30.0,
                            left: 10.0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, ChallengeScreen.routeName);
                              },
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.15,
                            left: screenWidth * 0.05,
                            child: Container(
                                color: const Color.fromARGB(153, 0, 0, 0),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data![i].name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300))),
                          )
                        ],
                      ),
                      Center(
                          child: SizedBox(
                              width: containerWidth,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      snapshot.data![i].description,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: const [
                                              Icon(Icons.public),
                                              Text(
                                                'Yearly Imapct',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            YourImpact(
                                                text: snapshot
                                                    .data![i].waterSaved,
                                                saved: 'Liters Saved',
                                                image: 'images/water.jpg'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: YourImpact(
                                                  text: snapshot
                                                      .data![i].carbonSaved,
                                                  saved: 'Kilos Saved',
                                                  image: 'images/carbon.jpg'),
                                            ),
                                            YourImpact(
                                                text: snapshot
                                                    .data![i].wasteSaved,
                                                saved: 'Kilos Saved',
                                                image: 'images/waste.jpg')
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    ],
                  ),
                );
        });
  }
}
