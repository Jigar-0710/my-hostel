// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostelapplication/core/constant/string.dart';
import 'package:hostelapplication/logic/modules/userData_model.dart';
import 'package:hostelapplication/logic/service/auth_services/auth_service.dart';
import 'package:hostelapplication/presentation/screen/student/Drawer/mycomplaint.dart';
import 'package:hostelapplication/presentation/screen/student/Drawer/myleave.dart';
import 'package:hostelapplication/presentation/screen/student/Drawer/myservices.dart';
import 'package:provider/provider.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData? userData;
    final authService = Provider.of<AuthService>(context);
    User user = authService.getcurrentUser();
    List<UserData> complaintList = [];
    final complaintListRaw = Provider.of<List<UserData>?>(context);
    complaintListRaw?.forEach((element) {
      if (user.uid == element.id) {
        complaintList.add(element);
      } else
        return null;
      ;
    });
    const studentDrawerText = TextStyle(fontSize: 15);
    return Drawer(
      child: SafeArea(
        child: complaintList.length == 0
            ? Container()
            : ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // _createHeader(),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, studentDetailScreenRoute);
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 75,
                                height: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        complaintList.first.userimage),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    complaintList.first.firstName +
                                        ' ' +
                                        complaintList.first.lastName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "View Profile",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 50, child: Divider()),
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.book,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('My Complaints'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Mycomplaints()));
                    },
                  ),
                  const SizedBox(width: 50, child: Divider()),
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.person_crop_circle_badge_minus,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('My Leaves'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyLeave()));
                    },
                  ),
                  const SizedBox(width: 50, child: Divider()),
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.wrench,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('My Services'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Myservicesrequest()));
                    },
                  ),
                  const SizedBox(width: 50, child: Divider()),
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.signOut,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text('Log out'),
                      ],
                    ),
                    onTap: () {
                      authService.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, logInScreenRoute, (route) => false);
                    },
                  ),
                  const SizedBox(width: 50, child: Divider()),
                ],
              ),
      ),
    );
  }
}
