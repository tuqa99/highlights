import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:highlights/specialist/AllscreenSpecialist.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  Messages({required this.email});
  String? email;
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final docId = auth!.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .doc(docId)
            .collection('messages')
            .where('useremail', isEqualTo: auth!.email)
            .where('specialemail', isEqualTo: email)
            .get()
            .asStream(),
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
              chatDocs[index]['useremail'] == auth!.email,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        });
  }
}

class Messagespecial extends StatelessWidget {
  Messagespecial({required this.email});
  String? email;
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final docId = auth!.uid;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where('specialemail', arrayContains: email)
            .get()
            .asStream(),
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
              chatDocs[index]['useremail'] == auth!.email,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        });
  }
}
