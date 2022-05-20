import 'dart:math';

import 'package:agile_dev_2022/controller/database/database.dart';
import 'package:agile_dev_2022/controller/task_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showDailyPopup(BuildContext context, dailyButtonStyle) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hey there! How're you feeling today?",
              style: GoogleFonts.roboto(
                  fontSize: 20, color: Color.fromRGBO(33, 34, 39, 1.0))),
          content: SingleChildScrollView(
              child: ListBody(
            children: <Widget>[
              Text('Choose a value from 5 (very happy) to 1 (very sad)')
            ],
          )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: dailyButtonStyle,
                    onPressed: () {
                      DateTime now = new DateTime.now();
                      DateTime date =
                          new DateTime(now.year, now.month, now.day);
                      // insert API/DB calls here
                      addMentalStateReport(MentalStateReportData(
                          value: 2, createdDate: date.toIso8601String()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added result to overview chart!"),
                      ));
                      Navigator.pop(context);
                    },
                    child: Text('5',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 20))),
                ElevatedButton(
                    style: dailyButtonStyle,
                    onPressed: () {
                      DateTime now = new DateTime.now();
                      DateTime date =
                          new DateTime(now.year, now.month, now.day);
                      // insert API/DB calls here
                      addMentalStateReport(MentalStateReportData(
                          value: 2, createdDate: date.toIso8601String()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added result to overview chart!"),
                      ));
                      Navigator.pop(context);
                    },
                    child: Text('4',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 20))),
                ElevatedButton(
                    style: dailyButtonStyle,
                    onPressed: () {
                      DateTime now = new DateTime.now();
                      DateTime date =
                          new DateTime(now.year, now.month, now.day);
                      // insert API/DB calls here
                      addMentalStateReport(MentalStateReportData(
                          value: 2, createdDate: date.toIso8601String()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added result to overview chart!"),
                      ));
                      Navigator.pop(context);
                    },
                    child: Text('3',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 20))),
                ElevatedButton(
                    style: dailyButtonStyle,
                    onPressed: () {
                      DateTime now = new DateTime.now();
                      DateTime date =
                          new DateTime(now.year, now.month, now.day);
                      // insert API/DB calls here
                      addMentalStateReport(MentalStateReportData(
                          value: 2, createdDate: date.toIso8601String()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added result to overview chart!"),
                      ));
                      Navigator.pop(context);
                    },
                    child: Text('2',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 20))),
                ElevatedButton(
                    style: dailyButtonStyle,
                    onPressed: () {
                      DateTime now = new DateTime.now();
                      DateTime date =
                          new DateTime(now.year, now.month, now.day);
                      // insert API/DB calls here
                      addMentalStateReport(MentalStateReportData(
                          value: 2, createdDate: date.toIso8601String()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added result to overview chart!"),
                      ));
                      Navigator.pop(context);
                    },
                    child: Text('1',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 20))),
              ],
            ),
          ],
        );
      });
}
