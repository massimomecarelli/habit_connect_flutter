import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_button.dart';


class NewTaskDialog extends StatelessWidget {
  final controller1;
  final controller2;
  VoidCallback onSave;

  NewTaskDialog({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("New Task",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.lightBlue),
            ),
            // get user input
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Task",
              ),
            ),
    ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Obiettivo",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
                // save button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                FloatingActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  shape: StadiumBorder(),
                  backgroundColor: Colors.lightBlue,
                  child:
                  Icon(Icons.close, color: Colors.white,),
                ),
                SizedBox(width: 20),
                //MyButton(text: "Save", onPressed: onSave),
                FloatingActionButton(
                  shape: StadiumBorder(),
                  onPressed: onSave,
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