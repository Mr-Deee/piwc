import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

User? firebaseUser;

User? currentfirebaseUser;

class Users extends ChangeNotifier {
  String? id;
  String? email;
  String? Region;
  String? Residence;
  String? fname;
  String? username;
  String? profilepicture;
  String? languge;
  String? DOB;
  String? placeofwork;

  String? phone;
  String? lname;
  String? Occupation;

  String? hometown;

  Users({
    this.id,
    this.email,

    // this.Occupasion,
    this.hometown,
    this.username,
    this.fname,
    this.DOB,
    this.languge,
    this.Occupation,
    this.placeofwork,
    this.Region,
    this.lname,
    this.profilepicture,
    this.Residence,
    this.phone,
  });

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      email: map["email"],
      Residence: map["Residence"],
      hometown: map["HomeTown"],
      languge: map["language"],
      DOB: map["Date Of Birth"],
      Occupation: map["Occupation"],
      username: map["UserName"],
      fname: map["firstName"],
      lname: map['lastName'],
      Region: map["Region"],
      profilepicture: map["profile"].toString(),
      phone: map["phone"],
      placeofwork: map["placeofwork"],
    );
  }

  Users? _userInfo;

  Users? get userInfo => _userInfo;

  void setUser(Users user) {
    _userInfo = user;
    notifyListeners();
  }
}
