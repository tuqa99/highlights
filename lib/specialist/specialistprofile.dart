import 'dart:io';
import "package:flutter/material.dart";
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'compantsspecialist/addimages.dart';
import 'compantsspecialist/addpackeges.dart';
import 'compantsspecialist/continarprofile.dart';
import 'compantsspecialist/read.dart';
import 'compantsspecialist/viewimage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String defoultphoto =
      'https://media.istockphoto.com/id/530827889/vector/profile-icon-female-avatar-woman-portrait.jpg?s=612x612&w=0&k=20&c=kUELgBG6fArZUAqHoKDg_FkeDuqd_SSBzRm7xjTPMPE=';
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

  // Future deletfile() async {
  //   final path = 'files/${selectedDirectory!.path!}';
  //   final file = File(selectedDirectory!.path!);
  //   final ref = FirebaseStorage.instance.ref().child(path);

  //   await ref.delete();
  // }

  final admineName = TextEditingController();
  String firstname = 'Tuqa Omar Abu Dahab';
  final email = TextEditingController();
  String emaild = '123@123.com';
  String career = 'makeup artiste';
  final careercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 202, 68, 255)),
        body: Stack(
          children: [
            Continarprfile(),
            Padding(
              padding: const EdgeInsets.only(top: 175),
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 55,
                                ),
                                Text(
                                  'My packeges',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => Addpackegs());
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              child: Read_component(),
                            ),
                            Divider(
                              thickness: 3,
                              height: 6,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 55,
                                ),
                                Text(
                                  'My work',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => addimages());
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              child: Viewimages(),
                            ),
                            Divider(
                              thickness: 3,
                              height: 6,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Divider(
              height: 3,
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 55,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
