import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/components/fixture_adapter.dart';
import 'package:badminton_score/components/team_adapter.dart';
import 'package:badminton_score/tabs/fixtures/AddFixture.dart';
import 'package:badminton_score/tabs/fixtures/create_fixture.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpComingFixtures extends StatefulWidget {
  @override
  _UpComingFixturesState createState() => _UpComingFixturesState();
}

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

StreamSubscription<Event> fixtureSubscription;

class _UpComingFixturesState extends State<UpComingFixtures> {
  List<Map<dynamic, dynamic>> fixtures = new List();

  List<String> fixtureIDs = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mRootReference
    //     .child("Fixtures").child('UpComing').keepSynced(true);
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fixtureSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade100,
        child: fixtures.length != 0
            ? ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: fixtures == null ? 0 : fixtures.length,
                itemBuilder: (context, index) {
                  return FixtureAdapter(
                    map: fixtures[index],
                  );
                },
              )
            : Center(child: Text('No matchs')),
      ),
    );
  }

  void getData() async {
    fixtureSubscription = mRootReference
        .child("Fixtures")
        .child('UpComing')
        .onValue
        .listen((event) {
      fixtures.clear();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value;
        print("lllllllllllllllllllllll");
        map.forEach((key, value) {
          print(value);
          print('\t');
          print('\t');

          fixtures.add(value);
        });
      }
      print(fixtures.length);

      setState(() {
        fixtures = fixtures;
      });
    });


  }

  void showdia(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

String getDateString(String string) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
  final f = new DateFormat('dd-MM-yyyy hh-mm a');
  String startingdate = f.format(dateTime);

  return startingdate;
}
