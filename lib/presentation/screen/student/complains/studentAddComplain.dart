import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostelapplication/logic/modules/userData_model.dart';
import 'package:hostelapplication/logic/provider/complaint_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class StudentAddComplaintScreen extends StatelessWidget {
  const StudentAddComplaintScreen(this.complainTitle, this.studentId,
      {Key? key})
      : super(key: key);
  final String complainTitle;
  final String studentId;

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<List<UserData>?>(context);
    final complaintProvider = Provider.of<ComplaintProvider>(context);
    Iterable<UserData>? userData =
        userList?.where((element) => studentId == element.id);
    DateTime now = DateTime.now();
    const tablepadding = EdgeInsets.all(15);
    return Scaffold(
      appBar: AppBar(title: const Text("Add Complaint")),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(183, 235, 237, 237),
                          ),
                          child: Table(
                            // defaultColumnWidth: FixedColumnWidth(120.0),
                            columnWidths: const {
                              0: FixedColumnWidth(120),
                              1: FlexColumnWidth(),
                            },
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1),
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: tablepadding,
                                  child: Column(children: const [
                                    Center(
                                      child: Text(
                                        'Name',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  ]),
                                ),
                                Padding(
                                  padding: tablepadding,
                                  child: Column(children: [
                                    Text(
                                      userData.first.firstName +
                                          ' ' +
                                          userData.first.lastName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ]),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: tablepadding,
                                  child: Column(children: const [
                                    Text(
                                      'Room No.',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ]),
                                ),
                                Padding(
                                  padding: tablepadding,
                                  child: Column(children: [
                                    Text(
                                      userData.first.roomNo,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ]),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: tablepadding,
                                  child: Column(children: const [
                                    Text(
                                      'Date',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ]),
                                ),
                                Padding(
                                  padding: tablepadding,
                                  child: Column(children: [
                                    Text(
                                      DateTime(now.year, now.month, now.day)
                                          .toString()
                                          .replaceAll("00:00:00.000", ""),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )
                                  ]),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 18, right: 18, bottom: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Complaint ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(": "),
                                  Text(
                                    complainTitle,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: TextFormField(
                                  onChanged: ((value) =>
                                      complaintProvider.changeComplaint(value)),
                                  decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      hintText:
                                          "Type your complaint here...... 🖍",
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  maxLines: 8,
                                  keyboardType: TextInputType.multiline,
                                  maxLength: 1000,
                                  cursorColor: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 20,
                        child: FloatingActionButton(
                            onPressed: () {
                              complaintProvider
                                  .changeComplaintTitle(complainTitle);
                              complaintProvider.changeStudentUid(studentId);
                              complaintProvider.changeName(
                                  userData.first.firstName +
                                      ' ' +
                                      userData.first.lastName);
                              complaintProvider
                                  .changeRoomNo(userData.first.roomNo);
                              complaintProvider.saveComplaint();
                              sendNotification();
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.done,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
    );
  }
}

Future<void> sendNotification() async {
  var token;
  await FirebaseFirestore.instance
      .collection('AToken')
      .doc('token')
      .get()
      .then((value) => token = value['adminToken']);

  String constructFCMPayload(String token) {
    return jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': "Check new complaint in complaint",
          'title': "New Complaint",
        },
        'to': token
      },
    );
  }

  try {
    //Send  Message
    http.Response response =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAA7KBLHFY:APA91bHE6iUriXpBHKmdInRpJh_OAY8yLwb8FvZ_v5NqbccEGMm1RqYoSick6-mjlOmlJatapa7HbtgZBl0ef1WhQ7WhLbM-g0xUjLfgWOtMtT77b81b7j1_OqwaiEt4AclOZ-UhmOrw',
            },
            body: constructFCMPayload(token));

    print("status: ${response.statusCode} | Message Sent Successfully!");
  } catch (e) {
    print("error in push notification $e");
  }
}
