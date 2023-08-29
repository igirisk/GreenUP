import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/challenge.dart'; // Import the Challenge class

// ChallengesService class
class ChallengesService {
  // Method to get a stream of challenge data
  Stream<List<Challenge>> getChallenges() {
    // Return a stream of challenges from the 'challenges' collection in Firestore
    return FirebaseFirestore.instance.collection('challenges').snapshots().map(
          (snapshot) => snapshot.docs
              .map<Challenge>(
                // Convert each document snapshot to a Challenge object
                (doc) => Challenge.fromMap(doc.id, doc.data()),
              )
              .toList(), // Convert the List<Challenge> to a List
        );
  }
}
