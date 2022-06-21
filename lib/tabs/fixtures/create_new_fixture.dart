import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/components/team_adapter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:intl/intl.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class CreateNewFixture extends StatefulWidget {
  String fixtureIDExisting;

  CreateNewFixture({Key key, this.fixtureIDExisting}) : super(key: key);

  @override
  _CreateNewFixtureState createState() => _CreateNewFixtureState();
}

class _CreateNewFixtureState extends State<CreateNewFixture> {
  DateTime dateTime;
  Map<dynamic, dynamic> team1;
  Map<dynamic, dynamic> team2;
  List<Map<dynamic, dynamic>> teams = new List();
  List<Map<dynamic, dynamic>> teamToDisplay = new List();
  List<String> teamIDs = new List();
  List<String> addedTeamIDs = new List();
  List<GradeLevel> gradeLevel = GradeLevel.getCompanies();
  List<DropdownMenuItem<GradeLevel>> _dropdownMenuItems;
  GradeLevel _selectedGradeLevel;
  String  grade;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropdownMenuItems = buildDropdownMenuItems(gradeLevel);
    _selectedGradeLevel = _dropdownMenuItems[0].value;
    grade = _selectedGradeLevel.name;
    getData();
  }

  List<DropdownMenuItem<GradeLevel>> buildDropdownMenuItems(List gradeLevels) {
    List<DropdownMenuItem<GradeLevel>> items = List();
    for (GradeLevel grade in gradeLevels) {
      items.add(
        DropdownMenuItem(
          value: grade,
          child: Text(grade.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(GradeLevel selectedGradeLevel) {
    setState(() {
      _selectedGradeLevel = selectedGradeLevel;
      grade = _selectedGradeLevel.name;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Fixture'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(5.0)),
                    ),
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: dateTime == null
                        ? InkWell(
                            onTap: () async {
                              dateTime = await _selectDate(context, dateTime);
                              print('date time $dateTime');
                              setState(() {
                                print('dsgkjdghdfjghjdfgkjdhg');
                              });
                            },
                            child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 20),
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                child: Align(alignment:Alignment.centerLeft,child: Text('Assign Date',textAlign: TextAlign.start,))))
                        : InkWell(
                            onTap: () async {
                              dateTime = await _selectDate(context, dateTime);
                            },
                            child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                padding: EdgeInsets.only(left: 20),

                                child: Align(
                                    alignment:Alignment.centerLeft,
                                  child: Text(
                                    getDateString(dateTime
                                        .millisecondsSinceEpoch
                                        .toString()),
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ))),
                  )),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(5.0)),
                    ),
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child:
                    team1 == null
                        ? InkWell(

                        onTap: () async {
                          teamToDisplay.clear();

                          teamToDisplay.addAll(teams);

                          team1 = await addTeam();

                          print('team 1 $team1');
                          setState(() {});
                        },
                        child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .07,
                            padding: EdgeInsets.only(left: 20),

                            child: Align(
                                alignment:Alignment.centerLeft,

                                child: Text('Select team 1'))))
                        : InkWell(
                      onTap: () async {
                        teamToDisplay.clear();

                        teamToDisplay.addAll(teams);

                        addedTeamIDs.remove(team1['ID']);
                        team1 = null;

                        team1 = await addTeam();

                        setState(() {});
                      },
                      child: TeamAdapter(
                        map: team1,
                      ),
                    ),
                  )),


              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius:
                      new BorderRadius.all(const Radius.circular(5.0)),
                    ),
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child:
                    team2 == null
                        ? InkWell(

                        onTap: () async {
                          teamToDisplay.clear();
                          teamToDisplay.addAll(teams);

                          team2 = await addTeam();
                          setState(() {});
                        },
                        child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .07,
                            padding: EdgeInsets.only(left: 20),

                            child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Select team 2'))))
                        : InkWell(
                        onTap: () async {
                          addedTeamIDs.remove(team2['ID']);
                          teamToDisplay.clear();
                          teamToDisplay.addAll(teams);
                          team2 = null;

                          team2 = await addTeam();

                          setState(() {});
                        },
                        child: TeamAdapter(
                          map: team2,
                        )),
                  )),
              Visibility(
                visible: true,
                child: new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.all(
                            const Radius.circular(5.0)),
                      ),
                      padding: EdgeInsets.only(left: 25.0, right: 10.0),
                      child: DropdownButton(
                        underline: Text(''),
                        isExpanded: true,
                        iconSize: 30,

                        value: _selectedGradeLevel,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),
                    )),
              ),

            ],
          )),
      bottomSheet: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: AppColors.PrimaryColor, // background
              onPrimary: Colors.white,
              elevation: 5 // foreground
              ),
          onPressed: () {
            if (team2 != null && team1 != null) {
              Map<String, dynamic> data = new Map();
              String fixtureID = mRootReference.push().key;
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
              if (dateTime == null) {
                data['MatchTime'] = 'NotAssigned';
              } else {
                data['MatchTime'] = dateTime.millisecondsSinceEpoch;
              }
              data['MatchLevel'] = grade;
              data['ScreenType'] = 'Score';
              data['Status'] = 'UpComing';
              data['ID'] = fixtureID;
              data['FixtureID'] = fixtureID;

              // mRootReference
              //     .child("Teams")
              //     .child(team1['ID'])
              //     .child('Fixtures')
              //     .child('UpComing')
              //     .child(fixtureID)
              //     .set(fixtureID);
              // mRootReference
              //     .child("Teams")
              //     .child(team2['ID'])
              //     .child('Fixtures')
              //     .child('UpComing')
              //     .child(fixtureID)
              //     .set(fixtureID);
              mRootReference
                  .child('Fixtures')
                  .child('UpComing')
                  .child(fixtureID)
                  .set(data);
              Navigator.of(context).pop();
            } else {
              showdia('please fill');
            }
          },
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .07,
              child: Center(
                  child: Text(
                "SAVE",
                textScaleFactor: 1.7,
              )))),
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

  Future<Map> addTeam() async{
    Map<dynamic, dynamic> map;

   await showDialog(
      context: context,
      builder: (context) {
        String contentText = "Content of Dialog";
        return StatefulBuilder(
          builder: (context, setState) {
            return  Dialog(
              child: Container(
                  color: Colors.transparent,
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: TextFormField(

                          onChanged: (str){
                            setState(() {
                              _searchTeam(str);

                            });
                          },

                          autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon:                           Icon(Icons.search)
                                ,
                              )
                          ),

                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Container(
                          color: Colors.grey.shade100,
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: 350,
                          child: ListView.builder(
                              itemCount: teamToDisplay.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () async {
                                      bool isPresent = false;

                                      setState(() {
                                        if (addedTeamIDs
                                            .contains(teamToDisplay[index]['ID'])) {
                                          isPresent = true;
                                        }

                                        print('clickerddfgfdhdfh');
                                        if (isPresent) {
                                          showdia("Team Already present");
                                        } else {
                                          map = teamToDisplay[index];

                                          addedTeamIDs.add(map['ID']);
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4.0,
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                          new BorderRadius.all(const Radius.circular(5.0)),
                                        ),
                                        child: TeamAdapter(map: teamToDisplay[index])));
                              }),
                        ),
                      ),
                    ],
                  )),
            );
          },
        );
      },
    );
    return map;
  }

  // Future<Map> _addTeam() async {
  //   Map<dynamic, dynamic> map;
  //   await showDialog(
  //       barrierDismissible: true,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return  Dialog(
  //           child: Container(
  //               color: Colors.transparent,
  //               height: 450,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Container(
  //                     width: double.infinity,
  //                     height: 50,
  //                     child: TextFormField(
  //
  //                       onChanged: (str){
  //                         _searchTeam(str);
  //                       },
  //
  //                       decoration: InputDecoration(
  //                         suffixIcon: IconButton(
  //                           icon:                           Icon(Icons.search)
  //                           ,
  //                           onPressed: (){
  //                             Navigator.of(context).pop();
  //                             _addTeam();
  //                           },
  //                         )
  //                       ),
  //
  //                     ),
  //                   ),
  //                   new Padding(
  //                     padding: const EdgeInsets.all(10.0),
  //                     child: new Container(
  //                       color: Colors.grey.shade100,
  //                       width: MediaQuery.of(context).size.width * 1.0,
  //                       height: 350,
  //                       child: ListView.builder(
  //                           itemCount: teamToDisplay.length,
  //                           itemBuilder: (context, index) {
  //                             return InkWell(
  //                                 onTap: () async {
  //                                   bool isPresent = false;
  //
  //                                   setState(() {
  //                                     if (addedTeamIDs
  //                                         .contains(teamToDisplay[index]['ID'])) {
  //                                       isPresent = true;
  //                                     }
  //
  //                                     print('clickerddfgfdhdfh');
  //                                     if (isPresent) {
  //                                       showdia("Team Already present");
  //                                     } else {
  //                                       map = teamToDisplay[index];
  //
  //                                       addedTeamIDs.add(map['ID']);
  //                                       Navigator.of(context).pop();
  //                                     }
  //                                   });
  //                                 },
  //                                 child: Container(
  //                                   margin: EdgeInsets.all(2),
  //                                     decoration: new BoxDecoration(
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Colors.grey,
  //                                           blurRadius: 4.0,
  //                                         ),
  //                                       ],
  //                                       color: Colors.white,
  //                                       borderRadius:
  //                                       new BorderRadius.all(const Radius.circular(5.0)),
  //                                     ),
  //                                     child: TeamAdapter(map: teams[index])));
  //                           }),
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //         );
  //       });
  //   print(map);
  //   return map;
  // }

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

  void getData() {
    mRootReference.child("Teams").once().then((snapShot) {
      teams.clear();
      teamIDs.clear();
      if (snapShot.value != null) {
        Map<dynamic, dynamic> map = snapShot.value;
        map.forEach((key, value) {
          teamIDs.add(key);
          teams.add(value);
        });
      }
      teamToDisplay.clear();
      teamToDisplay.addAll(teams);
    });
  }

  void _searchTeam(String search){
    List<String> playersList=new List();
    teamToDisplay.clear();
    teams.forEach((element) {
      playersList.add(element['Player1Name'].toString()+' '+element['Player2Name'].toString());
    });
    final fuse = Fuzzy(
      playersList,
      options: FuzzyOptions(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );

    final result = fuse.search(search);

    result.forEach((element) {
      var a=element.matches;
      print(a);
      a.forEach((element) {
        print(element);
        print(element.arrayIndex);
        teamToDisplay.add(teams[element.arrayIndex]);
        print(teams[element.arrayIndex]);
      });


    });

    if(search.isEmpty){
      teamToDisplay.clear();
      teamToDisplay.addAll(teams);
    }
  }

}

class GradeLevel {
  int id;
  String name;

  GradeLevel(this.id, this.name);

  static List<GradeLevel> getCompanies() {
    return <GradeLevel>[
      GradeLevel(1, 'Final'),
      GradeLevel(2, 'Semi Final'),
      GradeLevel(3, 'Quarter Fine'),
      GradeLevel(4, 'Pre Quarter'),
      GradeLevel(5, 'Stage 4'),
      GradeLevel(6, 'Stage 3'),
      GradeLevel(7, 'Stage 2'),
      GradeLevel(8, 'Stage 1'),
    ];
  }
}