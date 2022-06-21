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

class RecentFixtures extends StatefulWidget {

  @override
  _RecentFixturesState createState() => _RecentFixturesState();
}

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();
StreamSubscription<Event> fixtureSubscription;


class _RecentFixturesState extends State<RecentFixtures> {
  List<Map<dynamic, dynamic>> fixtures = new List();
  List<String> fixtureIDs = new List();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    // mRootReference
    //     .child("Fixtures").child('Results').keepSynced(true);
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fixtureSubscription.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade100,
        child:fixtures.length !=0? ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: fixtures == null ? 0 : fixtures.length,
          itemBuilder: (context, index) {
            return FixtureAdapter(
              map: fixtures[index],fixtureStatus: 'Old',
            );
          },
        ):Center(child:Text('No matchs')),
      ),
    );
  }



  void getData()  {
    fixtureSubscription=  mRootReference
        .child("Fixtures").child('Results').onValue.listen((event) {
      fixtures.clear();
      if(event.snapshot.value!=null) {
        Map<dynamic, dynamic> map = event.snapshot.value;
        // print(map);
        map.forEach((key, value) {
          print(value);
          print('\t');
          print('\t');

          fixtures.add(value);
        });

      }
      setState(() {

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
