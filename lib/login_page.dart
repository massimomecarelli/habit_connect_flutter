import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/custom_button.dart';
import 'package:habit_connect_flutter/util/my_textfield.dart';
import '../util/square_tile.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}
  class _LoginPageState extends State<LoginPage> {

    @override
    void initState() {
      super.initState();
    }


    // text editing controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();



  // metodo che implementa l'accesso
  void signUserIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    log('build signin');
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.account_circle,
                size: 100,
                color: Colors.lightBlue,
              ),

              const SizedBox(height: 75),

              // username textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),

              const SizedBox(height: 10),

              // password textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),


              const SizedBox(height: 35),

              // sign in button
              MyButton(
                onTap: signUserIn, // assegno al tap il metodo implementato sopra
              ),

              const SizedBox(height: 70),

                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not registered?, ',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}