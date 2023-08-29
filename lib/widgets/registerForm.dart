import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:template/screens/googleRegister.dart';

import '../screens/SignInScreen.dart';
import '../services/auth_service.dart';
import '../services/profile_Service.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isSigningInWithGoogle = false;
  String? email;
  String? username;
  String? password;
  String? confirmPassword;
  String? pfp = 'images/pfp.jpg';

  var form = GlobalKey<FormState>();

  void saveForm() {
    bool isVaild = form.currentState!.validate();

    if (isVaild) {
      form.currentState!.save();

      ProfileService fsService = ProfileService();
      fsService.addProfile(username, pfp, email);

      //Hide the keyboard
      FocusScope.of(context).unfocus();

      //reset the form
      form.currentState!.reset();
    }
  }

  register() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      if (password != confirmPassword) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password and Confirm Password do not match!'),
        ));
      } else {
        AuthService authService = AuthService();
        authService.register(email, password).then((value) {
          saveForm();
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushReplacementNamed(context, SignInScreen.routeName);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('User Registered successfully!'),
          ));
        }).catchError((error) {
          FocusScope.of(context).unfocus();
          String message = error.toString();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        });
      }
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
                  label: Text('Email'), prefixIcon: Icon(Icons.email)),
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
                labelText: 'Username', // Changed 'label' to 'labelText'
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please provide a username.";
                else
                  return null;
              },
              onSaved: (value) {
                username = value;
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
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
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
                confirmPassword = value;
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
                register();
              },
              child: const Text(
                'Register',
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
                isSigningInWithGoogle = true; // Start signing in with Google
              });

              final AuthService _authService = AuthService();
              final userCredential = await _authService.signInWithGoogle();

              setState(() {
                isSigningInWithGoogle = false; // Done signing in with Google
              });

              if (userCredential != null) {
                final user = userCredential.user;

                ProfileService fsService = ProfileService();
                bool profileAdded = await fsService.addProfile(
                  user?.displayName,
                  pfp,
                  user?.email,
                );

                if (profileAdded) {
                  // Profile added successfully, show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Profile added successfully.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  // Profile addition failed, show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error adding profile.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
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
                if (isSigningInWithGoogle)
                  CircularProgressIndicator(), // Display indicator during sign-in
              ],
            ),
          ),
        ],
      ),
    );
  }
}
