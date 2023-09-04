import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_button.dart';


class NewTaskDialog extends StatelessWidget {
  final controller1;
  final controller2;
  VoidCallback onSave;

  NewTaskDialog({
    super.key,
    required this.controller1, // controller che recupera i dati inseriti in input nel field di testo
    required this.controller2, // controller che recupera i dati inseriti in input nel field dell'obiettivo
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
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Task",
              ),
            ),
    ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.lightBlue,
                  elevation: 0,
                  child:
                  const Icon(Icons.close, color: Colors.white,),
                ),
                const SizedBox(width: 20),
                //MyButton(text: "Save", onPressed: onSave),
                FloatingActionButton(
                  shape: const StadiumBorder(),
                  onPressed: onSave,
                  backgroundColor: Colors.lightBlue,
                  elevation: 0,
                  child:
                    const Icon(Icons.check, color: Colors.white,),
                ),
                const SizedBox(width: 20),
              ]
            ),
          ],
        ),
      );
  }
}