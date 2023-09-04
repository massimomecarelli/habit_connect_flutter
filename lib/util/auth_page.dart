import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_connect_flutter/community.dart';
import 'package:habit_connect_flutter/login_page.dart';
import 'package:habit_connect_flutter/signin_or_signup_page.dart';


// classe che controlla se l'utente ha fatto l'accesso, per mostrare la pagina di
// login o la home page della community
class AuthPage extends StatelessWidget {
  const AuthPage ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // lo stream sta continuamente in ascolto per vedere se lo user è loggato
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // user IS logged in
          if(snapshot.hasData){
            return Community();
          }
          // user IS NOT logged in
          else {
            return SigninOrSignupPage();
          }
        },
      ),
    );
  }
}