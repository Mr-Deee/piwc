import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piwc/pages/login.dart';
import 'package:piwc/pages/profile.dart';
import 'package:piwc/pages/ScanQR.dart';

import 'package:piwc/pages/widgets/widget_selection.dart';
import 'package:provider/provider.dart';

import '../model/Users.dart';
import '../model/assistantmethods.dart';
import '../widgets/behavior.dart';
import 'fillaform.dart';

class homepage extends StatefulWidget {
  static const String idScreen = "homepage";
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  void initState() {
    AssistantMethods.getCurrentOnlineUserInfo(context);
    // TODO: implement initState
    super.initState();
    AssistantMethods.getCurrentOnlineUserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black12,
        body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
                child: SizedBox(
                    height: size.height,
                    child: Stack(children: [
                      SizedBox(
                        height: size.height,
                        child: Image.asset(
                          'assets/images/background_image.jpg',
                          // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Center(
                          child: Column(children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        Expanded(
                            flex: 7,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaY: 100, sigmaX: 100),
                                    child: SizedBox(
                                      width: size.width * .95,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 28.0, left: 28, right: 28),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        14.0),
                                                                child: Text(
                                                                  "Hi",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (Provider.of<Users>(
                                                                      context)
                                                                  .userInfo
                                                                  ?.fname !=
                                                              null)
                                                            Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    Provider.of<Users>(
                                                                            context)
                                                                        .userInfo!
                                                                        .fname!,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            21),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            130,
                                                                        right:
                                                                            10,
                                                                        top:
                                                                            8.0,
                                                                        bottom:
                                                                            9),
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      showDialog<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        barrierDismissible:
                                                                            false, // user must tap button!
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Sign Out'),
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            content:
                                                                                SingleChildScrollView(
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Text('Are you certain you want to Sign Out?'),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                child: Text(
                                                                                  'Yes',
                                                                                  style: TextStyle(color: Colors.black),
                                                                                ),
                                                                                onPressed: () {
                                                                                  print('yes');
                                                                                  FirebaseAuth.instance.signOut();
                                                                                  Navigator.pushNamedAndRemoveUntil(context, login.idScreen, (route) => false);
                                                                                  // Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                child: Text(
                                                                                  'Cancel',
                                                                                  style: TextStyle(color: Colors.red),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .logout,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0, left: 18),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      AssistantMethods.getCurrentOnlineUserInfo(context);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  fillaform()));
                                                    },
                                                    child: Widget_selection(
                                                      image:
                                                          'assets/images/fo.png',
                                                      title: 'Update  Details',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MemberProfile()));
                                                    },
                                                    child: Widget_selection(
                                                      image:
                                                          'assets/images/fillprofile.png',
                                                      title: 'My Profile',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScanQR()));
                                              },
                                              child: Widget_selection(

                                                image:
                                                    'assets/images/QR.png',
                                                title: 'SCAN QR',

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))))
                      ]))
                    ])))));
  }
}
