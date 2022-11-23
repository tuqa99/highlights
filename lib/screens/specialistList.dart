import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/specialist/SpicialistVeiwuser.dart';

class SpecialistList extends StatefulWidget {
  SpecialistList(this.CollectionName);
  String? CollectionName;

  @override
  State<SpecialistList> createState() => _SpecialistsListState();
}

class _SpecialistsListState extends State<SpecialistList> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    int? rating;
    String? _profileimage;
    CollectionReference ref =
        FirebaseFirestore.instance.collection(widget.CollectionName!);

    var documents = ref.snapshots();
    ratingAva(DocumentSnapshot document) {
      List allRatings = document['rating'];
      num length = allRatings.length;
      if (length > 1) {
        length = length - 1;
      }
      num sum = 0;
      print(length);
      for (int i = 0; i < allRatings.length; i++) {
        num index = allRatings[i];
        sum += index;
      }
      double ava = sum / length;
      return ava;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        elevation: 0.00,
        title: Text(
          "${widget.CollectionName}",
          style: TextStyle(color: Theme.of(context).highlightColor),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: documents,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(snapshot.data!.docs.length, (index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  String fullName = document['full name'];

                  ratingAva(document);
                  print(ratingAva(document));
                  return InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Specialistprofileforuser(
                              firstname: document['full name'],
                              email: document['email'],
                              profilephotpurl: document['imageprofileurl'],
                              CollectionName: widget.CollectionName,
                              index: index,

                              // career: document['service']),
                            ),
                          ));
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          width: .5,
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Theme.of(context).cardColor,
                      ),
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(document['imageprofileurl'])),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              fullName.toUpperCase(),
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RatingBarIndicator(
                              itemSize: 21,
                              rating: ratingAva(document),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
