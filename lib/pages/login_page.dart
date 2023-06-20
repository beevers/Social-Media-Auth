import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:media_authentication/components/my_button.dart';
import 'package:media_authentication/components/my_textfield.dart';
import 'package:media_authentication/components/square_tile.dart';
import 'package:media_authentication/services/auth_service.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            appBar: AppBar(title: const Text("Logged In As")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FirebaseAuth.instance.currentUser!.photoURL != null ? ClipOval(child: Image.network(FirebaseAuth.instance.currentUser!.photoURL.toString())) : const Icon(Icons.account_circle_outlined),
              Text("Name: ${FirebaseAuth.instance.currentUser!.displayName!}",style: const TextStyle(fontSize: 25),),
              Text("Email: ${FirebaseAuth.instance.currentUser!.email!}",style: const TextStyle(fontSize: 25),),
              Text("Created: ${DateFormat('MM/dd/yyyy').format(snapshot.data!.metadata.creationTime as DateTime)}",style: const TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ) ,
    );
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[300],
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
    
                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
    
                  const SizedBox(height: 50),
    
                  // welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
    
                  const SizedBox(height: 25),
    
                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
    
                  const SizedBox(height: 10),
    
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
    
                  const SizedBox(height: 10),
    
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
    
                  const SizedBox(height: 25),
    
                  // sign in button
                  MyButton(
                    onTap: signUserIn,
                  ),
    
                  const SizedBox(height: 50),
    
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
    
                  const SizedBox(height: 50),
    
                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      // google button
                      SquareTile(imagePath: 'lib/images/google.png',onTap:()=> AuthService().signInWithGoogle(),),
    
                      const SizedBox(width: 25),
    
                      // apple button
                      SquareTile(imagePath: 'lib/images/apple.png',onTap: (){},)
                    ],
                  ),
    
                  const SizedBox(height: 50),
    
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
