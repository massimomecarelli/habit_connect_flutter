import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/custom_button.dart';
import '../util/square_tile.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

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
    // se le credenziali sono errate, fa il catch dell'errore inviato da Fierabse
    try { // prova a fare il login
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // email errata
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context){
              return const CupertinoAlertDialog(title: Text('Email errata'),
              );
            },
        );
      }
      // password errata
      else if (e.code == 'wrong-password') {
        showCupertinoModalPopup(
          context: context,
          builder: (context){
            return const CupertinoAlertDialog(title: Text('Password errata'),
            );
          },
        );
      } else { // gestisce il caso di email scritta in un formato errato
        showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return const CupertinoAlertDialog(
                title: Text('Email errata'),
              );
            },
        );
      }
    }
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
                    focusedBorder: const OutlineInputBorder(
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
                testo: 'Sign In',
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
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
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