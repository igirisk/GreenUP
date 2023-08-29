import 'package:flutter/material.dart';

import '../global.dart';
import '../screens/SignInScreen.dart';
import '../services/auth_service.dart';
import '../services/profile_Service.dart';
import 'challengeScreen.dart';

class GoogleRegisterForm extends StatefulWidget {
  static String routeName = '/googleForm';

  @override
  State<GoogleRegisterForm> createState() => _GoogleRegisterForm();
}

class _GoogleRegisterForm extends State<GoogleRegisterForm> {
  String? username;
  String? pfp = 'images/pfp.jpg';
  String? email;

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

      Globals.userEmail = email;
      Globals.userPfp = pfp;
      Globals.userUsername = username;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.8,
                child: SingleChildScrollView(
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                label: Text('Email'),
                                prefixIcon: Icon(Icons.email)),
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
                              labelText:
                                  'Username', // Changed 'label' to 'labelText'
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
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding:
                                  const EdgeInsets.fromLTRB(50, 15, 50, 15),
                            ),
                            onPressed: () {
                              saveForm();
                              Navigator.pushReplacementNamed(
                                  context, ChallengeScreen.routeName);
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
                      ],
                    ),
                  ),
                ))));
  }
}
