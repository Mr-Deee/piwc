import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import '../model/assistantmethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  TextEditingController occupation = TextEditingController();

  TextEditingController placeofwork = new TextEditingController();
  TextEditingController language = new TextEditingController();
  TextEditingController region = new TextEditingController();
  TextEditingController nochildren = new TextEditingController();
  TextEditingController firstchild = new TextEditingController();
  TextEditingController secondchild = new TextEditingController();
  TextEditingController thirdchild = new TextEditingController();
  TextEditingController forthchild = new TextEditingController();
  TextEditingController fifthchild = new TextEditingController();
  TextEditingController mothersname = new TextEditingController();
  TextEditingController fathersname = new TextEditingController();
  TextEditingController fathershomeTown = new TextEditingController();
  TextEditingController MothershomeTown = new TextEditingController();
  TextEditingController FatherReligion = new TextEditingController();

  TextEditingController MothersReligion = new TextEditingController();
  TextEditingController hometown = new TextEditingController();

// Initial Selected Value
  String MaritalStatusvalue = 'Married';
  var MaritalStatus = ['Married', 'Single', 'Other'];
  String FatherAliveStatusvalue = 'Yes';
  var FatherAliveStatus = [
    'Yes',
    'No',
  ];
  String MotherAliveStatusvalue = 'Yes';
  var MotherAliveStatus = [
    'Yes',
    'No',
  ];

  String ChiledGenderStatusvalue = 'Male';
  var ChiledGenderStatus = [
    'Male',
    'Female',
  ];

  String MarriageRegistered = 'Yes';
  var MarriageRegisteredStatus = ['Yes', 'No'];
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
  String? birthDateInString;

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
    // TODO: implement initState
    super.initState();
    // AssistantMethods.getCurrentOnlineUserInfo(Context);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController dateInput = TextEditingController();
    String initValue =  Provider.of<Users>(context, listen: false).userInfo?.DOB ?? "Select Date";
    String initialRegion =
        Provider.of<Users>(context, listen: false).userInfo?.Region ?? "";
    region.text = initialRegion;
    Size size = MediaQuery.of(context).size;
    DateTime selectedDate = DateTime.now();
    Future<void> _selectDate(BuildContext context) async {}

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

            // String url = await uploadFile(image!);
            biodatadb(context);
            final String _firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
            final userInfo = Provider.of<Users>(context, listen: false).userInfo;
            final docRef = _firestore.collection("Members").doc(_firebaseAuth);

// Create an empty update object
            final Map<String, dynamic> updateData = {};

// Conditionally add fields to the updateData only if they have changed
            if (url != null) {
              updateData['image'] = url.toString();
            }

            if (userInfo?.fname != null) {
              updateData['FirstName'] = userInfo!.fname;
            }

            if (userInfo?.lname != null) {
              updateData['LastName'] = userInfo!.lname;
            }

            if (userInfo?.email != null) {
              updateData['Email'] = userInfo!.email;
            }

            if (userInfo?.phone != null) {
              updateData['PhoneNumber'] = userInfo!.phone;
            }

            if (addMember.placeofwork != null) {
              updateData['placeofwork'] = addMember.placeofwork.toString();
            }

            if (birthDateInString != null) {
              updateData['DOB'] = birthDateInString;
            }

            if (addMember.residence != null) {
              updateData['Residence'] = addMember.residence;
            }

            if (addMember.Region != null) {
              updateData['Region'] = addMember.Region;
            }

            if (addMember.language != null) {
              updateData['language'] = addMember.language;
            }

            if (addMember.Occupation != null) {
              updateData['Occupation'] = addMember.Occupation;
            }

            if (addMember.homeTown != null) {
              updateData['homeTown'] = addMember.homeTown;
            }

// Check if there are any fields to update
            if (updateData.isNotEmpty) {
              docRef.update(updateData).then((value) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // showTextToast('Added Successfully!');
              }).catchError((e) {
                // Handle and log errors here.
                // showTextToast('Failed!');
              });
            } else {
              // No fields have changed, you can handle this case accordingly.
              // For example, you might want to show a message to the user.
              // print('No data to update');
            }

          },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.done,
            color : Colors.lightBlueAccent,
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: ColorPalette.pacificBlue,
          child: SafeArea(
            child: Container(
              color: ColorPalette.aquaHaze,
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top:78.0),
                child: Column(


                  children: [


                    Column(
                      children: [
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
                                    2.1,
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
                                child:
                                TextFormField(
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .9),
                                  ),

                                  initialValue: Provider.of<Users>(
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
                                    hintMaxLines:
                                    1,
                                    hintText:
                                    'First Name',
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
                                    2.3,
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
                                child:
                                TextFormField(
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .9),
                                  ),

                                  initialValue: Provider.of<Users>(
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
                                    hintMaxLines:
                                    1,
                                    hintText:
                                    'Last Name',
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
                                    2.1,
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
                                child:
                                TextFormField(
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .9),
                                  ),
                                  readOnly: true,

                                  initialValue: Provider.of<Users>(
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
                                    hintMaxLines:
                                    1,
                                    hintText:
                                    'Phone',
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

                            //Email
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
                                    2.3,
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
                                child:
                                TextFormField(
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .9),
                                  ),

                                  initialValue: Provider.of<Users>(
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
                                    hintMaxLines:
                                    1,
                                    hintText:
                                    'Email',
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

                        //Profession

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
                                    2.1,
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
                                child:
                                TextFormField(
                                  // initialValue: addMember.homeTown,
                                  style:
                                  TextStyle(
                                    color: Colors
                                        .black
                                        .withOpacity(
                                        .9),
                                  ),

                                  controller:hometown,
                                  onChanged:
                                      (value) {
                                    addMember
                                        .homeTown =
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

                                    ),
                                    border:
                                    InputBorder
                                        .none,
                                    hintMaxLines:
                                    1,
                                    hintText: Provider.of<Users>(
                                        context)
                                        .userInfo
                                        ?.hometown ??
                                        "HomeTown",
                                    hintStyle:
                                    TextStyle(
                                      fontSize:
                                      14,
                                      color: Colors
                                          .black

                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Residential Address
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
                                    2.3,
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
                                        .black
                                        .withOpacity(
                                        .9),
                                  ),
                                  controller:
                                  residence,
                                  onChanged:
                                      (value) {
                                    addMember
                                        .residence =
                                        value;
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
                                    hintMaxLines:
                                    1,
                                    hintText:
                                    Provider.of<Users>(
                                        context)
                                        .userInfo
                                        ?.Residence ??
                                        'Residential Address',
                                    hintStyle:
                                    TextStyle(
                                      fontSize:
                                      14,
                                      color: Colors
                                          .black

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
                                    2.1,
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
                                child:
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors
                                          .black),

                                  controller:
                                  language,
                                  onChanged:
                                      (value) {
                                    addMember
                                        .language =
                                        value;
                                  },

                                  // obscureText: isPassword,
                                  // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                  decoration:
                                  InputDecoration(
                                    prefixIcon:
                                    Icon(
                                      Icons
                                          .language,
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
                                    hintText:Provider.of<Users>(
                                        context)
                                        .userInfo
                                        ?.languge ??
                                    'Language',
                                    hintStyle:
                                    TextStyle(
                                      fontSize:
                                      14,
                                      color: Colors
                                          .black

                                    ),
                                  ),
                                ),
                              ),
                            ),



                            Padding(

                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height:
                                  size.width /
                                      8,
                                  width:
                                  size.width /
                                      2.3,
                                  alignment:
                                  Alignment
                                      .center,
                                  padding: EdgeInsets.only(
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
                                  GestureDetector(
                                    onTap:
                                        () async {
                                      final datePick = await showDatePicker(
                                          context:
                                          context,
                                          initialDate:
                                          new DateTime
                                              .now(),
                                          firstDate:
                                          new DateTime(
                                              1900),
                                          lastDate:
                                          new DateTime(2100));
                                      if (datePick !=
                                          null &&
                                          datePick !=
                                              birthDate) {
                                        setState(
                                                () {
                                              birthDate =
                                                  datePick;
                                              isDateSelected =
                                              true;
                                              birthDateInString =
                                              "${birthDate!.month}/${birthDate!.day}/${birthDate!.year}";
                                            });
                                      }
                                    },
                                    child:
                                    Padding(
                                      padding: const EdgeInsets
                                          .all(
                                          10.0),
                                      child:
                                      SingleChildScrollView(
                                        child:
                                        Row(
                                          children: [
                                            new Icon(
                                              Icons.calendar_today,
                                              color:
                                              Colors.black,
                                              size:
                                              18,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child:
                                              new Text(
                                                (isDateSelected ? DateFormat.yMMMd().format(birthDate!) : initValue),
                                                style: TextStyle(
                                                  fontSize: 13,
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
                                )),
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
                                size.width /
                                    8,
                                width:
                                size.width /
                                    2.1,
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
                                child:
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors
                                          .black),
                                  controller:
                                  occupation,
                                  onChanged:
                                      (value) {
                                    addMember
                                        .Occupation =
                                        value;
                                  },
                                  // initialValue: Provider.of<Users>(context, listen: false).userInfo?.Occupasion!,
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
                                    hintMaxLines:
                                    1,
                                    hintText:
                                    Provider.of<Users>(
                                        context)
                                        .userInfo
                                        ?.Occupation ??'Occupation',
                                    hintStyle:
                                    TextStyle(
                                      fontSize:
                                      14,
                                      color: Colors
                                          .black

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
                                size.width /
                                    8,
                                width:
                                size.width /
                                    2.3,
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
                                  style: TextStyle(
                                      color: Colors
                                          .black),
                                  controller:
                                  placeofwork,
                                  onChanged:
                                      (value) {
                                    addMember
                                        .placeofwork =
                                        value;
                                  },
                                  keyboardType:
                                  TextInputType
                                      .name,
                                  decoration:
                                  InputDecoration(
                                    prefixIcon:
                                    Icon(
                                      Icons
                                          .business,
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
                                    Provider.of<Users>(
                                        context)
                                        .userInfo
                                        ?.placeofwork ??'Place Of Work',
                                    hintStyle:
                                    TextStyle(
                                      fontSize:
                                      14,
                                      color: Colors
                                          .black

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        //Marrital Status
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets
                                  .all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      "Marital Status"),
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(
                                        8.0),
                                    child:
                                    DropdownButton(
                                      // Initial Value
                                      value: MaritalStatusvalue ==
                                          null
                                          ? null
                                          : MaritalStatusvalue,

                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons
                                              .keyboard_arrow_down),

                                      // Array list of items
                                      items: MaritalStatus
                                          .map((String
                                      items) {
                                        return DropdownMenuItem(
                                          value:
                                          items,
                                          child: Text(
                                              items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged:
                                          (newValue) {
                                        setState(
                                                () {
                                              MaritalStatusvalue =
                                                  newValue.toString();
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Marriage Registered?
                            Padding(
                              padding:
                              const EdgeInsets
                                  .all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      "Marriage Registered?"),
                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .all(
                                        8.0),
                                    child:
                                    DropdownButton(
                                      // Initial Value
                                      value: MarriageRegistered ==
                                          null
                                          ? null
                                          : MarriageRegistered,

                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons
                                              .keyboard_arrow_down),

                                      // Array list of items
                                      items: MarriageRegisteredStatus
                                          .map((String
                                      items) {
                                        return DropdownMenuItem(
                                          value:
                                          items,
                                          child: Text(
                                              items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged:
                                          (newValue) {
                                        setState(
                                                () {
                                              MarriageRegistered =
                                                  newValue.toString();
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


                            //Residentiaal Address
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  io.File? image;

  Future<String> uploadFile(io.File image) async {
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
  Future biodatadb(context) async {
    final String _firebaseAuth = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> updateData = {};

    if (hometown.text != null) {
      updateData["HomeTown"] = hometown.text.toString();
    }

    if (birthDateInString != null) {
      updateData["Date Of Birth"] = birthDateInString;
    }

    if (addMember.placeofwork != null) {
      updateData["placeofwork"] = addMember.placeofwork;
    }

    if (addMember.residence != null) {
      updateData["Residence"] = addMember.residence;
    }

    if (addMember.language != null) {
      updateData["language"] = addMember.language;
    }

    if (addMember.Occupation != null) {
      updateData["Occupation"] = addMember.Occupation;
    }

    clients.child(_firebaseAuth).update(updateData);
  }

  // Future biodatadb(context) async {
  //   final String _firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
  //
  //   clients.child(_firebaseAuth).update({
  //     "HomeTown": hometown.text.toString(),
  //     "Date Of Birth":birthDateInString,
  //     "placeofwork": addMember.placeofwork,
  //     "Residence": addMember.residence,
  //     "language": addMember.language,
  //     "Occupation": addMember.Occupation,
  //
  //   });
  // }
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
