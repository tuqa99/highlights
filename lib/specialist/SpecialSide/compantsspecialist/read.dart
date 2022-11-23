import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Read_component1 extends StatelessWidget {
  const Read_component1({super.key});

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final docId = auth!.uid;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('specialist')
          .doc(docId)
          .collection("addpakeges")
          .get()
          .asStream(),
      builder: (context, AsyncSnapshot packgeSnapshot) {
        if (packgeSnapshot.connectionState == ConnectionState.waiting &&
            !packgeSnapshot.hasData) {
          if (packgeSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("Doesn't have any work yet"),
            );
          }
        }
        final packgeDocs = packgeSnapshot.data!.docs;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: packgeDocs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 22, left: 22),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('press to see more details'),
                    Text(
                      ' sale ${packgeDocs[index]['discount']}',
                      style: TextStyle(color: Colors.red),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("packeges detailes"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    child: Text(
                                        ' ${packgeDocs[index]['descripution']}')),
                                Text(
                                    'discount  ${packgeDocs[index]['discount']}')
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                                image: AssetImage(
                                    '${packgeDocs[index]['imagepacges']}'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Readbackgesforuser extends StatelessWidget {
  Readbackgesforuser({required this.emial});
  String? emial;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('specialist')
          .doc(emial)
          .collection('addpakeges')
          .get()
          .asStream(),
      builder: (context, AsyncSnapshot packgeSnapshot) {
        if (packgeSnapshot.connectionState == ConnectionState.waiting &&
            !packgeSnapshot.hasData) {
          if (packgeSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("Doesn't have any work yet"),
            );
          }
        }
        final packgeDocs = packgeSnapshot.data!.docs;

        if (packgeSnapshot.hasData) {
          // print('${packgeDocs['descripution']}');
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: packgeDocs.length,
            itemBuilder: (context, index) {
              print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
              print('${emial}');
              return Padding(
                padding: const EdgeInsets.only(right: 22, left: 22),
                child: Container(
                  width: 100,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('press to see more details'),
                      Text(
                        ' sale ${packgeDocs[index]['discount']}',
                        style: TextStyle(color: Colors.red),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("packeges detailes"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      child: Text(
                                          ' ${packgeDocs[index]['descripution']}')),
                                  Text(
                                      'discount  ${packgeDocs[index]['discount']}')
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                  image: AssetImage(
                                      '${packgeDocs[index]['imagepacges']}'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
