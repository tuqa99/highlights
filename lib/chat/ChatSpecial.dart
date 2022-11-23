import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class ChatSpecial extends StatefulWidget {
  @override
  State<ChatSpecial> createState() => _ChatSpecialState();
}

class _ChatSpecialState extends State<ChatSpecial> {
  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('chat');
    User? auth = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: collection.doc(auth!.email).get().asStream(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data();
            List _emails = data!['usersemail'];
            List _names = data['usersname'];
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleSpacing: 00.0,
                centerTitle: true,
                toolbarHeight: 60.2,
                toolbarOpacity: 0.8,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                ),
                elevation: 0.00,
                title: Text(
                  "Chat",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Color.fromARGB(255, 162, 212, 244),
              ),
              body: ListView.separated(
                itemCount: _emails.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 5,
                    thickness: 2,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 162, 212, 244),
                      child: Text(
                        '${_emails[index][0]}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(_emails[index]),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ChatScreen1(
                            email: _emails[index],
                            name: _names[index],
                          );
                        },
                      ));
                    },
                    trailing: Icon(Icons.arrow_forward_outlined),
                  );
                },
              ),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
