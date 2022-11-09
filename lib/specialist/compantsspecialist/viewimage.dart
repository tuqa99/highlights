import "package:flutter/material.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Viewimages extends StatelessWidget {
  const Viewimages({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference packgesRef =
        FirebaseFirestore.instance.collection("addimages");
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          return Container(
              child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await packgesRef
                                        .doc(snapshot.data!.docs[i].id)
                                        .delete();
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                          Image(
                              height: 50,
                              width: 100,
                              image: NetworkImage(
                                  "${snapshot.data!.docs[i]['url']}")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                  )
                ],
              );
            },
          ));
        },
        future: packgesRef.get(),
      ),
    );
  }
}

class Viewimagesforuser extends StatelessWidget {
  const Viewimagesforuser({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference packgesRef =
        FirebaseFirestore.instance.collection("addimages");
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          return Container(
              child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
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
                          Image(
                              height: 50,
                              width: 100,
                              image: NetworkImage(
                                  "${snapshot.data!.docs[i]['url']}")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                  )
                ],
              );
            },
          ));
        },
        future: packgesRef.get(),
      ),
    );
  }
}
