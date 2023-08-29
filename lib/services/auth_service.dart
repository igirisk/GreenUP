import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../global.dart'; // Import your global variables
import 'profile_Service.dart'; // Import the ProfileService class

// AuthService class
class AuthService {
  // Method to register a user with email and password
  Future<UserCredential> register(email, password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // Method to log in a user with email and password
  Future<UserCredential> login(email, password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  // Method to send a password reset email
  Future<void> forgotPassword(email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // Method to get the authentication user using a stream
  Stream<User?> getAuthUser() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // Method to update the password of the currently logged-in user
  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        print("Password updated successfully");
      } else {
        print("No user is currently logged in");
      }
    } catch (error) {
      print("Error updating password: $error");
    }
  }

  // Method to log out the current user
  logOut() {
    return FirebaseAuth.instance.signOut();
  }

  //-----------------------google---------------------------
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        return authResult; // Return the UserCredential
      }
    } catch (error) {
      print("Error signing in with Google: $error");
    }

    return null; // Return null if sign-in fails
  }
}
