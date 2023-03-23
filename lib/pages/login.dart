import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piwc/pages/registration.dart';

import '../widgets/behavior.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController? email,fname,lname, password,username,phone;

  @override
  Widget build(BuildContext context) {
    bool? isPassword;
    Size size = MediaQuery.of(context).size;
    return   Scaffold(
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
                                      height: 80,
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),

                          //Username


                            //email
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.width / 8,
                                width: size.width / 1.25,
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
                                        Icons.person,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                    border: InputBorder.none,
                                    hintMaxLines: 1,
                                    hintText:'Username...',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Phone
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: size.width / 8,
                                width: size.width / 1.25,
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
                                  controller: email,
                                  // obscureText: isPassword,
                                  // keyboardType: isEmail ? TextInputType.name : TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                        Icons.email,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                    border: InputBorder.none,
                                    hintMaxLines: 1,
                                    hintText:'Email...',
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
                                      InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(
                                            'Create an account.',
                                            style: TextStyle(
                                                color:  Color(0xFFb1b2c4),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) {
                                              return registation();
                                            }),
                                          );
                                        },
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
                                        'Sign-In',
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

  Widget component(
      IconData icon, String hintText, bool isPassword, bool isEmail, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.width / 8,
        width: size.width / 1.25,
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
          controller: controller,
          obscureText: isPassword,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white.withOpacity(.8),
            ),
            border: InputBorder.none,
            hintMaxLines: 1,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}



