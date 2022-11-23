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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${packgeDocs[index]['descripution']}'),
                    Text('${packgeDocs[index]['discount']}'),
                    Image(
                        image:
                            AssetImage('${packgeDocs[index]['imagepacges']}'))
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
          return ListView.builder(
            itemCount: packgeDocs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 22, left: 22),
                child: Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${packgeDocs[index]['descripution']}'),
                      Text('${packgeDocs[index]['discount']}'),
                      Image(
                          image:
                              AssetImage('${packgeDocs[index]['imagepacges']}'))
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
