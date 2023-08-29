import 'package:flutter/material.dart';

import '../widgets/SignInForm.dart';
import 'registerScreen.dart';
import 'resetPasswardScreen.dart';

class SignInScreen extends StatelessWidget {
  //declareRoute
  static String routeName = '/signIn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/signin.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topCenter, // Aligns the column to the top
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'GreenUP',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Text(
                          'Join us in building a greener future. Sign in to our sustainability app and make a difference today!',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      SignInForm(),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, ResetPasswordScreen.routeName);
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterScreen.routeName);
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
