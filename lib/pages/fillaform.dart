import 'dart:io';
import 'dart:io' as io;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:piwc/pages/registration.dart';
import 'package:piwc/pages/utils/color_palette.dart';
import 'package:provider/provider.dart';

import '../Membershipform/Addmember.dart';
import '../main.dart';
import '../model/Users.dart';
import '../progressdialog.dart';




class fillaform extends StatefulWidget {
  const fillaform({Key? key, this.group, this.client, this.docID}) : super(key: key);
  final String? group;
  final addedMember? client;
  final String? docID;
  @override
  State<fillaform> createState() => _fillaformState();
}

class _fillaformState extends State<fillaform> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
              Occupationdb();

              // newProduct.group = group;
              _firestore.collection("Members").add({
                'image': url.toString(),
                // 'name': addMember.name.toString(),
               "": rndnumber.toString(),
                "": addMember.group.toString(),
                "": addMember.TotalBalance,
                "": addMember.location,
                "": addMember.Deposit,
                "": addMember.mobile,


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
                    flex:1,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
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
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [

                                        //Username
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: size.width / 8,
                                                  width: size.width /2.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(right: size.width / 30),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                      color: Colors.white.withOpacity(.9),
                                                    ),

                                                    initialValue: Provider.of<Users>(context).userInfo?.fname?? '',

                                                    onChanged: (rndnumber) {
                                                      addMember.accountNumber ==rndnumber;
                                                    },
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.account_circle_outlined,
                                                        color: Colors.white.withOpacity(.8),
                                                      ),
                                                      border: InputBorder.none,
                                                      hintMaxLines: 1,
                                                      hintText:'First Name',
                                                      hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white.withOpacity(.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: size.width / 8,
                                                  width: size.width / 2.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(right: size.width / 30),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                      color: Colors.white.withOpacity(.9),
                                                    ),


                                                    initialValue:Provider.of<Users>(context).userInfo?.lname?? '',
                                                    // controller: lname,
                                                    // onChanged: (value){
                                                    //   _lastname = value;
                                                    // },
                                                    // obscureText: isPassword,
                                                    // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.account_circle_outlined,
                                                        color: Colors.white.withOpacity(.8),
                                                      ),
                                                      border: InputBorder.none,
                                                      hintMaxLines: 1,
                                                      hintText:'Last Name',
                                                      hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white.withOpacity(.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: size.width / 8,
                                                  width: size.width /2.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(right: size.width / 30),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                      color: Colors.white.withOpacity(.9),
                                                    ),

                                                    initialValue: Provider.of<Users>(context).userInfo?.fname?? '',

                                                    onChanged: (rndnumber) {
                                                      addMember.accountNumber ==rndnumber;
                                                    },
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.account_circle_outlined,
                                                        color: Colors.white.withOpacity(.8),
                                                      ),
                                                      border: InputBorder.none,
                                                      hintMaxLines: 1,
                                                      hintText:'First Name',
                                                      hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white.withOpacity(.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: size.width / 8,
                                                  width: size.width / 2.4,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(right: size.width / 30),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: TextFormField(
                                                    style: TextStyle(
                                                      color: Colors.white.withOpacity(.9),
                                                    ),


                                                    initialValue:Provider.of<Users>(context).userInfo?.lname?? '',
                                                    // controller: lname,
                                                    // onChanged: (value){
                                                    //   _lastname = value;
                                                    // },
                                                    // obscureText: isPassword,
                                                    // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.account_circle_outlined,
                                                        color: Colors.white.withOpacity(.8),
                                                      ),
                                                      border: InputBorder.none,
                                                      hintMaxLines: 1,
                                                      hintText:'Last Name',
                                                      hintStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white.withOpacity(.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //email
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: size.width / 8,
                                            width: size.width / 1.25,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                right: size.width / 30),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(.1),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(.9),
                                              ),

                                              // obscureText: isPassword,
                                              // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  color: Colors.white.withOpacity(.8),
                                                ),
                                                border: InputBorder.none,
                                                hintMaxLines: 1,
                                                hintText: 'Email...',
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white.withOpacity(.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //pass
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: size.width / 8,
                                            width: size.width / 1.25,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                right: size.width / 30),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(.1),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(.9),
                                              ),

                                              obscureText: true,
                                              // keyboardType: isPassword ? TextInputType.name : TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.password,
                                                  color: Colors.white.withOpacity(.8),
                                                ),
                                                border: InputBorder.none,
                                                hintMaxLines: 1,
                                                hintText: 'Password...',
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white.withOpacity(.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),





                                        Row(
                                          children: [

                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue: "",

                                                  //rndnumber,
                                                  // newProduct.accountNumber == rndnumber
                                                  //     ? rndnumber
                                                  //     : rndnumber,
                                                  //newProduct.quantity
                                                  //.toString(),
                                                  // onChanged: (rndnumber) {
                                                  //   newProduct.accountNumber ==rndnumber;
                                                  // },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: rndnumber,
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: ColorPalette
                                                      .timberGreen,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue: "",

                                                  //rndnumber,
                                                  // newProduct.accountNumber == rndnumber
                                                  //     ? rndnumber
                                                  //     : rndnumber,
                                                  //newProduct.quantity
                                                  //.toString(),
                                                  // onChanged: (rndnumber) {
                                                  //   newProduct.accountNumber ==rndnumber;
                                                  // },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: rndnumber,
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: ColorPalette
                                                      .timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [

                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue: "",

                                                  //rndnumber,
                                                  // newProduct.accountNumber == rndnumber
                                                  //     ? rndnumber
                                                  //     : rndnumber,
                                                  //newProduct.quantity
                                                  //.toString(),
                                                  // onChanged: (rndnumber) {
                                                  //   newProduct.accountNumber ==rndnumber;
                                                  // },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: rndnumber,
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: ColorPalette
                                                      .timberGreen,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue: "",

                                                  //rndnumber,
                                                  // newProduct.accountNumber == rndnumber
                                                  //     ? rndnumber
                                                  //     : rndnumber,
                                                  //newProduct.quantity
                                                  //.toString(),
                                                  // onChanged: (rndnumber) {
                                                  //   newProduct.accountNumber ==rndnumber;
                                                  // },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: rndnumber,
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: ColorPalette
                                                      .timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),    Row(
                                          children: [

                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue: "",

                                                  //rndnumber,
                                                  // newProduct.accountNumber == rndnumber
                                                  //     ? rndnumber
                                                  //     : rndnumber,
                                                  //newProduct.quantity
                                                  //.toString(),
                                                  // onChanged: (rndnumber) {
                                                  //   newProduct.accountNumber ==rndnumber;
                                                  // },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: rndnumber,
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: ColorPalette
                                                      .timberGreen,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                      const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue: "",

                                                  //rndnumber,
                                                  // newProduct.accountNumber == rndnumber
                                                  //     ? rndnumber
                                                  //     : rndnumber,
                                                  //newProduct.quantity
                                                  //.toString(),
                                                  // onChanged: (rndnumber) {
                                                  //   newProduct.accountNumber ==rndnumber;
                                                  // },
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                  TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: rndnumber,
                                                    filled: true,
                                                    fillColor:
                                                    Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor: ColorPalette
                                                      .timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //LocationDD(product: newProduct),
                                      ],
                                    ),
                                  ),

                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10),
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
                                                          Radius.circular(100),
                                                        ),
                                                        side: BorderSide(
                                                            width: 2,
                                                            color: Colors
                                                                .white24)),
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                          22),
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
                                                              child:


                                                              ImagePro()
                                                          )
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
                                          ))
                                  )
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

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("$myUid/${basename(image.path)}");

    await ref.putFile(image);


    downloadUrl = await ref.getDownloadURL();


    return downloadUrl;
  }

  getImageFromCamera() async {
    final picker = ImagePicker();
    final dateTime = DateTime.now();

    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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
        .refFromURL("gs://capitalsusu.appspot.com/")
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
                  backgroundImage:
                  (image != null) ? FileImage(
                      io.File(image!.path)) as ImageProvider : AssetImage(
                      "assets/images/user_icon.png"),

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

  Occupationdb() async {
    // String url = await uploadsFile();
    String url = await uploadFile(image!);
    Map userDataMap = {
      'profile': url.toString(),
      // 'name': addMember1?.name.toString(),
      'Deposit': addMember1?.Deposit.toString(),
      "TotalBalance": addMember1?.TotalBalance,
      'Amount': rndnumber.toString(),
      'mobile': addMember1?.mobile.toString(),
    };

    clients.child("Client").set(userDataMap);
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

  Reference ref = FirebaseStorage.instance
      .ref()
      .child("$myUid/${basename(image.path)}");

  await ref.putFile(image);


  downloadUrl = await ref.getDownloadURL();


  return downloadUrl;
}





