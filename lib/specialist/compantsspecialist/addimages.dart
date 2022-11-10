import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class addimages extends StatefulWidget {
  const addimages({super.key});

  @override
  State<addimages> createState() => _addimagesState();
}

String downloadUrl = '';

class _addimagesState extends State<addimages> {
  PlatformFile? selectedDirectory;
  Future Uplode() async {
    final path = 'imagestest/${selectedDirectory!.name}';
    final file = File(selectedDirectory!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    UploadTask uploadTask = ref.putFile(file);
    final storageSnapshot = uploadTask.snapshot;
    downloadUrl = await storageSnapshot.ref.getDownloadURL();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    print('this a link $downloadUrl');
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    return downloadUrl;
  }

  Future slecteFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedDirectory = result.files.first;
    });
  }

  TextEditingController imagecontroller = TextEditingController();
  CollectionReference imageadd =
      FirebaseFirestore.instance.collection("addimages");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("chang your photo"),
      actions: <Widget>[
        ElevatedButton(onPressed: slecteFile, child: Text('select photo')),
        TextButton(
          onPressed: Uplode,
          child: Container(
            padding: const EdgeInsets.all(14),
            child: const Text("Upadte"),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              imageadd.add({'url': downloadUrl});
            },
            child: Text('ok'))
      ],
    );
  }
}
