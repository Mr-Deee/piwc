import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:piwc/pages/registration.dart';
import 'package:piwc/pages/utils/color_palette.dart';
import 'dart:io' as io;
import '../Membershipform/Addmember.dart';
import '../progressdialog.dart';
import 'package:path/path.dart';
import '../main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




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
                      message: "Adding New Client,Please wait.....",
                    );
                  });

              String url = await uploadFile(image!);
              Occupationdb();

              // newProduct.group = group;
              _firestore.collection("Client").add({
                'image': url.toString(),
                'name': addMember.name.toString(),
                'IdNumber': rndnumber.toString(),
                'UserType': addMember.group.toString(),
                "TotalBalance": addMember.TotalBalance,
                'location': addMember.location,
                "Deposit amount": addMember.Deposit,
                'mobile': addMember.mobile,


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
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 50,
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              bottom: 12,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                    left: 8,
                                                    bottom: 12,
                                                  ),
                                                  child: Text(
                                                    "Input Type  : group",
                                                    style: const TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 17,
                                                      color:
                                                      ColorPalette.nileBlue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ColorPalette.white,
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 3),
                                                  blurRadius: 6,
                                                  color: ColorPalette.nileBlue
                                                      .withOpacity(0.1),
                                                ),
                                              ],
                                            ),
                                            height: 50,
                                            child: TextFormField(
                                              initialValue: addMember.name ??
                                                  '',
                                              onChanged: (value) {
                                                addMember.name = value;
                                              },
                                              textInputAction:
                                              TextInputAction.next,
                                              key: UniqueKey(),
                                              keyboardType: TextInputType.text,
                                              style: const TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Client Name",
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                hintStyle: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 16,
                                                  color: ColorPalette.nileBlue
                                                      .withOpacity(0.58),
                                                ),
                                              ),
                                              cursorColor:
                                              ColorPalette.timberGreen,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [

                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorPalette.white,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
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
                                                    cursorColor:
                                                    ColorPalette.timberGreen,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(

                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: ColorPalette.white,
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 3),
                                                  blurRadius: 6,
                                                  color: ColorPalette.nileBlue
                                                      .withOpacity(0.1),
                                                ),
                                              ],
                                            ),
                                            height: 50,
                                            child: TextFormField(
                                              initialValue:
                                              addMember.mobile ?? '',
                                              onChanged: (value) {
                                                addMember.mobile = value;
                                              },
                                              textInputAction:
                                              TextInputAction.next,
                                              key: UniqueKey(),
                                              keyboardType: TextInputType
                                                  .number,
                                              style: const TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Mobile Number ",
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                hintStyle: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 16,
                                                  color: ColorPalette.nileBlue
                                                      .withOpacity(0.58),
                                                ),
                                              ),
                                              cursorColor:
                                              ColorPalette.timberGreen,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //     color: ColorPalette.white,
                                          //     borderRadius:
                                          //     BorderRadius.circular(12),
                                          //     boxShadow: [
                                          //       BoxShadow(
                                          //         offset: const Offset(0, 3),
                                          //         blurRadius: 6,
                                          //         color: ColorPalette.nileBlue
                                          //             .withOpacity(0.1),
                                          //       ),
                                          //     ],
                                          //   ),
                                          //   height: 50,
                                          //   child: Text(""),
                                          // ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 8,
                                              bottom: 34,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorPalette.white,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
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
                                                    initialValue:
                                                    addMember.location ?? '',
                                                    onChanged: (value) {
                                                      addMember.location =
                                                          value;
                                                    },
                                                    textInputAction:
                                                    TextInputAction.next,
                                                    key: UniqueKey(),
                                                    keyboardType:
                                                    TextInputType.text,
                                                    style: const TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color:
                                                      ColorPalette.nileBlue,
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                      "Location/Digital Address",
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
                                                    cursorColor:
                                                    ColorPalette.timberGreen,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //LocationDD(product: newProduct),
                                        ],
                                      ),
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

        ));
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

    final userId = currentfirebaseUser?.email;
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
    final userId = currentfirebaseUser?.uid;

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

                child: Positioned(
                  bottom: 70,
                  right: 62,
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
              ));
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
      'name': addMember1?.name.toString(),
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

  final userId = currentfirebaseUser?.email;
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





