import 'package:badminton_score/components/team_adapter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DatabaseReference mRootReference=FirebaseDatabase.instance.reference();
class AddFixture extends StatefulWidget {
  String tournamentID, tournamentStatus;
  List<Map<dynamic, dynamic>> teams = new List();
  List<String> teamIDs = new List();
  List<String> addedTeamIDs = new List();
  String currentLevel;

  AddFixture(
      {this.tournamentID,
      this.tournamentStatus,
      this.teams,
      this.teamIDs,
      this.addedTeamIDs,this.currentLevel});

  @override
  _AddFixtureState createState() => _AddFixtureState();
}

class _AddFixtureState extends State<AddFixture> {
  DateTime dateTime;
  Map<dynamic, dynamic> team1;
  Map<dynamic, dynamic> team2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dateTime == null
              ? ElevatedButton(
                  onPressed: () async {
                    dateTime = await _selectDate(context, dateTime);
                    print('date time $dateTime');
                    setState(() {
                      print('dsgkjdghdfjghjdfgkjdhg');
                    });
                  },
                  child: Text('Assign Date'))
              : TextButton(
                  onPressed: () async {
                    dateTime = await _selectDate(context, dateTime);
                  },
                  child: Text(
                    getDateString(dateTime.millisecondsSinceEpoch.toString()),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
          team1 == null
              ? ElevatedButton(
                  onPressed: () async {
                    team1 = await _addTeam();

                    print('team 1 $team1');
                    setState(() {});
                  },
                  child: Text('Select team 1'))
              : InkWell(
            onTap: () async {
              widget.addedTeamIDs.remove(team1['ID']);
              team1 = null;

              team1 = await _addTeam();

              setState(() {});
            },
                child: TeamAdapter(
                    map: team1,
                  ),
              ),
          team2 == null
              ? ElevatedButton(
                  onPressed: () async {
                    team2 = await _addTeam();

                    setState(() {});
                  },
                  child: Text('Select team 2'))
              : InkWell(
                  onTap: () async {
                    widget.addedTeamIDs.remove(team2['ID']);
                    team2 = null;

                    team2 = await _addTeam();

                    setState(() {});
                  },
                  child: TeamAdapter(
                    map: team2,
                  )),
          ElevatedButton(onPressed: (){
            if(team2!=null && team1!=null ){
              Map<String, dynamic> data = new Map();
              String fixtureID=mRootReference.push().key;
              data['Team1Name'] = team1['TeamName'];
              data['Team1ID'] = team1['ID'];
              data['Team1LogoUrl'] = team1['LogoUrl'];
              data['Team1Player1'] = team1['Player1Name'];
              data['Team1Player2'] = team1['Player2Name'];

              data['Team2Name'] = team2['TeamName'];
              data['Team2ID'] = team2['ID'];
              data['Team2LogoUrl'] = team2['LogoUrl'];
              data['Team2Player1'] = team2['Player1Name'];
              data['Team2Player2'] = team2['Player2Name'];


              data['CreatedTime'] = DateTime.now().millisecondsSinceEpoch;
              if(dateTime==null) {
                data['MatchTime'] = 'NotAssigned';
              }else{
                data['MatchTime'] = dateTime.millisecondsSinceEpoch;

              }
              data['MatchLevel'] = widget.currentLevel;
              data['Status'] = 'UpComing';
              data['ID'] = fixtureID;

              mRootReference
                  .child("Teams")
                  .child(team1['ID'])
                  .child('Fixtures')
                  .child('UpComing')
                  .child(fixtureID)
                  .set(fixtureID);
              mRootReference
                  .child("Teams")
                  .child(team2['ID'])
                  .child('Fixtures')
                  .child('UpComing')
                  .child(fixtureID)
                  .set(fixtureID);
              mRootReference
                  .child("Tournaments")
                  .child(widget.tournamentStatus)
                  .child(widget.tournamentID)
                  .child('Fixture')
              .child(widget.currentLevel)
                  .child(fixtureID)
                  .set('UpComing');
              mRootReference
                  .child('Fixtures')
                  .child('UpComing')
                  .child(fixtureID)
                  .set(data);
              Navigator.of(context).pop();
            }else{
              showdia('please fill');
            }
          }, child: Text("SAVE"))
        ],
      )),
    );
  }

  Future<DateTime> _selectDate(
      BuildContext context, DateTime assignDateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null) {
      var selectedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (selectedTime != null) {
        assignDateController = new DateTime(picked.year, picked.month,
            picked.day, selectedTime.hour, selectedTime.minute);
        print(picked);
        print(assignDateController);
        return assignDateController;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String getDateString(String string) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
    final f = new DateFormat('dd-MM-yyyy hh-mm a');
    String startingdate = f.format(dateTime);

    return startingdate;
  }

  Future<Map> _addTeam() async {
    Map<dynamic, dynamic> map;
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return new Dialog(
            child: Container(
                color: Colors.transparent,
                height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                        color: Colors.grey.shade100,
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: 350,
                        child: ListView.builder(
                            itemCount: widget.teams.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () async {
                                    bool isPresent = false;

                                    setState(() {
                                      if (widget.addedTeamIDs.contains(
                                          widget.teams[index]['ID'])) {
                                        isPresent = true;
                                      }

                                      print('clickerddfgfdhdfh');
                                      if (isPresent) {
                                        showdia("Team Already present");
                                      } else {
                                        map = widget.teams[index];

                                        widget.addedTeamIDs.add(map['ID']);
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                                  child: TeamAdapter(map: widget.teams[index]));
                            }),
                      ),
                    ),
                  ],
                )),
          );
        });
    print(map);
    return map;
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
