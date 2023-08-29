// Import necessary packages and files
import 'package:firebase_core/firebase_core.dart';
import 'package:template/screens/editPostScreen.dart';
import 'package:template/screens/googleRegister.dart';
import 'package:template/screens/newsScreen.dart';
import 'package:template/screens/updatePasswordScreen.dart';
import 'firebase_options.dart'; // Import Firebase options configuration
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import various screens
import 'screens/SignInScreen.dart';
import 'screens/challengeInfoScreen.dart';
import 'screens/challengeScreen.dart';
import 'screens/createPostScreen.dart';
import 'screens/friendScreen.dart';
import 'screens/gardenScreen.dart';
import 'screens/profileScreen.dart';
import 'screens/registerScreen.dart';
import 'screens/resetPasswardScreen.dart';

// Import authentication service
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with specified options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(MyApp() // Run the main app widget
      );
}

class MyApp extends StatelessWidget {
  // Define color constants
  Color darkGreen = const Color.fromARGB(255, 1, 182, 54);
  Color green = const Color.fromARGB(255, 59, 209, 111);

  AuthService authService =
      AuthService(); // Create an instance of the authentication service

  @override
  Widget build(BuildContext context) {
    // Use StreamBuilder to listen for changes in the user's authentication state
    return StreamBuilder<User?>(
      stream: authService.getAuthUser(), // Stream of the authenticated user
      builder: (context, snapshot) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: darkGreen, // Sets the app bar background color
            scaffoldBackgroundColor:
                green, // Sets the background color of scaffold
            appBarTheme: AppBarTheme(
              color: darkGreen, // Sets the app bar color
              titleTextStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Determine the initial screen based on authentication state
          home: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : snapshot.hasData
                  ? ChallengeScreen() // User is authenticated, show ChallengeScreen
                  : SignInScreen(), // User is not authenticated, show SignInScreen
          routes: {
            // Define routes for various screens
            ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
            SignInScreen.routeName: (_) => SignInScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            ChallengeScreen.routeName: (_) => ChallengeScreen(),
            GardenScreen.routeName: (_) => GardenScreen(),
            FriendScreen.routeName: (_) => FriendScreen(),
            ProfileScreen.routeName: (_) => ProfileScreen(),
            ChallengeInfoScreen.routeName: (_) => ChallengeInfoScreen(),
            CreatePostScreen.routeName: (_) => CreatePostScreen(),
            NewsScreen.routeName: (_) => NewsScreen(),
            EditPostScreen.routeName: (_) => EditPostScreen(),
            UpdatePasswordScreen.routeName: (_) => UpdatePasswordScreen(),
            GoogleRegisterForm.routeName: (_) => GoogleRegisterForm(),
          },
        );
      },
    );
  }
}
