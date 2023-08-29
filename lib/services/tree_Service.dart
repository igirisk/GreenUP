import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tree.dart'; // Import the Tree class

// TreeService class
class TreeService {
  // Method to add a tree to the 'trees' collection in Firestore
  addTree(username, date, status, treeImage) {
    return FirebaseFirestore.instance.collection('trees').add({
      'username': username,
      'date': date,
      'status': status, // Corrected field name
      'treeImage': treeImage, // Corrected field name
    });
  }

  // Method to get a stream of filtered trees
  Stream<List<Tree>> getFilteredTrees() {
    return FirebaseFirestore.instance.collection('trees').snapshots().map(
          (snapshot) => snapshot.docs
              .map<Tree>(
                (doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  String username = data['username'];
                  if (username == 'joshi') {
                    return Tree.fromMap(doc.id, data);
                  } else {
                    // Return an empty Tree or null for trees with other usernames
                    return Tree(
                      id: doc.id,
                      username: '',
                      date: '',
                      status: '',
                      treeImage: '',
                    );
                    ;
                  }
                },
              )
              .where((tree) => tree.username != '') // Filter out null values
              .toList(),
        );
  }
}
