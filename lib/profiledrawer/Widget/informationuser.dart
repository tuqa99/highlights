import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Info {
  final String? email;
  final String? fname;
  final String? lname;
  final String? location;
  final String? phone;

  Info({
    this.email,
    this.fname,
    this.lname,
    this.location,
    this.phone,
  });

  factory Info.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Info(
      email: data?['email'],
      fname: data?['first name'],
      lname: data?['last name'],
      location: data?['location'],
      phone: data?['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (fname != null) "first name": fname,
      if (lname != null) "last name": lname,
      if (location != null) "location": location,
      if (phone != null) "population": phone,
    };
  }
}
