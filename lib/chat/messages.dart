import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final docId = auth!.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'createdAt',
              descending: true,
            )
            // .where('userId', isEqualTo: docId)
            .snapshots(),
        builder: (context, AsyncSnapshot chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting &&
              !chatSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDocs[index]['text'],
              chatDocs[index]['username'],
              chatDocs[index]['userId'] == docId,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        });
  }
}
