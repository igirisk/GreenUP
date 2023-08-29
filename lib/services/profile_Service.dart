import 'package:cloud_firestore/cloud_firestore.dart';

// ProfileService class
class ProfileService {
  // Method to add a profile to the 'profiles' collection in Firestore
  addProfile(username, pfp, email) {
    return FirebaseFirestore.instance
        .collection('profiles')
        .add({'username': username, 'pfp': pfp, 'email': email});
  }

  // Method to delete a profile by its ID
  deleteProfile(id) {
    return FirebaseFirestore.instance.collection('profiles').doc(id).delete();
  }

  // Method to get a stream of profiles based on target email
  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getProfileByEmail(
      String targetEmail) {
    return FirebaseFirestore.instance
        .collection('profiles')
        .where('email', isEqualTo: targetEmail)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs;
    });
  }

  // Method to edit a profile by its ID
  Future<bool> editProfile(id, username, pfp, email) async {
    try {
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(id)
          .update({'username': username, 'pfp': pfp});
      return true; // Return true if the update was successful
    } catch (e) {
      print('Error updating profile: $e');
      return false; // Return false if the update failed
    }
  }
}
