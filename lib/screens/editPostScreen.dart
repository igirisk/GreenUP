import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:template/screens/friendScreen.dart';
import '../global.dart';
import '../services/posts_Service.dart';
import 'challengeScreen.dart';

class EditPostScreen extends StatefulWidget {
  static String routeName = '/editPost';

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  var form = GlobalKey<FormState>();

  String? username = Globals.userUsername;
  String? date = Globals.editPostDate;
  String? challengeName = Globals.editChallengeName;
  String? caption = Globals.editCaption;

  @override
  void initState() {
    super.initState();
    date = Globals.editPostDate;
    challengeName = Globals.editChallengeName;
    caption = Globals.editCaption;
  }

  void saveForm() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();

      // Update the post using the edited values
      PostService fsService = PostService();
      fsService.editPost(
        Globals.editPostId, // Provide the post ID to update the specific post
        username,
        date,
        challengeName,
        caption,
      );

      // Hide the keyboard
      FocusScope.of(context).unfocus();

      // Reset the form
      form.currentState!.reset();

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post edited successfully')));

      // Navigate back to the previous page
      Navigator.pushReplacementNamed(context, ChallengeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Post'),
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
                        date!,
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
                    challengeName!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: caption ?? '',
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Caption',
                      hintText: 'Add a caption',
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            FriendScreen.routeName,
                          );
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          saveForm();
                          Navigator.pushReplacementNamed(
                            context,
                            FriendScreen.routeName,
                          );
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyDateFormatter {
  static String formatCurrentDate() {
    DateTime now = DateTime.now();
    final dateFormat = DateFormat('dd MMM yyyy');
    return dateFormat.format(now);
  }
}
