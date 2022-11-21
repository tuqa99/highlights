import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class ChatMain1 extends StatefulWidget {
  @override
  State<ChatMain1> createState() => _ChatMain1State();
}

class _ChatMain1State extends State<ChatMain1> {
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('chat');

    return FutureBuilder(
      future: collection.get(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {}
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
