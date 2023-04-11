import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:piwc/pages/utils/color_palette.dart';
import 'package:provider/provider.dart';

import '../Membershipform/Addmember.dart';
import '../main.dart';
import '../model/Users.dart';
import '../progressdialog.dart';

class fillaform extends StatefulWidget {
  const fillaform({Key? key, this.group, this.client, this.docID})
      : super(key: key);
  final String? group;
  final addedMember? client;
  final String? docID;

  @override
  State<fillaform> createState() => _fillaformState();
}

class _fillaformState extends State<fillaform> {
  TextEditingController residence = new TextEditingController();
  TextEditingController placeofwork = new TextEditingController();
  TextEditingController occupation = new TextEditingController();
  TextEditingController language = new TextEditingController();
  TextEditingController region = new TextEditingController();
  TextEditingController mothersname = new TextEditingController();
  TextEditingController fathersname = new TextEditingController();
  TextEditingController fathershomeTown = new TextEditingController();
  TextEditingController MothershomeTown = new TextEditingController();
  TextEditingController FatherReligion = new TextEditingController();

  TextEditingController MothersReligion = new TextEditingController();
  TextEditingController hometown = new TextEditingController();
// Initial Selected Value
  String MaritalStatusvalue = 'Married';
  var MaritalStatus = [
    'Married',
    'Single',
    'Other'

  ];

  String MarriageRegistered = 'Yes';
  var MarriageRegisteredStatus = [
    'Yes',
    'No'

  ];

  bool _residence = false;
  bool _emailAutoValidate = false;
  bool _addressAutoValidate = false;
  bool _mobileAutoValidate = false;

  List<File> _image = [];
  String? _imaage;

  final picker = ImagePicker();
  double val = 0;
  final ImagePicker imagePicker = ImagePicker();
  bool uploading = false;
  final addedMember? addMember1 = addedMember();
  final addedMember addMember = addedMember();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;




  String initValue = "Birth Date";
  bool isDateSelected = false;
  DateTime? birthDate; // instance of DateTime
  String ?birthDateInString;

  // final String? docID;
  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  var rndnumber = "";

  main() {
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(100).toString();
    }
    print(rndnumber);
  }
  TextEditingController dateInput = TextEditingController();


  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    TextEditingController dateInput = TextEditingController();

    Size size = MediaQuery.of(context).size;
    DateTime selectedDate = DateTime.now();
    Future<void> _selectDate(BuildContext context) async {
}


    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ProgressDialog(
                    message: "Add Member Details,Please wait.....",
                  );
                });

            String url = await uploadFile(image!);
            Occupationdb(context);

            // newProduct.group = group;
            _firestore.collection("Members").add({
              'image': url.toString(),
             "FirstName":Provider.of<Users>(context,listen: false).userInfo?.fname ??"",
             "LastName":Provider.of<Users>(context,listen: false).userInfo?.lname ??"",
             "Email":Provider.of<Users>(context,listen: false).userInfo?.email ??"",
             "PhoneNumber":Provider.of<Users>(context,listen: false).userInfo?.phone ??"",
              // "": rndnumber.toString(),
              "placeofwork": addMember.placeofwork.toString(),
              "Residence": addMember.residence,
              "Region": addMember.Region,
              "language": addMember.language,
              "Occupation": addMember.Occupation,

              "homeTown": addMember.homeTown,

              //newProduct.toMap()
            }).then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              //showTextToast('Added Sucessfully!');
            }).catchError((e) {
              // showTextToast('Failed!');
            });
            // Navigator.of(context).pop();
          },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.done,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      body: Container(
        color: ColorPalette.pacificBlue,
        child: SafeArea(
          child: Container(
            color: ColorPalette.aquaHaze,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 40,
                                    ),
                                    margin: const EdgeInsets.only(top: 75),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffd5e2e3),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                           children: [
                                            ExpansionTile(
                                              title: Text("Member Persnal Data"),
                                              children: <Widget>[
                                                Focus(
                                                  onFocusChange: (value) {
                                                    if (!value) {
                                                      setState(() {
                                                        _residence = true;
                                                      });
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height:
                                                                  size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      right:
                                                                          size.width /
                                                                              30),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          .9),
                                                                ),

                                                                initialValue: Provider.of<
                                                                                Users>(
                                                                            context)
                                                                        .userInfo
                                                                        ?.fname ??
                                                                    '',

                                                                // onChanged: (rnnumber) {
                                                                //   addMember.accountNumber ==rndnumber;
                                                                // },
                                                                    readOnly: true,

                                                                    decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(
                                                                    Icons
                                                                        .account_circle_outlined,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .8),
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                      'First Name',
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height:
                                                                  size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      right:
                                                                          size.width /
                                                                              30),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          .9),
                                                                ),

                                                                initialValue: Provider.of<
                                                                                Users>(
                                                                            context)
                                                                        .userInfo
                                                                        ?.lname ??
                                                                    '',

                                                                    readOnly: true,

                                                                    // controller: lname,
                                                                // onChanged: (value){
                                                                //   _lastname = value;
                                                                // },
                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(
                                                                    Icons
                                                                        .account_circle_outlined,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .8),
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                      'Last Name',
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height:
                                                                  size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      right:
                                                                          size.width /
                                                                              30),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .9),
                                                                ),
                                                                readOnly: true,

                                                                initialValue: Provider.of<
                                                                                Users>(
                                                                            context)
                                                                        .userInfo
                                                                        ?.phone ??
                                                                    '',

                                                                // onChanged: (rndnumber) {
                                                                //   addMember.accountNumber ==rndnumber;
                                                                // },
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(
                                                                    Icons.phone,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .8),
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                      'Phone',
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          //Email
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height:
                                                                  size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      right:
                                                                          size.width /
                                                                              30),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child:
                                                                  TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .9),
                                                                ),

                                                                initialValue: Provider.of<
                                                                                Users>(
                                                                            context)
                                                                        .userInfo
                                                                        ?.email ??
                                                                    '',
                                                                // controller: lname,
                                                                // onChanged: (value){
                                                                //   _lastname = value;
                                                                // },
                                                                readOnly: true,
                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                    InputDecoration(
                                                                  prefixIcon:
                                                                      Icon(
                                                                    Icons.email,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .8),
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                      'Email',
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      
                                                      
                                                      
                                                      
                                                      

                                                      //Profession

                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              height:
                                                              size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                  size.width /
                                                                      30),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                      .9),
                                                                ),

                                                                controller:
                                                                hometown,
                                                                onChanged:
                                                                    (value) {
                                                                  addMember.homeTown=
                                                                      value;
                                                                },

                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                InputDecoration(
                                                                  prefixIcon:
                                                                  Icon(
                                                                    Icons
                                                                        .holiday_village,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .8),
                                                                  ),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                  'HomeTown',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),




                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              height:
                                                              size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                  size.width /
                                                                      30),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                              child: TextFormField(
                                                                  controller:region,
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                      .9),
                                                                ),
                                                                onChanged: (value) {
                                                                  addMember.Region =value;
                                                                },

                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                InputDecoration(
                                                                  prefixIcon:
                                                                  Icon(
                                                                    Icons.church,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .8),
                                                                  ),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                  'Region',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),



                                                        ],
                                                      ),
                                                      //Language
                                                      Row(
                                                        children: [
                                                            //Residential Address
                                                              Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              height:
                                                              size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                  size.width /
                                                                      30),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                              child: TextField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                      .9),
                                                                ),
                                                                controller: residence,
                                                                onChanged:(value){

                                                                  addMember.residence=value;
                                                                },

                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                InputDecoration(
                                                                  prefixIcon:
                                                                  Icon(
                                                                    Icons
                                                                        .house_outlined,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .8),
                                                                  ),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                  'Residential Address',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              height:
                                                              size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                  size.width /
                                                                      30),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                              child:
                                                              TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      .9),
                                                                ),

                                                                controller: language,
                                                                onChanged:
                                                                    (value) {
                                                                  addMember.language=
                                                                      value;
                                                                },


                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                InputDecoration(
                                                                  prefixIcon:
                                                                  Icon(
                                                                    Icons.language,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .8),
                                                                  ),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                  'Language',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),


                                                        ],
                                                      ),



                                                      Row(
                                                        children: [

                                                          //Occupation
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              height:
                                                              size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                  size.width /
                                                                      30),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                              child: TextFormField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      .9),
                                                                ),
                                                                controller: occupation,
                                                                onChanged:(value){

                                                                  addMember.Occupation=value;
                                                                },

                                                                // obscureText: isPassword,
                                                                // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                                decoration:
                                                                InputDecoration(
                                                                  prefixIcon:
                                                                  Icon(
                                                                    Icons.work,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .8),
                                                                  ),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                  'Occupation',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                           


                                                          //place Of Work
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Container(
                                                              height:
                                                              size.width / 8,
                                                              width: size.width /
                                                                  2.5,
                                                              alignment: Alignment
                                                                  .center,
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                  size.width /
                                                                      30),
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    .1),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                              ),
                                                              child: TextField(
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      .9),
                                                                ),

                                                                    controller:placeofwork,
                                                                onChanged:(value){
                                                                  addMember.placeofwork=value;
                                                                },
                                                              
                                                                keyboardType:  TextInputType.name ,
                                                                decoration:
                                                                InputDecoration(
                                                                  prefixIcon:
                                                                  Icon(
                                                                    Icons.business,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .8),
                                                                  ),
                                                                  border:
                                                                  InputBorder
                                                                      .none,
                                                                  hintMaxLines: 1,
                                                                  hintText:
                                                                  'Place Of Work',
                                                                  hintStyle:
                                                                  TextStyle(
                                                                    fontSize: 14,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),


                                                      //Marrital Status
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Text("Marital Status"),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: DropdownButton(

                                                                    // Initial Value
                                                                    value: MaritalStatusvalue == null ? null : MaritalStatusvalue,

                                                                    // Down Arrow Icon
                                                                    icon: const Icon(Icons.keyboard_arrow_down),

                                                                    // Array list of items
                                                                    items: MaritalStatus.map((String items) {
                                                                      return DropdownMenuItem(
                                                                        value: items,
                                                                        child: Text(items),
                                                                      );
                                                                    }).toList(),
                                                                    // After selecting the desired option,it will
                                                                    // change button value to selected value
                                                                    onChanged: (  newValue) {
                                                                      setState(() {
                                                                        MaritalStatusvalue = newValue.toString() ;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          //Marriage Registered?
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(
                                                              children: [
                                                                Text("Marriage Registered?"),
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: DropdownButton(

                                                                    // Initial Value
                                                                    value: MarriageRegistered == null ? null : MarriageRegistered,

                                                                    // Down Arrow Icon
                                                                    icon: const Icon(Icons.keyboard_arrow_down),

                                                                    // Array list of items
                                                                    items: MarriageRegisteredStatus.map((String items) {
                                                                      return DropdownMenuItem(
                                                                        value: items,
                                                                        child: Text(items),
                                                                      );
                                                                    }).toList(),
                                                                    // After selecting the desired option,it will
                                                                    // change button value to selected value
                                                                    onChanged: (  newValue) {
                                                                      setState(() {
                                                                        MarriageRegistered = newValue.toString() ;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),



                                                      Row(
                                                        children: [

                                                          Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: Container(
                                                                height:
                                                                size.width / 8,
                                                                width: size.width /
                                                                    2.5,
                                                                alignment: Alignment
                                                                    .center,
                                                                padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                    size.width /
                                                                        30),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                      .1),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20),
                                                                ),
                                                                child:GestureDetector(
                                                                  onTap: () async {
                                                                    final datePick = await showDatePicker(
                                                                        context: context,
                                                                        initialDate: new DateTime.now(),
                                                                        firstDate: new DateTime(1900),
                                                                        lastDate: new DateTime(2100));
                                                                    if (datePick != null &&
                                                                        datePick != birthDate) {
                                                                      setState(() {
                                                                        birthDate = datePick;
                                                                        isDateSelected = true;
                                                                        birthDateInString =
                                                                        "${birthDate!.month}/${birthDate!.day}/${birthDate!.year}";
                                                                      });
                                                                    }
                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(10.0),
                                                                    child: SingleChildScrollView(
                                                                      child: Row(
                                                                        children: [
                                                                          new Icon(
                                                                            Icons.calendar_today,
                                                                            color:  Colors.black,
                                                                            size:18,
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: new Text(
                                                                              (isDateSelected
                                                                                  ? DateFormat.yMMMd()
                                                                                  .format(birthDate!)
                                                                                  : initValue),
                                                                              style: TextStyle(
                                                                                fontSize:13,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),


                                                                // Center(
                                                                //   child: TextField(
                                                                //     controller: dateInput,
                                                                //     //editing controller of this TextField
                                                                //     decoration: InputDecoration(
                                                                //
                                                                //         icon: Icon(Icons.calendar_today), //icon of text field
                                                                //         labelText: "Enter Date",
                                                                //       //label text of field
                                                                //     ),
                                                                //     readOnly: true,
                                                                //     //set it true, so that user will not able to edit text
                                                                //     onTap: () async {
                                                                //       DateTime? pickedDate = await showDatePicker(
                                                                //           context: context,
                                                                //           initialDate: DateTime.now(),
                                                                //           firstDate: DateTime(1950),
                                                                //           //DateTime.now() - not to allow to choose before today.
                                                                //           lastDate: DateTime(2100));
                                                                //
                                                                //       if (pickedDate != null) {
                                                                //         print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                                //         print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                //         setState(() {
                                                                //           dateInput.text = formattedDate; //set output date to TextField value.
                                                                //         });
                                                                //       } else {}
                                                                //     },
                                                                //   ))


                                                              )
                                                          ),

                                                          //Residentiaal Address

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),

                                                // Focus(
                                                //   onFocusChange: (value) {
                                                //     if (!value) {
                                                //       setState(() {
                                                //         _emailAutoValidate = true;
                                                //       });
                                                //     }
                                                //   },
                                                //   child: TextFormField(
                                                //     autovalidate: _emailAutoValidate,
                                                //     controller: _email,
                                                //     textInputAction: TextInputAction.next,
                                                //     decoration: InputDecoration(
                                                //         hintText: "enter email",
                                                //         labelText: "Email",
                                                //         border: OutlineInputBorder()),
                                                //     validator: (value) {
                                                //       if (value.isEmpty) {
                                                //         return "Email field cannot be empty.";
                                                //       }
                                                //       return null;
                                                //     },
                                                //   ),
                                                // ),
                                              ],
                                            ),

                                            ExpansionTile(
                                                title: Text("Parent Data"),
                                                children: <Widget>[
                                                  Focus(
                                                    onFocusChange: (value) {
                                                      if (!value) {
                                                        setState(() {
                                                          //_emailAutoValidate =
                                                             // true;
                                                        });
                                                      }
                                                    },
                                                    child: //FathersHometown
                                                        Column(
                                                      children: [
                                                        //Fathersname
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      fathersname,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember
                                                                            .fathername =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons.man_2_outlined,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'Fathers Name',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            //mothersname
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      mothersname,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember
                                                                            .mothername =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons.woman,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'Mothers Name',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        //Mother hometown
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors.black
                                                                        .withOpacity(
                                                                        .5),
                                                                  ),
                                                                  controller:
                                                                      fathershomeTown,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember.fathershometown=
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons
                                                                          .home_sharp,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'F.HomeTown',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            //Mothershometown
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      MothershomeTown,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember.mothershometown =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons.man,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'M.Home',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors.black
                                                                          .withOpacity(
                                                                          .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            

                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: Container(
                                                                height:
                                                                size.width /
                                                                    8,
                                                                width:
                                                                size.width /
                                                                    2.5,
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: size
                                                                        .width /
                                                                        30),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                      .1),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                        .9),
                                                                  ),
                                                                  controller:
                                                                  FatherReligion,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember.fatherReligion =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    prefixIcon:
                                                                    Icon(
                                                                      Icons.circle_sharp,
                                                                      color: Colors
                                                                          .lightBlueAccent
                                                                          .withOpacity(
                                                                          .8),
                                                                    ),
                                                                    border:
                                                                    InputBorder
                                                                        .none,
                                                                    hintMaxLines:
                                                                    1,
                                                                    hintText:
                                                                    'F.ReligiousGroup',
                                                                    hintStyle:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      14,
                                                                      color: Colors.black
                                                                          .withOpacity(
                                                                          .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                              child: Container(
                                                                height:
                                                                size.width /
                                                                    8,
                                                                width:
                                                                size.width /
                                                                    2.5,
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: size
                                                                        .width /
                                                                        30),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                      .1),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                        .9),
                                                                  ),
                                                                  controller:
                                                                  MothersReligion,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember.motherReligion =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    prefixIcon:
                                                                    Icon(
                                                                      Icons.circle_sharp,
                                                                      color: Colors
                                                                          .lightBlueAccent
                                                                          .withOpacity(
                                                                          .8),
                                                                    ),
                                                                    border:
                                                                    InputBorder
                                                                        .none,
                                                                    hintMaxLines:
                                                                    1,
                                                                    hintText:
                                                                    'M.ReligiousGroup',
                                                                    hintStyle:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      14,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                          .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        //LocationDD(product: newProduct),
                                                      ],
                                                    ),

                                                    // TextFormField(
                                                    //   autovalidate: _emailAutoValidate,
                                                    //   controller: _email,
                                                    //   textInputAction: TextInputAction.next,
                                                    //   decoration: InputDecoration(
                                                    //       hintText: "enter email",
                                                    //       labelText: "Email",
                                                    //       border: OutlineInputBorder()),
                                                    //   validator: (value) {
                                                    //     if (value.isEmpty) {
                                                    //       return "Email field cannot be empty.";
                                                    //     }
                                                    //     return null;
                                                    //   },
                                                    // ),
                                                  ),

                                                ]),

                                            ExpansionTile(
                                                title: Text("Children Data"),
                                                children: <Widget>[
                                                  Focus(
                                                    onFocusChange: (value) {
                                                      if (!value) {
                                                        setState(() {
                                                          _emailAutoValidate =
                                                              true;
                                                        });
                                                      }
                                                    },
                                                    child: //FathersHometown
                                                        Column(
                                                      children: [
                                                        //Fathersname
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      fathersname,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember
                                                                            .fathername =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons.man,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'Fathers Name',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            //mothersname
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      mothersname,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember
                                                                            .mothername =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons.man,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'Mothers Name',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        //Mother hometown
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      fathersname,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember
                                                                            .fathername =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons
                                                                          .home_sharp,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'Fathers HomeTown',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            //mothersname
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height:
                                                                    size.width /
                                                                        8,
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: size
                                                                                .width /
                                                                            30),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          .1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                child: TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            .9),
                                                                  ),
                                                                  controller:
                                                                      mothersname,
                                                                  onChanged:
                                                                      (value) {
                                                                    addMember
                                                                            .mothername =
                                                                        value;
                                                                  },
                                                                  // obscureText: true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons.man,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .8),
                                                                    ),
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintMaxLines:
                                                                        1,
                                                                    hintText:
                                                                        'Mothers Name',
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              .5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),



                                                          ],
                                                        ),

                                                        //LocationDD(product: newProduct),
                                                      ],
                                                    ),

                                                    // TextFormField(
                                                    //   autovalidate: _emailAutoValidate,
                                                    //   controller: _email,
                                                    //   textInputAction: TextInputAction.next,
                                                    //   decoration: InputDecoration(
                                                    //       hintText: "enter email",
                                                    //       labelText: "Email",
                                                    //       border: OutlineInputBorder()),
                                                    //   validator: (value) {
                                                    //     if (value.isEmpty) {
                                                    //       return "Email field cannot be empty.";
                                                    //     }
                                                    //     return null;
                                                    //   },
                                                    // ),
                                                  ),



                                              
                                                ]
                                                
                                                
                                            ),


                                             ExpansionTile(
                                                 title: Text("Children Data"),
                                                 children: <Widget>[
                                                   Focus(
                                                     onFocusChange: (value) {
                                                       if (!value) {
                                                         setState(() {
                                                           _emailAutoValidate =
                                                           true;
                                                         });
                                                       }
                                                     },
                                                     child: //FathersHometown
                                                     Column(
                                                       children: [
                                                         //Fathersname
                                                         Row(
                                                           children: [
                                                             Padding(
                                                               padding:
                                                               const EdgeInsets
                                                                   .all(8.0),
                                                               child: Container(
                                                                 height:
                                                                 size.width /
                                                                     8,
                                                                 width:
                                                                 size.width /
                                                                     2.5,
                                                                 alignment:
                                                                 Alignment
                                                                     .center,
                                                                 padding: EdgeInsets
                                                                     .only(
                                                                     right: size
                                                                         .width /
                                                                         30),
                                                                 decoration:
                                                                 BoxDecoration(
                                                                   color: Colors
                                                                       .black
                                                                       .withOpacity(
                                                                       .1),
                                                                   borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                       20),
                                                                 ),
                                                                 child: TextField(
                                                                   style:
                                                                   TextStyle(
                                                                     color: Colors
                                                                         .white
                                                                         .withOpacity(
                                                                         .9),
                                                                   ),
                                                                   controller:
                                                                   fathersname,
                                                                   onChanged:
                                                                       (value) {
                                                                     addMember
                                                                         .fathername =
                                                                         value;
                                                                   },
                                                                   // obscureText: true,
                                                                   keyboardType:
                                                                   TextInputType
                                                                       .name,
                                                                   decoration:
                                                                   InputDecoration(
                                                                     prefixIcon:
                                                                     Icon(
                                                                       Icons.man,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .8),
                                                                     ),
                                                                     border:
                                                                     InputBorder
                                                                         .none,
                                                                     hintMaxLines:
                                                                     1,
                                                                     hintText:
                                                                     'Fathers Name',
                                                                     hintStyle:
                                                                     TextStyle(
                                                                       fontSize:
                                                                       14,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .5),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),

                                                             //mothersname
                                                             Padding(
                                                               padding:
                                                               const EdgeInsets
                                                                   .all(8.0),
                                                               child: Container(
                                                                 height:
                                                                 size.width /
                                                                     8,
                                                                 width:
                                                                 size.width /
                                                                     2.5,
                                                                 alignment:
                                                                 Alignment
                                                                     .center,
                                                                 padding: EdgeInsets
                                                                     .only(
                                                                     right: size
                                                                         .width /
                                                                         30),
                                                                 decoration:
                                                                 BoxDecoration(
                                                                   color: Colors
                                                                       .black
                                                                       .withOpacity(
                                                                       .1),
                                                                   borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                       20),
                                                                 ),
                                                                 child: TextField(
                                                                   style:
                                                                   TextStyle(
                                                                     color: Colors
                                                                         .white
                                                                         .withOpacity(
                                                                         .9),
                                                                   ),
                                                                   controller:
                                                                   mothersname,
                                                                   onChanged:
                                                                       (value) {
                                                                     addMember
                                                                         .mothername =
                                                                         value;
                                                                   },
                                                                   // obscureText: true,
                                                                   keyboardType:
                                                                   TextInputType
                                                                       .name,
                                                                   decoration:
                                                                   InputDecoration(
                                                                     prefixIcon:
                                                                     Icon(
                                                                       Icons.man,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .8),
                                                                     ),
                                                                     border:
                                                                     InputBorder
                                                                         .none,
                                                                     hintMaxLines:
                                                                     1,
                                                                     hintText:
                                                                     'Mothers Name',
                                                                     hintStyle:
                                                                     TextStyle(
                                                                       fontSize:
                                                                       14,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .5),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                           ],
                                                         ),

                                                         //Mother hometown
                                                         Row(
                                                           children: [
                                                             Padding(
                                                               padding:
                                                               const EdgeInsets
                                                                   .all(8.0),
                                                               child: Container(
                                                                 height:
                                                                 size.width /
                                                                     8,
                                                                 width:
                                                                 size.width /
                                                                     2.5,
                                                                 alignment:
                                                                 Alignment
                                                                     .center,
                                                                 padding: EdgeInsets
                                                                     .only(
                                                                     right: size
                                                                         .width /
                                                                         30),
                                                                 decoration:
                                                                 BoxDecoration(
                                                                   color: Colors
                                                                       .black
                                                                       .withOpacity(
                                                                       .1),
                                                                   borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                       20),
                                                                 ),
                                                                 child: TextField(
                                                                   style:
                                                                   TextStyle(
                                                                     color: Colors
                                                                         .white
                                                                         .withOpacity(
                                                                         .9),
                                                                   ),
                                                                   controller:
                                                                   fathersname,
                                                                   onChanged:
                                                                       (value) {
                                                                     addMember
                                                                         .fathername =
                                                                         value;
                                                                   },
                                                                   // obscureText: true,
                                                                   keyboardType:
                                                                   TextInputType
                                                                       .name,
                                                                   decoration:
                                                                   InputDecoration(
                                                                     prefixIcon:
                                                                     Icon(
                                                                       Icons
                                                                           .home_sharp,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .8),
                                                                     ),
                                                                     border:
                                                                     InputBorder
                                                                         .none,
                                                                     hintMaxLines:
                                                                     1,
                                                                     hintText:
                                                                     'Fathers HomeTown',
                                                                     hintStyle:
                                                                     TextStyle(
                                                                       fontSize:
                                                                       14,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .5),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                             //mothersname
                                                             Padding(
                                                               padding:
                                                               const EdgeInsets
                                                                   .all(8.0),
                                                               child: Container(
                                                                 height:
                                                                 size.width /
                                                                     8,
                                                                 width:
                                                                 size.width /
                                                                     2.5,
                                                                 alignment:
                                                                 Alignment
                                                                     .center,
                                                                 padding: EdgeInsets
                                                                     .only(
                                                                     right: size
                                                                         .width /
                                                                         30),
                                                                 decoration:
                                                                 BoxDecoration(
                                                                   color: Colors
                                                                       .black
                                                                       .withOpacity(
                                                                       .1),
                                                                   borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                       20),
                                                                 ),
                                                                 child: TextField(
                                                                   style:
                                                                   TextStyle(
                                                                     color: Colors
                                                                         .white
                                                                         .withOpacity(
                                                                         .9),
                                                                   ),
                                                                   controller:
                                                                   mothersname,
                                                                   onChanged:
                                                                       (value) {
                                                                     addMember
                                                                         .mothername =
                                                                         value;
                                                                   },
                                                                   // obscureText: true,
                                                                   keyboardType:
                                                                   TextInputType
                                                                       .name,
                                                                   decoration:
                                                                   InputDecoration(
                                                                     prefixIcon:
                                                                     Icon(
                                                                       Icons.man,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .8),
                                                                     ),
                                                                     border:
                                                                     InputBorder
                                                                         .none,
                                                                     hintMaxLines:
                                                                     1,
                                                                     hintText:
                                                                     'Mothers Name',
                                                                     hintStyle:
                                                                     TextStyle(
                                                                       fontSize:
                                                                       14,
                                                                       color: Colors
                                                                           .white
                                                                           .withOpacity(
                                                                           .5),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),


                                                           ],
                                                         ),

                                                         //LocationDD(product: newProduct),
                                                       ],
                                                     ),

                                                     // TextFormField(
                                                     //   autovalidate: _emailAutoValidate,
                                                     //   controller: _email,
                                                     //   textInputAction: TextInputAction.next,
                                                     //   decoration: InputDecoration(
                                                     //       hintText: "enter email",
                                                     //       labelText: "Email",
                                                     //       border: OutlineInputBorder()),
                                                     //   validator: (value) {
                                                     //     if (value.isEmpty) {
                                                     //       return "Email field cannot be empty.";
                                                     //     }
                                                     //     return null;
                                                     //   },
                                                     // ),
                                                   ),
                                                 ]
                                                 
                                             ),
                                            //Username
                                            // SingleChildScrollView(
                                            //   scrollDirection: Axis.horizontal,
                                            //   child: Row(
                                            //     children: [
                                            //
                                            //
                                            //     ],
                                            //   ),
                                            // ),

                                            //Hometown
                                          ]),
                                    )),
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              color: Colors.lightBlueAccent,
                                              child: SizedBox(
                                                height: 250,
                                                child: Card(
                                                  elevation: 8,
                                                  shadowColor: Colors.grey,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                100),
                                                          ),
                                                          side: BorderSide(
                                                              width: 2,
                                                              color: Colors
                                                                  .white24)),
                                                  child: Container(
                                                    padding: EdgeInsets.all(22),
                                                    child: Container(

                                                        //   decoration:  BoxDecoration(
                                                        // border: Border.all(width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                                                        //       boxShadow: [
                                                        //         BoxShadow(
                                                        //             spreadRadius: 20,
                                                        //             blurRadius: 10,
                                                        //             color: Colors.black.withOpacity(0.1),
                                                        //             offset: const Offset(0, 10))
                                                        //       ],
                                                        //       shape: BoxShape.circle,
                                                        //       image:  DecorationImage(
                                                        //           fit: BoxFit.cover,
                                                        //           image: FileImage(_image))),

                                                        child: Center(
                                                            child: ImagePro())
                                                        //   : Container(
                                                        // margin: EdgeInsets
                                                        //     .all(3),
                                                        // decoration: BoxDecoration(
                                                        //     image: DecorationImage(
                                                        //         image: FileImage(_image[
                                                        //         index -
                                                        //             1]),
                                                        //         fit: BoxFit
                                                        //             .cover)),
                                                        //  );
                                                        ////}),
                                                        ),

                                                    //             // FloatingActionButton(
                                                    //             //   onPressed:
                                                    //             //       chooseImage,
                                                    //             //   tooltip:
                                                    //             //       'Pick Image',
                                                    //             //   child: Icon(Icons
                                                    //             //       .add_a_photo),
                                                    //             // ),
                                                    //           ],
                                                    //         ),
                                                    // ),

                                                    // Container(
                                                    //   color: ColorPalette.timberGreen
                                                    //       .withOpacity(0.1),
                                                    //   child: (newProduct.image == null)
                                                    //       ? Center(
                                                    //     child: Icon(
                                                    //       Icons.image,
                                                    //       color: ColorPalette
                                                    //           .nileBlue
                                                    //           .withOpacity(0.5),
                                                    //     ),
                                                    //   )
                                                    //       : CachedNetworkImage(
                                                    //     fit: BoxFit.cover,
                                                    //     imageUrl: newProduct.image!,
                                                    //     errorWidget:
                                                    //         (context, s, a) {
                                                    //       return Icon(
                                                    //         Icons.image,
                                                    //         color: ColorPalette
                                                    //             .nileBlue
                                                    //             .withOpacity(0.5),
                                                    //       );
                                                    //     },
                                                    //   ),
                                                    // ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  io.File? image;

  Future<String> uploadFile(io.File image) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context)
    //     {
    //       //return ;
    //     }
    // );

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user?.uid;

    // final userId = currentfirebaseUser?.email;
    final _storage = FirebaseStorage.instance;

    String downloadUrl;

    //upload to firebase storage

    Reference ref =
        FirebaseStorage.instance.ref().child("$myUid/${basename(image.path)}");

    await ref.putFile(image);

    downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }




  getImageFromCamera() async {
    final picker = ImagePicker();
    final dateTime = DateTime.now();

    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // if (imageFile != null) {
    //   image = io.File(imageFile.path);
    // }

    setState(() {
      image = File(imageFile!.path);
    });
    //uploadToFirebase();
  }

  Future<String> downloadUrl() {
    final dateTime = DateTime.now();
    // final userId = currentfirebaseUser?.uid;

    return FirebaseStorage.instance
        .refFromURL("gs://piwc-5e5a0.appspot.com/")
        .child(
            'group/${addMember1?.accountNumber}/${basename(image?.path ?? "")}')

        //.child("Driver/profile/$userId/$userId.jpg")

        .getDownloadURL();
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Widget ImagePro() {
    return FutureBuilder<String>(
      future: downloadUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: GestureDetector(
              onTap: () {
                getImageFromCamera();
              },
              child: GestureDetector(
                  onTap: () {
                    getImageFromCamera();
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 1000,
                  )),
            ),
          );
        }
        return Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.cyan.withOpacity(0.5),
              // backgroundImage: _image==null? AssetImage("images/user_icon.png"): FileImage(io.File(_image.path)),
              radius: 80,

              child: GestureDetector(
                onTap: () {
                  getImageFromCamera();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: (image != null)
                      ? FileImage(io.File(image!.path)) as ImageProvider
                      : AssetImage("assets/images/user_icon.jpg"),

                  radius: 70,
                  //child: Image.network(snapshot.data.toString()),
                  // GestureDetector(onTap: getImage,)
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Occupationdb(context) async {

    var firstname =Provider.of<Users>(context,listen: false).userInfo?.fname ??"";
    var lastname=Provider.of<Users>(context,listen: false).userInfo?.lname ??"";
    var email=Provider.of<Users>(context,listen: false).userInfo?.email ??"";
    var phone=Provider.of<Users>(context,listen: false).userInfo?.phone ??"";
    // String url = await uploadsFile();
    String url = await uploadFile(image!);
    Map userDataMap = {
      'profile': url.toString(),
      "FirstName":firstname,
      "LastName":lastname,
      "Email":email,
      "PhoneNumber":phone,
      // "": rndnumber.toString(),
      "placeofwork": addMember.placeofwork.toString(),
      "Residence": addMember.residence,
      "Region": addMember.Region,
      "language": addMember.language,
      "Occupation": addMember.Occupation,
      "Date Of Birth":birthDateInString,

      "homeTown": addMember.homeTown,
    };
    final String _firebaseAuth = FirebaseAuth.instance.currentUser!.uid;

    clients.child(_firebaseAuth).update({
      'profile': url.toString(),
    "FirstName":firstname,
    "LastName":lastname,
    "Email":email,
    "PhoneNumber":phone,
      "Date Of Birth":birthDateInString,
    // "": rndnumber.toString(),
    "placeofwork": addMember.placeofwork.toString(),
    "Residence": addMember.residence,
    "Region": addMember.Region,
    "language": addMember.language,
    "Occupation": addMember.Occupation,

    "homeTown": addMember.homeTown,
  }
    );
  }
}

io.File? image;

Future<String> uploadFile(io.File image) async {
  // showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context)
  //     {
  //       //return ;
  //     }
  // );

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final myUid = user?.uid;

  // final userId = currentfirebaseUser?.email;
  final _storage = FirebaseStorage.instance;

  String downloadUrl;

  //upload to firebase storage

  Reference ref =
      FirebaseStorage.instance.ref().child("$myUid/${basename(image.path)}");

  await ref.putFile(image);

  downloadUrl = await ref.getDownloadURL();

  return downloadUrl;
}
