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
  String?phone;
  String? lname;

  Users({
    this.id,
    this.email,
    this.username,
    this.fname,
    this.lname,

    this.profilepicture,
    this.phone,
  });

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      id:map['id'],
      email : map["email"],
      username : map["UserName"],
      fname : map["firstName"],
      lname: map['lastName'],

      profilepicture: map["profile"].toString(),
      phone : map["phone"],

    );
  }

  Users? _userInfo;

  Users? get userInfo => _userInfo;

  void setUser(Users user) {
    _userInfo = user;
    notifyListeners();
  }
}



