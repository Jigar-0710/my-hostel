// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostelapplication/logic/modules/complaint_model.dart';
import 'package:hostelapplication/logic/provider/complaint_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ApproveDenyComplainList extends StatelessWidget {
  ApproveDenyComplainList(this.complaint, {Key? key}) : super(key: key);
  Complaint complaint;

  @override
  Widget build(BuildContext context) {
    final complaintProvider = Provider.of<ComplaintProvider>(context);
    const tablepadding = EdgeInsets.all(15);
    final remarkController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approve/Denny Complaint'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18,
                right: 18,
                bottom: 50,
              ),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.grey),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Table(
                          // defaultColumnWidth: FixedColumnWidth(120.0),
                          columnWidths: const {
                            0: FixedColumnWidth(120),
                            1: FlexColumnWidth(),
                          },
                          border: TableBorder.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: tablepadding,
                                  child: Column(
                                    children: const [
                                      Center(
                                        child: Text(
                                          'Name',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: tablepadding,
                                  child: Column(
                                    children: [
                                      Text(
                                        complaint.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: tablepadding,
                                  child: Column(
                                    children: const [
                                      Text(
                                        'Room No.',
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: tablepadding,
                                  child: Column(
                                    children: [
                                      Text(
                                        complaint.roomNo,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: tablepadding,
                                  child: Column(
                                    children: const [
                                      Text(
                                        'Date',
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: tablepadding,
                                  child: Column(
                                    children: [
                                      Text(
                                        complaint.time.day.toString() +
                                            '/' +
                                            complaint.time.month.toString() +
                                            '/' +
                                            complaint.time.year.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Complaint ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(": "),
                        Text(
                          complaint.complaintTitle,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(157, 158, 158, 158)),
                      ),
                      child: Text(complaint.complaint),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: remarkController,
                        decoration: InputDecoration(
                            hintText: 'Remark',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onDoubleTap: () {
                              complaintProvider.changeRemark(
                                  remarkController.text, complaint.id);
                              complaintProvider.changeStatus(2, complaint.id);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red[400],
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20))),
                              margin: const EdgeInsets.all(1),
                              height: 50,
                              child: const Center(
                                child: Text(
                                  'Denny',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              complaintProvider.changeRemark(
                                  remarkController.text, complaint.id);
                              complaintProvider.changeStatus(1, complaint.id);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[400],
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20))),
                              margin: const EdgeInsets.all(1),
                              height: 50,
                              child: const Center(
                                child: Text(
                                  'Approve',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            'body': "You have a new Complaint from",
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
}
