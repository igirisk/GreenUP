import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:template/screens/challengeScreen.dart';
import '../services/auth_service.dart';
import '../global.dart';
import '../services/profile_Service.dart';

class SignInForm extends StatefulWidget {
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  String? email;
  String? password;
  bool isLoading = false;
  var form = GlobalKey<FormState>();

  void setProfile(email) {
    ProfileService fsService = ProfileService();

    fsService
        .getProfileByEmail(email!)
        .listen((List<DocumentSnapshot<Map<String, dynamic>>> snapshots) {
      // This callback is called whenever the stream emits a new snapshot
      // You can access the data in the snapshots here
      if (snapshots.isNotEmpty) {
        // Assuming you have the 'challengeName' field in your Firestore document
        Map<String, dynamic>? data = snapshots.first.data();
        String id = snapshots.first.id;
        debugPrint("Data from Firestore: $data");
        Globals.userEmail = email;
        Globals.userId = id; // Assign the ID to Globals.userId
        Globals.userPfp = data!['pfp'];
        Globals.userUsername = data['username'];
      } else {
        debugPrint("No data found for the provided email.");
      }
    });
  }

  login() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      AuthService authService = AuthService();
      authService.login(email, password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login successfully!'),
        ));
        Navigator.pushReplacementNamed(context, ChallengeScreen.routeName);

        // Call setProfile after successful login
        setProfile(email);
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null)
                  return "Please provide an email address.";
                else if (!value.contains('@'))
                  return "Please provide a valid email address.";
                else
                  return null;
              },
              onSaved: (value) {
                email = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null)
                  return 'Please provide a password.';
                else if (value.length < 6)
                  return 'Password must be at least 6 characters.';
                else
                  return null;
              },
              onSaved: (value) {
                password = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
              ),
              onPressed: () {
                login();
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
              '----------------------------- or ------------------------------'),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              setState(() {
                isLoading = true;
              });

              final AuthService _authService = AuthService();
              final userCredential = await _authService.signInWithGoogle();

              setState(() {
                isLoading = false;
              });

              if (userCredential != null) {
                final user = userCredential.user;

                Globals.userUsername = user?.displayName;

                setProfile(user?.email);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Signed in with Google: ${user?.displayName ?? "Unknown"}'),
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.pushReplacementNamed(
                    context, ChallengeScreen.routeName);

                // Additional code...
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Google sign-in failed.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/google.png',
                  width: 50,
                  height: 50,
                ),
                if (isLoading) CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
