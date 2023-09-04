import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// UI dei commenti nella community
class Comment extends StatelessWidget {
  final String testo;
  final String user;
  final Timestamp timestamp;

  const Comment({
    super.key,
    required this.testo,
    required this.user,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user,
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(timestamp.toDate().toString(),
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12),
                ),
                const SizedBox(height: 10,),
                Text(testo,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}