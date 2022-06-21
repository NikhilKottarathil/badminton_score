import 'dart:convert';
import 'dart:math';

import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/components/fixture_adapter.dart';
import 'package:badminton_score/components/team_adapter.dart';
import 'package:badminton_score/tabs/fixtures/AddFixture.dart';
import 'package:badminton_score/tabs/fixtures/create_fixture.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TournamentFixture extends StatefulWidget {
  String tournamentID, tournamentStatus;

  TournamentFixture({Key key, this.tournamentID, this.tournamentStatus})
      : super(key: key);

  @override
  _TournamentFixtureState createState() => _TournamentFixtureState();
}

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class _TournamentFixtureState extends State<TournamentFixture> {
  bool isLevelNotAdded = true;
  bool isTeamNotAdded = true;
  TextEditingController textEditingController;
  List<Map<dynamic, dynamic>> fixtures = new List();
  List<Map<dynamic, dynamic>> teams = new List();
  List<String> teamIDs = new List();
  List<String> addedTeamIDs = new List();
  List<String> fixtureIDs = new List();

  List<Level> levels = new List();

  List<DropdownMenuItem<Level>> _dropdownMenuItems;
  Level _selectedLevel;
  String currentLevel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: isTeamNotAdded
          ? Text("Please add Team and create fixture")
          : isLevelNotAdded
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'After Fixture created no team can be added',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateFixture(
                                          tournamentID: widget.tournamentID,
                                          tournamentStatus:
                                              widget.tournamentStatus,
                                        )));
                          },
                          child: Text("Create Fixture")),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1.0,
                            decoration: new BoxDecoration(
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: tournamentGradeValid == true
                              //         ? Colors.grey
                              //         : Colors.red,
                              //     blurRadius: 4.0,
                              //   ),
                              // ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            padding: EdgeInsets.only(left: 25.0, right: 10.0),
                            child: DropdownButton(
                              underline: Text(''),
                              isExpanded: true,
                              iconSize: 30,
                              value: _selectedLevel,
                              items: _dropdownMenuItems,
                              onChanged: onChangeDropdownItem,
                            ),
                          )),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(15),
                        itemCount: fixtures == null ? 0 : fixtures.length,
                        itemBuilder: (context, index) {
                          return FixtureAdapter(
                            map: fixtures[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.PrimaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddFixture(
                        tournamentStatus: widget.tournamentStatus,
                        tournamentID: widget.tournamentID,
                        teamIDs: teamIDs,
                        teams: teams,
                        addedTeamIDs: addedTeamIDs,
                        currentLevel: currentLevel,
                      )));
        },

      ),
      bottomSheet: ElevatedButton(
        onPressed: (){

        },
        child: Container(
          width: double.infinity,
          child: Text("Go to next Level"),
        ),
      ),
    );
  }

  List<DropdownMenuItem<Level>> buildDropdownMenuItems(List levels) {
    List<DropdownMenuItem<Level>> items = List();
    for (Level level in levels) {
      items.add(
        DropdownMenuItem(
          value: level,
          child: Text(level.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Level selectedGradeLevel) {
    setState(() {
      _selectedLevel = selectedGradeLevel;
    });
  }

  void getData() {
    mRootReference
        .child("Tournaments")
        .child(widget.tournamentStatus)
        .child(widget.tournamentID)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic> map = event.snapshot.value;
      if (map['Teams'] != null) {
        isTeamNotAdded = false;

        if (map["Levels"] != null) {
          currentLevel = map['CurrentLevel'];

          isLevelNotAdded = false;
          List<dynamic> levelMap = map['Levels'];
          int i = 0;
          levelMap.forEach((element) {
            levels.add(new Level(i, element));
          });
          _dropdownMenuItems = buildDropdownMenuItems(levels);
          _selectedLevel = _dropdownMenuItems[int.parse(currentLevel)].value;
          setState(() {});

          teamIDs.clear();
          teams.clear();
          if (map['TeamsInLevels'] != null) {
            mRootReference
                .child("Tournaments")
                .child(widget.tournamentStatus)
                .child(widget.tournamentID)
                .child('TeamsInLevels')
                .child(currentLevel)
                .onValue
                .listen((event) {
              Map<dynamic, dynamic> teamMap = event.snapshot.value;
              teamIDs.clear();
              teams.clear();
              teamMap.forEach((key, value) {
                mRootReference
                    .child("Teams")
                    .child(key)
                    .once()
                    .then((DataSnapshot dataSnapshot) {
                  Map<dynamic, dynamic> mapSingleTeam = dataSnapshot.value;
                  teamIDs.add(key);
                  teams.add(mapSingleTeam);
                  setState(() {});
                });
              });
            });
          }

          if (map['Fixture'] != null) {
            mRootReference
                .child("Tournaments")
                .child(widget.tournamentStatus)
                .child(widget.tournamentID)
                .child('Fixture')
                .child(currentLevel)
                .onValue
                .listen((event) {
              if (event.snapshot.value != null) {
                if (event.snapshot.value != currentLevel) {
                  try {
                    var fixMap1 = event.snapshot.value;
                    print('fixmap $fixMap1 $currentLevel');
                    Map<dynamic, dynamic> fixMap = event.snapshot.value;
                    fixtureIDs.clear();
                    fixtures.clear();
                    fixMap.forEach((key, value) {
                      mRootReference
                          .child("Fixtures")
                          .child(value)
                          .child(key)
                          .onValue
                          .listen((event) {
                        Map<dynamic, dynamic> singleFixture =
                            event.snapshot.value;

                        print('fdfdg $key $value');
                        if (fixtureIDs.contains(key)) {
                          fixtures[fixtureIDs.indexOf(key)] = singleFixture;
                        } else {
                          fixtures.add(singleFixture);
                          fixtureIDs.add(key);
                          addedTeamIDs.add(singleFixture['Team1ID']);
                          addedTeamIDs.add(singleFixture['Team2ID']);
                        }

                        setState(() {});
                      });
                    });
                  } on Exception catch (_) {}
                }
              }
            });
          }
        }
        setState(() {});
      }
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {});
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

class Level {
  int id;
  String name;

  Level(this.id, this.name);
}

String getDateString(String string) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
  final f = new DateFormat('dd-MM-yyyy hh-mm a');
  String startingdate = f.format(dateTime);

  return startingdate;
}
