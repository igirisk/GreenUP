import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:template/screens/updatePasswordScreen.dart';
import '../global.dart';
import '../services/auth_service.dart';
import '../services/posts_Service.dart';
import '../services/profile_Service.dart';
import '../widgets/bottomNavBar.dart';
import 'SignInScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 3; // Initialize with the desired selected index

  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  var usernameForm = GlobalKey<FormState>();
  var passwordForm = GlobalKey<FormState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileService fsService = ProfileService();
    PostService postService = PostService();

    String? currentUsername;
    String? newUsername;

    String? url;

    void updateUsernameInPostsForCurrentUsername(
        String currentUsername, String newUsername) async {
      await postService.updateUsernameInPosts(currentUsername, newUsername);
      print(
          'Username updated successfully in posts for current username: $currentUsername');
    }

    Future<void> _launchURL(url) async {
      if (!await launch(url)) {
        throw Exception('Could not launch url');
      }
    }

    return Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
          ),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: CircleAvatar(
                    radius: 70,
                    foregroundImage:
                        AssetImage(Globals.userPfp ?? 'images/pfp.jpg'),
                  ),
                ),
                Text(
                  Globals.userUsername ?? '',
                  style: const TextStyle(fontSize: 30),
                ),
              ]),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Form(
                      key: usernameForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: Globals.userUsername ?? '',
                                prefixIcon: const Icon(Icons.person_2),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter a valid value';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                currentUsername = Globals.userUsername;
                                // Update the global variable regardless of the value
                                Globals.userUsername =
                                    value ?? Globals.userUsername;
                                newUsername = Globals.userUsername;
                              },
                            ),
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () async {
                                  if (usernameForm.currentState!.validate()) {
                                    usernameForm.currentState!.save();

                                    bool updateSuccess =
                                        await fsService.editProfile(
                                      Globals.userId,
                                      Globals.userUsername,
                                      Globals.userPfp,
                                      Globals.userEmail,
                                    );

                                    if (updateSuccess) {
                                      updateUsernameInPostsForCurrentUsername(
                                          currentUsername!, newUsername!);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Profile updated successfully.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Profile update failed.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(color: Colors.green),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'About Us',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  'https://twitter.com/Tesla?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor');
                            },
                            child: Image.asset(
                              'images/twitter.png', // Replace with your image asset
                              width: 50, // Set the desired width
                              height: 50, // Set the desired height
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  'https://www.facebook.com/TeslaMotorsCorp/');
                            },
                            child: Image.asset(
                              'images/facebook.png', // Replace with your image asset
                              width: 50, // Set the desired width
                              height: 50, // Set the desired height
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(
                                  'https://www.instagram.com/teslamotors/?hl=en');
                            },
                            child: Image.asset(
                              'images/instagram.png', // Replace with your image asset
                              width: 50, // Set the desired width
                              height: 50, // Set the desired height
                            ),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, UpdatePasswordScreen.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors
                                .yellow, // Set the desired background color
                          ),
                          child: const Text(
                            'Update password',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await AuthService().logOut();
                            Navigator.pushReplacementNamed(
                                context, SignInScreen.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Colors.red, // Set the desired background color
                          ),
                          child: const Text('Logout'),
                        ),
                        const Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
