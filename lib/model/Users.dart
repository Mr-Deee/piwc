import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

User? firebaseUser;

User? currentfirebaseUser;

class Users extends ChangeNotifier {
  String? id;
  String? email;
  String? fname;
  String? username;
  String? profilepicture;
  String? phone;
  String? lname;
  String? placeofwork;
  String? occupasion;
  String? fullname;
  String? homeTown;

  Users({
    this.id,
    this.email,
    this.occupasion,
    this.homeTown,
    this.username,
    this.placeofwork,
    this.fname,
    this.fullname,
    this.lname,
    this.profilepicture,
    this.phone,
  });

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      email: map["email"],
      username: map["UserName"],
      fname: map["FirstName"],
      lname: map['LastName'],
      occupasion: map['Occupation'],
      profilepicture: map["profile"].toString(),
      phone: map["PhoneNumber"],
      homeTown: map["homeTown"],
      fullname: map["fullName"],
    );
  }

  Users? _userInfo;

  Users? get userInfo => _userInfo;

  void setUser(Users user) {
    _userInfo = user;
    notifyListeners();
  }
}
