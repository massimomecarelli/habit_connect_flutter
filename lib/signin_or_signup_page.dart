import 'package:flutter/material.dart';
import 'package:habit_connect_flutter/login_page.dart';
import 'package:habit_connect_flutter/register_page.dart';


class SigninOrSignupPage extends StatefulWidget {
  const SigninOrSignupPage({super.key});

  @override
  State<SigninOrSignupPage> createState() => _SigninOrSignupPageState();
}

class _SigninOrSignupPageState extends State<SigninOrSignupPage> {

  // inizialmente mostra la pagina di sign in
  bool showSigninPage = true;

  // toggle tra la pagina di sign in e sign up
  void togglePages(){
    setState(() {
      showSigninPage = !showSigninPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSigninPage) {
      return LoginPage(
          onTap: togglePages,
      );
    } else{
      return RegisterPage(
          onTap: togglePages,
      );
    }
  }
  
}
