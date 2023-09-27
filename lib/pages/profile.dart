import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Membershipform/Addmember.dart';
import '../model/Users.dart';

class MemberProfile extends StatefulWidget {
  MemberProfile({Key? key}) : super(key: key);

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  final addedMember addMember = addedMember();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var firstname = Provider.of<Users>(context).userInfo?.fname!;
    var lastname = Provider.of<Users>(context).userInfo?.lname!;
    var email = Provider.of<Users>(context).userInfo?.email!;
    var Occupation = Provider.of<Users>(context).userInfo!.Occupation!;

    // var education = Provider.of<otherUsermodel>(context).otherinfo!.Education;
    // var experience =
    //     Provider.of<otherUsermodel>(context).otherinfo?.Experience;
    // //var location = Provider.of<otherUsermodel>(context).otherinfo!.location!;
    // var Description =
    //     Provider.of<otherUsermodel>(context).otherinfo?.Description;
    // var Service = Provider.of<otherUsermodel>(context).otherinfo?.Service;
    // var Institution =
    //     Provider.of<otherUsermodel>(context).otherinfo?.Institution;

    Size size = MediaQuery.of(context).size / 3;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
            child: Container(
              // padding: const EdgeInsets.only(left: 16, top: 55, right: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Profile Photo
                        Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,

                              // image: const DecorationImage(
                              //     fit: BoxFit.cover,
                              //     image: NetworkImage(
                              //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                              //     ))),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 70,
                              backgroundImage: Provider.of<Users>(context)
                                          .userInfo
                                          ?.profilepicture !=
                                      null
                                  ? NetworkImage(
                                      Provider.of<Users>(context)
                                          .userInfo!
                                          .profilepicture!,
                                    )
                                  : null,
                            )),
                        //email
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "${firstname} " + "${lastname}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  email ?? "" + " ",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  " ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${Occupation} •",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),

                              // Text(Description,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "",
                                  maxLines: 10,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                        height: size.height,
                        width: width,
                        child: Card(
                          color: Colors.white12,
                          elevation: 8,
                          shadowColor: Colors.black38,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side:
                                  BorderSide(width: 2, color: Colors.white24)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('',
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              ),
                              // Text(Description??"")

                              // Icon(
                              //   Icons.add,
                              //   color: Colors.white,
                              // ),
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
        ],
      ),
    );
  }
}
