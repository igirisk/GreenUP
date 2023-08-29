import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global.dart';
import '../services/posts_Service.dart';
import 'challengeScreen.dart';

class MyDateFormatter {
  static String formatCurrentDate() {
    DateTime now = DateTime.now();
    final dateFormat = DateFormat('dd MMM yyyy');
    return dateFormat.format(now);
  }
}

class CreatePostScreen extends StatefulWidget {
  static String routeName = '/createPost';

  @override
  State<CreatePostScreen> createState() => _CreatePostScreen();
}

class _CreatePostScreen extends State<CreatePostScreen> {
  var form = GlobalKey<FormState>();

  String? username = Globals.userUsername;
  String date = MyDateFormatter.formatCurrentDate();

  String? challengeName;
  String? caption;

  void saveForm() {
    bool isVaild = form.currentState!.validate();

    if (isVaild) {
      form.currentState!.save();

      PostService fsService = PostService();
      fsService.addPost(username, date, challengeName, caption);

      //Hide the keyboard
      FocusScope.of(context).unfocus();

      //reset the form
      form.currentState!.reset();

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('post created successfully')));
      Navigator.pushReplacementNamed(context, ChallengeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    challengeName = ModalRoute.of(context)!.settings.arguments as String;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create post'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          width: screenWidth * 0.8,
          child: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        username!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    challengeName ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: 3 *
                          26.0, // Maximum of 3 lines (24.0 is the line height)
                    ),
                    child: SingleChildScrollView(
                      child: TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Add a caption', // Placeholder text
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please write a caption";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          caption = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context,
                              ChallengeScreen
                                  .routeName); // Navigate back to the previous page
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            saveForm();
                          },
                          child: const Text(
                            'Post',
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
