import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:template/screens/profileScreen.dart';
import '../global.dart';
import '../services/auth_service.dart';
import '../services/posts_Service.dart';
import '../services/profile_Service.dart';
import '../widgets/bottomNavBar.dart';
import 'SignInScreen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';

  @override
  _UpdatePasswordScreen createState() => _UpdatePasswordScreen();
}

class _UpdatePasswordScreen extends State<UpdatePasswordScreen> {
  String? password;
  String? confirmPassword;

  var passwordForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update Password',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(5)),
            child: Form(
              key: passwordForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
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
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        prefixIcon: const Icon(Icons.lock),
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
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, ProfileScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.red, // Set the desired background color
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.green, // Set the desired background color
                        ),
                        onPressed: () async {
                          if (passwordForm.currentState!.validate()) {
                            passwordForm.currentState!.save();
                            if (password != confirmPassword) {
                              FocusScope.of(context).unfocus();
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Password and Confirm Password do not match!'),
                              ));
                            } else {
                              passwordForm.currentState!.save();
                              AuthService authService = AuthService();
                              try {
                                await authService.updatePassword(password!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Password updated successfully')),
                                );
                                Navigator.pushReplacementNamed(
                                    context, ProfileScreen.routeName);
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error updating password: $error')),
                                );
                              }
                            }
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
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
