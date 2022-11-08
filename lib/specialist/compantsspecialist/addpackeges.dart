import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Addpackegs extends StatefulWidget {
  const Addpackegs({super.key});

  @override
  State<Addpackegs> createState() => _AddpackegsState();
}

class _AddpackegsState extends State<Addpackegs> {
  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionpackeg = TextEditingController();
    TextEditingController imagenet = TextEditingController();

    TextEditingController courseController = TextEditingController();
    PlatformFile? selectedDirectory;
    File IMge;
    String imageurl = '';
    Future getimage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        IMge = image as File;
      });
    }

    Future Uplode() async {
      final path = 'url/${selectedDirectory!.name}';
      final file = File(selectedDirectory.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      final task = ref.putFile(file);

      imageurl = await ref.getDownloadURL();
      print(
          '////////////////////////////////this a link $imageurl///////////////////////////////////////////////////////');
    }

    // Future slecteFile() async {
    //   final result = await FilePicker.platform.pickFiles();
    //   if (result == null) return;
    //   setState(() {
    //     selectedDirectory = result.files.first;
    //   });
    // }
    CollectionReference studentRef =
        FirebaseFirestore.instance.collection("packges");
    return AlertDialog(
      title: const Text("create your packeg"),
      content: Column(
        children: [
          Container(
              child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal))),
            controller: descriptionpackeg,
          )),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal))),
            controller: imagenet,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            studentRef
                .add({'desc': descriptionpackeg.text, 'url': imagenet.text});

            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            child: const Text("Upadte"),
          ),
        ),
      ],
    );
  }
}
