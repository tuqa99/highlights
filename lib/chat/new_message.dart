import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  NewMessage({required this.email, required this.name, this.docid});
  String? email;
  String? name;
  String? docid;
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  List specialemails = [];
  List specialnames = [];
  List usersemails = [];
  List usersnames = [];

  void _sendMessage() async {
    var doc = widget.email.toString();
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    FirebaseFirestore.instance
        .collection('chat')
        .doc(user.email)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'usersemail': user.email,
      'usersname': userData['first name'],
      'serviceemail': widget.email,
      'servicename': widget.name,
      "sender": true
    });
    specialemails.add(widget.email);
    specialnames.add(widget.name);

    FirebaseFirestore.instance.collection('chat').doc(user.email).update({
      'serviceemail': FieldValue.arrayUnion(specialemails),
      'servicename': FieldValue.arrayUnion(specialnames),
    });

    FirebaseFirestore.instance
        .collection('chat')
        .doc(doc)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'serviceemail': widget.email,
      'servicename': widget.name,
      'usersemail': user.email,
      'usersname': userData['first name'],
      "sender": false
    });
    usersemails.add(user.email);
    usersnames.add(widget.name);
    FirebaseFirestore.instance.collection('chat').doc(doc).update({
      'usersemail': FieldValue.arrayUnion(usersemails),
      'usersname': FieldValue.arrayUnion(usersnames),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}

class NewMessages1 extends StatefulWidget {
  NewMessages1({required this.email, required this.name, this.docid});
  String? email;
  String? name;
  String? docid;
  @override
  _NewMessages1State createState() => _NewMessages1State();
}

class _NewMessages1State extends State<NewMessages1> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  List specialemails = [];
  List specialnames = [];
  List usersemails = [];
  List usersnames = [];

  void _sendMessage() async {
    var doc = widget.email.toString();
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('specialist')
        .doc(user!.uid)
        .get();

    FirebaseFirestore.instance
        .collection('chat')
        .doc(user.email)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'usersemail': widget.email,
      'usersname': widget.name,
      'serviceemail': user.email,
      'servicename': userData['first name'],
      "sender": true
    });
    usersemails.add(widget.email);
    usersnames.add(widget.name);

    FirebaseFirestore.instance.collection('chat').doc(user.email).update({
      'usersemail': FieldValue.arrayUnion(usersemails),
      'usersname': FieldValue.arrayUnion(usersnames),
    });

    FirebaseFirestore.instance
        .collection('chat')
        .doc(doc)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'serviceemail': user.email,
      'servicename': userData['first name'],
      'usersemail': widget.email,
      'usersname': widget.name,
      "sender": false
    });
    specialemails.add(user.email);
    specialnames.add(widget.name);
    FirebaseFirestore.instance.collection('chat').doc(doc).update({
      'serviceemail': FieldValue.arrayUnion(specialemails),
      'servicename': FieldValue.arrayUnion(specialnames),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
