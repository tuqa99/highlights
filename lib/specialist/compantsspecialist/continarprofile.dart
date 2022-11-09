import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Continarprfile extends StatefulWidget {
  const Continarprfile({super.key});

  @override
  State<Continarprfile> createState() => _ContinarprfileState();
}

class _ContinarprfileState extends State<Continarprfile> {
  final admineName = TextEditingController();
  String firstname = 'Tuqa Omar Abu Dahab';
  final email = TextEditingController();
  String emaild = '123@123.com';
  String career = 'makeup artiste';
  final careercontroller = TextEditingController();
  PlatformFile? selectedDirectory;

  Future Uplode() async {
    final path = 'test/${selectedDirectory!.name}';
    final file = File(selectedDirectory!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    UploadTask uploadTask = ref.putFile(file);
    final storageSnapshot = uploadTask.snapshot;
    final downloadUrl = await storageSnapshot.ref.getDownloadURL();
    print('this a link $downloadUrl');
    return downloadUrl;
  }

  Future slecteFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedDirectory = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color.fromARGB(255, 250, 91, 165),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    if (selectedDirectory != null)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("chang your photo"),
                              content: Container(
                                  child: Image(
                                image:
                                    FileImage(File(selectedDirectory!.path!)),
                              )),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: slecteFile,
                                    child: Text('select photo')),
                                TextButton(
                                  onPressed: Uplode,
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("Upadte"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              FileImage(File(selectedDirectory!.path!)),
                        ),
                      ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("chang your photo"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: slecteFile,
                                    child: Text('select photo')),
                                TextButton(
                                  onPressed: Uplode,
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("Upadte"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.edit)),
                  ],
                ),
                SizedBox(
                  width: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("chang your name"),
                            content: Container(
                                child: TextField(
                              controller: admineName,
                            )),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    firstname = admineName.text;
                                  });

                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Upadte"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        firstname,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("chang your career"),
                            content: Container(
                                child: TextField(
                              controller: careercontroller,
                            )),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    career = careercontroller.text;
                                  });

                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Upadte"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        career,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.white),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          emaild,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBarIndicator(
                      rating: 4.75,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 25.0,
                      direction: Axis.horizontal,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Continarprfileview extends StatefulWidget {
  Continarprfileview(
      {required firstname,
      required email,
      required profilephotpurl,
      required career});
  String? firstname;
  String? email;
  String? profilephotpurl;
  String? career;
  @override
  State<Continarprfileview> createState() => _ContinarprfileviewState();
}

class _ContinarprfileviewState extends State<Continarprfileview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color.fromARGB(255, 250, 91, 165),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage('${widget.profilephotpurl}'),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    '${widget.firstname}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    '${widget.career}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ]),
                SizedBox(
                  height: 13,
                ),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.white),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '${widget.email}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RatingBarIndicator(
                  rating: 4.75,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 25.0,
                  direction: Axis.horizontal,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
