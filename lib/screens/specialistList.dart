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

    CollectionReference ref =
        FirebaseFirestore.instance.collection(widget.CollectionName!);

    var documents = ref.snapshots();
    ratingAva(DocumentSnapshot document) {
      List allRatings = document['rating'];
      int length = allRatings.length;
      if (length > 1) {
        length = length - 1;
      }
      int sum = 0;
      print(length);
      for (int i = 0; i < allRatings.length; i++) {
        int index = allRatings[i];
        sum += index;
      }
      double ava = sum / length;
      return ava;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade600,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: documents,
          builder: (context, AsyncSnapshot snapshot) {
            // print(snapshot.data);
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
                      // print(ratingAva());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Specialistprofileforuser(
                              firstname: document['full name'],
                              email: document['email'], profilephotpurl: '',
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
                          color: Color.fromRGBO(117, 117, 117, 1),
                        ),
                        color: Color.fromARGB(255, 241, 237, 239),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("images/profile.jpg"),
                            ),
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
                                    color: Colors.grey.shade900),
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
                                color: Colors.black,
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

// class SpecialistList extends StatelessWidget {
//   SpecialistList({
//     required this.CollectionName,
//     // required imageUrl,
//   });
//   String? CollectionName;
//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme.primary;
//     TextEditingController rating = TextEditingController();

//     CollectionReference ref =
//         FirebaseFirestore.instance.collection(CollectionName!);
//     var documents = ref.get();
//     Future<void> updatte([DocumentSnapshot? myDoc]) async {
//       if (myDoc != null) {
//         rating.text = myDoc['rating'].toString();
//       }
//       await showModalBottomSheet(
//           isScrollControlled: true,
//           context: context,
//           builder: (BuildContext ctx) {
//             return Padding(
//               padding: EdgeInsets.only(
//                   top: 20,
//                   left: 20,
//                   right: 20,
//                   bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RatingBar.builder(
//                       itemSize: 20,
//                       initialRating: 3,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       allowHalfRating: false,
//                       itemCount: 5,
//                       itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       itemBuilder: (context, _) {
//                         return const Icon(
//                           Icons.star,
//                           color: Color(0xffbc477b),
//                         );
//                       },
//                       onRatingUpdate: (value) {},
//                     ),

//                     // TextField(
//                     //   keyboardType:
//                     //       const TextInputType.numberWithOptions(decimal: true),
//                     //   controller: rating,
//                     //   decoration: const InputDecoration(labelText: 'rating'),
//                     // ),
//                     // const SizedBox(
//                     //   height: 20,
//                     // ),
//                     // ElevatedButton(
//                     //   child: const Text('Add'),
//                     //   onPressed: () async {
//                     //     final double? myrating = double.tryParse(rating.text);
//                     //     if (myrating != null) {
//                     //       await ref.doc(myDoc!.id).update({'rating': myrating});
//                     //       // rating. = myrating;
//                     //     }
//                     //   },
//                     // )
//                   ]),
//             );
//           });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//         titleSpacing: 00.0,
//         centerTitle: true,
//         toolbarHeight: 60.2,
//         toolbarOpacity: 0.8,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25)),
//         ),
//         elevation: 0.00,
//         title: Text(
//           "$CollectionName",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Color.fromARGB(255, 154, 53, 104).withOpacity(.6),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//           future: documents,
//           builder: (context, AsyncSnapshot snapshot) {
//             print(snapshot.data);
//             if (snapshot.hasData) {
//               return GridView.count(
//                 crossAxisCount: 2,
//                 children: List.generate(snapshot.data!.docs.length, (index) {
//                   DocumentSnapshot document = snapshot.data!.docs[index];
//                   return InkWell(
//                     onTap: (() {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Specialistprofileforuser(
//                               firstname: document['full name'],
//                               email: document['email'], profilephotpurl: '',
//                               // career: document['service']),
//                             ),
//                           ));
//                     }),
//                     child: Container(
//                         margin: const EdgeInsets.all(10),
//                         child: Column(
//                           children: [
//                             Container(
//                               width: double.infinity,
//                               margin: const EdgeInsets.only(top: 5),
//                               // height: 110,
//                               child: const Image(
//                                 height: 100,
//                                 image: AssetImage("images/avatar.webp"),
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               document['full name']!,
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xff880e4f),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             RatingBar.builder(
//                               itemSize: 20,
//                               initialRating: 3,
//                               minRating: 1,
//                               direction: Axis.horizontal,
//                               allowHalfRating: false,
//                               itemCount: 5,
//                               itemPadding:
//                                   const EdgeInsets.symmetric(horizontal: 4.0),
//                               itemBuilder: (context, _) {
//                                 return const Icon(
//                                   Icons.star,
//                                   color: Color(0xffbc477b),
//                                 );
//                               },
//                               onRatingUpdate: (value) {
//                                 updatte(document);
//                               },
//                             ),
//                           ],
//                         )),
//                   );
//                 }),
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//     );
//   }
// }
