import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthService{

  

  signInWithTwitter() async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  try {
    // Trigger the Twitter sign-in flow
    final twitterCredential = TwitterAuthProvider.credential(
      accessToken: '1620905895491256320-kyXmGocAV5P8TUfkQC4Y3iz4GapPlu',
      secret: 'lFEPnw7XiY1yvMsYNwwkqmoI6q8XwApgv8ZLU080YYbHc',
    );

    // Sign in with the obtained credential
    final UserCredential userCredential = await auth.signInWithCredential(twitterCredential);

    // Access the authenticated user
    final User? user = userCredential.user;
    debugPrint(user.toString());
    
    // Perform further actions with the user
  } catch (e) {
    // Handle any errors that occur during the login process
  }

  }


  signInWithGoogle() async{
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication userAuth = await user!.authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: userAuth.accessToken,
      idToken: userAuth.idToken
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(FirebaseAuth.instance.currentUser!.displayName!),
            Text(FirebaseAuth.instance.currentUser!.email!),
          ],
        ),
      ) ,
    );
  }
}