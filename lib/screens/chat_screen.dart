import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/ChatMain.dart';
import '../chat/messages.dart';
import '../chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({required this.email, required this.name, this.docid});
  String? email;
  String? name;
  String? docid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 162, 212, 244),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(
                email: email,
              ),
            ),
            NewMessage(
              name: name,
              email: email,
              docid: docid,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen1 extends StatelessWidget {
  ChatScreen1({required this.email, this.name, this.docid});
  String? email;
  String? name;
  String? docid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messagespecial(
                email: email,
              ),
            ),
            NewMessages1(
              name: name,
              email: email,
              docid: docid,
            ),
          ],
        ),
      ),
    );
  }
}
