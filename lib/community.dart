
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_connect_flutter/util/new_comment_dialog.dart';
import 'util/comment.dart';

class Community extends StatefulWidget {
  Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  // prende l'utente attualmente registrato
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('commenti');
  final _controller = TextEditingController();
  HashMap mapping = HashMap();

  // metodo che esegue il sign out dell'utente
  void signOut (){
    FirebaseAuth.instance.signOut();
  }

  void createNewComment() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewCommentDialog(
          controller: _controller,
          onSave: saveNewComment,
        );
      },
    );
  }

  void saveNewComment() {
    setState(() {
      if (_controller.text.isEmpty){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Inserisci del testo")));
      } else {
        Map <String, dynamic> mapping = {
          "testo": _controller.text,
          "user": user.email,
          "timestamp": Timestamp.now(),
        };
        collectionReference.add(mapping);
        _controller.clear();
      }
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: const Text("Community",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
          backgroundColor: Colors.blue.shade400,
          actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout, color: Colors.white,))]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewComment,
        child: Icon(Icons.add, color: Colors.white,),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
        ),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Center(
          child: Column(
            children: [
              Expanded(child: StreamBuilder(
                stream: collectionReference
                    .orderBy("timestamp", descending: true,)
                    .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                      final comment = snapshot.data!.docs[index];
                      return Comment(
                        testo: comment["testo"],
                        user: comment['user'],
                        timestamp: comment['timestamp'],
                      );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ))
            ],
          ),
      ),
    );
  }
}