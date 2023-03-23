import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piwc/pages/login.dart';


import '../main.dart';
import '../progressdialog.dart';
import '../widgets/behavior.dart';

class registation extends StatefulWidget {
  const registation({Key? key}) : super(key: key);

  @override
  State<registation> createState() => _registationState();
}
User ?firebaseUser;
User? currentfirebaseUser;
class _registationState extends State<registation> {
  TextEditingController? email,fname,lname, password,username,phone;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'assets/images/background_image.jpg',
                    // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 100, sigmaX: 70),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .1,
                                      bottom: size.width * .1,
                                    ),
                                    child: SizedBox(
                                      height: 70,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),

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
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(.9),
                                              ),
                                              controller: username,
                                              // obscureText: isPassword,
                                              // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
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
                                            child: TextField(
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(.9),
                                              ),
                                              controller: fname,
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
                                        controller: username,
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
                                        controller: username,
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Forgotten password!',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              HapticFeedback.lightImpact();
                                              Fluttertoast.showToast(
                                                msg:
                                                'Forgotten password! button pressed',
                                              );
                                            },
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: size.width * .1),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Fluttertoast.showToast(
                                        msg: 'Sign-In button pressed',
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Sign-up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerNewUser(BuildContext context) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: "Registering,Please wait.....",
        );
      });
  registerInfirestore(context);

  firebaseUser = (await _firebaseAuth
      .createUserWithEmailAndPassword(
      email: email!.text,
      password: password!.text)
      .catchError((errMsg) {
    Navigator.pop(context);
    displayToast("Error" + errMsg.toString(), context);
  }))
      .user;

  if (firebaseUser != null) // user created

      {
    //save use into to database

    Map userDataMap = {
      "firstName": fname?.text.trim(),
      "lastName": lname?.text.trim(),
      "email": email?.text.trim(),
      "fullName":[fname?.text.trim()]  + [lname!.text.trim()],
      "phone": phone?.text.trim(),
      // "Dob":birthDate,
      // "Gender":Gender,
    };
    clients.child(firebaseUser!.uid).set(userDataMap);
    // Admin.child(firebaseUser!.uid).set(userDataMap);

    currentfirebaseUser = firebaseUser;

    displayToast("Congratulation, your account has been created", context);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => login()),
            (Route<dynamic> route) => false);
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return login();
      }),
    );
    // Navigator.pop(context);
    //error occured - display error
    displayToast("user has not been created", context);
  }
}

Future<void> registerInfirestore(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if(user!=null) {
    FirebaseFirestore.instance.collection('Clients').doc(email.toString()).set({
      'firstName': fname,
      'lastName': lname,
      'MobileNumber': phone,
      'fullName':[ fname] + [lname],
      'Email': email,
      // 'Gender': Gender,
      // 'Date Of Birth': birthDate,
    });
  }
  print("Registered");
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) {
  //     return SignInScreen();
  //   }),
  // );


}

  displayToast(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}