import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/custom_button.dart';
import '../util/square_tile.dart';
import 'dart:developer';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    super.initState();
  }


  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();



  // metodo che implementa la registrazione
  void signUserUp() async {

    try {
      if (passwordController.text.length < 6){
        showDialog(
            context: context,
            builder: (context){
              return const CupertinoAlertDialog(title: Text('La Password deve contenere almeno 6 caratteri'),
              );
            }
        );
      }
      // controlla che la password e la coferma coincidano
      else if (passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showDialog(
            context: context,
            builder: (context){
              return const CupertinoAlertDialog(title: Text('Password diverse'),
              );
            }
        );
      }

    } on FirebaseAuthException catch (e) {
        // gestisce il caso in cui il formato email non è corretto
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return const CupertinoAlertDialog(
              title: Text('Formato Email non corretto'),
            );
          },
        );

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
                Icons.account_circle_outlined,
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
                      focusedBorder: const OutlineInputBorder(
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

              const SizedBox(height: 10),

              // conferma password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: confirmPasswordController,
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
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),


              const SizedBox(height: 35),

              // sign in button
              MyButton(
                testo: 'Sign Up',
                onTap: signUserUp, // assegno al tap il metodo implementato sopra
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already registered?, ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Sign In',
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