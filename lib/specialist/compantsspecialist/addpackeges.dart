import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Addpackegs extends StatefulWidget {
  const Addpackegs({super.key});

  @override
  State<Addpackegs> createState() => _AddpackegsState();
}

class _AddpackegsState extends State<Addpackegs> {
  @override
  Widget build(BuildContext context) {
    PlatformFile? selectedDirectory;
    TextEditingController descriptionpackeg = TextEditingController();
    String imageurl = '';
    // Future getimage() async {
    //   final ImagePicker _picker = ImagePicker();
    //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //   setState(() {
    //     IMge = image as File;
    //   });
    // }

    Future Uplode() async {
      final path = 'backges/${selectedDirectory!.name}';
      final file = File(selectedDirectory!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file);
      UploadTask uploadTask = ref.putFile(file);
      final storageSnapshot = uploadTask.snapshot;
      imageurl = await storageSnapshot.ref.getDownloadURL();
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      print('this a link $imageurl');
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      return imageurl;
    }

    Future slecteFile() async {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() {
        selectedDirectory = result.files.first;
      });
    }

    CollectionReference studentRef =
        FirebaseFirestore.instance.collection("packges");
    return AlertDialog(
      title: Column(
        children: [
          Text("create your backges"), //       Container(
          TextField(
            decoration: InputDecoration(
                hintText: 'Enter your  description',
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal))),
            controller: descriptionpackeg,
          ),
        ],
      ),
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
              studentRef.add({'desc': 'bb', 'url': imageurl});
            },
            child: Text('ok'))
      ],
    );

    // AlertDialog(
    //   title: const Text("create your packeg"),
    //   content: Column(
    //     children: [
    //       Container(
    //           child: TextField(
    //         decoration: InputDecoration(
    //             hintText: 'Enter your  description',
    //             border: OutlineInputBorder(
    //                 borderSide: new BorderSide(color: Colors.teal))),
    //         controller: descriptionpackeg,
    //       )),
    //     ],
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(onPressed: slecteFile, child: Text('select photo')),
    //     TextButton(
    //       onPressed: Uplode,
    //       // studentRef.add({'desc': descriptionpackeg.text, 'url': imageurl});

    //       // Navigator.of(context).pop();

    //       child: Container(
    //         padding: const EdgeInsets.all(14),
    //         child: Text('update'),
    //       ),
    //     ),
    //     // TextButton(onPressed:  child: Text('OK'))
    //   ],
    // );
  }
}
