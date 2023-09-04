
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  Community({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  // metodo che esegue il sign out dell'utente
  void signOut (){
    FirebaseAuth.instance.signOut();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))]
      ),
      body: Center(child: Text("ciao"),
      ),
    );
  }
}