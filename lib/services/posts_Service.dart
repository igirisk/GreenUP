import 'package:cloud_firestore/cloud_firestore.dart';

import '../global.dart'; // Import your global variables
import '../models/post.dart'; // Import the Post class

// PostService class
class PostService {
  // Method to add a post to the 'posts' collection in Firestore
  addPost(username, date, challengeName, caption) {
    return FirebaseFirestore.instance.collection('posts').add({
      'username': username,
      'date': date,
      'challengeName': challengeName,
      'caption': caption,
    });
  }

  // Method to delete a post by its ID
  deletePost(id) {
    return FirebaseFirestore.instance.collection('posts').doc(id).delete();
  }

  // Method to get a stream of posts (excluding the user's own posts)
  Stream<List<Post>> getPost() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map<Post>(
                (doc) => Post.fromMap(doc.id, doc.data()),
              )
              .where(
                  (post) => post.username != Globals.userUsername) // Filter the posts here
              .toList(),
        );
  }

  // Method to get a stream of the user's own posts
  Stream<List<Post>> getMyPost() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map<Post>(
                (doc) => Post.fromMap(doc.id, doc.data()),
              )
              .where(
                  (post) => post.username == Globals.userUsername) // Filter the posts here
              .toList(),
        );
  }

  // Method to edit a post by its ID
  editPost(id, username, date, challengeName, caption) {
    return FirebaseFirestore.instance.collection('posts').doc(id).update({
      'username': username,
      'date': date,
      'challengeName': challengeName,
      'caption': caption,
    });
  }

  // Method to update the username in all posts where it's the current username
  Future<void> updateUsernameInPosts(
      String currentUsername, String newUsername) async {
    // Query for posts with the current username
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('posts')
        .where('username', isEqualTo: currentUsername)
        .get();

    // Update each post in the query result
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(document.id)
          .update({
        'username': newUsername,
      });
    }
  }
}
