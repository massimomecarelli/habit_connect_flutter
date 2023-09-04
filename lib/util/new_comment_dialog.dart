import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';



class NewCommentDialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;

  NewCommentDialog({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("New Tip",
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.lightBlue),
          ),
          // get user input
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              maxLines: 9,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Testo",
              ),
            ),
          ),
          // save button
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  shape: StadiumBorder(),
                  elevation: 0,
                  backgroundColor: Colors.lightBlue,
                  child:
                  Icon(Icons.close, color: Colors.white,),
                ),
                SizedBox(width: 20),
                //MyButton(text: "Save", onPressed: onSave),
                FloatingActionButton(
                  shape: StadiumBorder(),
                  onPressed: onSave,
                  elevation: 0,
                  backgroundColor: Colors.lightBlue,
                  child:
                  Icon(Icons.check, color: Colors.white,),
                ),
                SizedBox(width: 20),
              ]
          ),
        ],
      ),
    );
  }
}