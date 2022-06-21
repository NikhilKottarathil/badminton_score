import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/match_page_2.dart';
import 'package:badminton_score/matchpage.dart';
import 'package:badminton_score/start_match.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FixtureAdapter extends StatefulWidget {
  Map<dynamic, dynamic> map;
  String fixtureStatus;

  FixtureAdapter({this.map, this.fixtureStatus});

  @override
  _FixtureAdapterState createState() => _FixtureAdapterState();
}

DatabaseReference mRootReference=FirebaseDatabase.instance.reference();
class _FixtureAdapterState extends State<FixtureAdapter> {
  DateTime assignDateController;
  String set1Team1Point = '0', set2Team1Point = '0', set3Team1Point = '0';
  String set1Team2Point = '0', set2Team2Point = '0', set3Team2Point = '0';
  int team2Point = 0, team1Point = 0;
  int pointType = 1;

  String currentSet = '1';

  String winTeam = '';

  @override
  void initState() {
    Map<dynamic, dynamic> map = widget.map;
    // TODO: implement initState
    print('fixture adapter $map');
    super.initState();
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    _getData();

    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onLongPress: (){
          confirmDelete((){
            if(widget.fixtureStatus == null){
              mRootReference.child('Fixtures')
                  .child(widget.map['Status'])
                  .child(widget.map['ID'])
                  .remove();
            }else {
              mRootReference.child('Fixtures')
                  .child(widget.map['Status'])
                  .child(widget.map['FixtureID'])
                  .remove();
            }
          });
        },
        onTap: () {
          if (widget.fixtureStatus == null) {
            if (widget.map['Sets'] == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StartMatch(
                            fixtureID: widget.map['ID'],
                            fixtureStatus: widget.map['Status'],
                            map: widget.map,
                          )));
            } else {
              bool isStarted = true;
              List<dynamic> sets = widget.map['Sets'];
              int i = 0;
              sets.forEach((element) {
                if (i == sets.length - 1) {
                  if (element['Shifts'] == null) {
                    isStarted = false;
                  }
                }
                i++;
              });
              if (isStarted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MatchPage2(
                              fixtureID: widget.map['ID'],
                              fixtureStatus: widget.map['Status'],
                              pointType: widget.map['PointType'],
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MatchPage(
                              fixtureID: widget.map['ID'],
                              fixtureStatus: widget.map['Status'],
                              pointType: widget.map['PointType'],
                              currentSet: (sets.length - 1).toString(),
                            )));
              }
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.map['ID']=='Live1'|| widget.map['ID']=='Live2'?Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(widget.map['ID'],textAlign: TextAlign.center,style: TextStyle(color: AppColors.PrimaryColor,fontWeight: FontWeight.bold,fontSize: 22),),
            ):Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width:MediaQuery.of(context).size.width*.43,
                            child: Text(
                              widget.map['Team1Player1'] +
                                  " & " +
                                  widget.map['Team1Player2'],

                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),softWrap: true,
                            ),
                          ),
                          winTeam == 'Team1'
                              ? Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Image.asset(
                                    'images/trophy.png',
                                    width: 25,
                                  ))
                              : Container(),
                        ],
                      ),
                      new Container(
                          height: 25,
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('images/vs.png')),
                      Row(
                        children: [
                          SizedBox(
                            width:MediaQuery.of(context).size.width*.43,
                            child: Text(

                              widget.map['Team2Player1'] +
                                  " & " +
                                  widget.map['Team2Player2'],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),softWrap: true,
                            ),
                          ),
                          winTeam == 'Team2'
                              ? Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Image.asset(
                                    'images/trophy.png',
                                    width: 25,
                                  ))
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: currentSet == '1'
                        ? BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(4),
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          set1Team1Point,
                          style: TextStyle(
                              fontSize: 16,
                              color: int.parse(set1Team1Point) >
                                      int.parse(set1Team2Point)
                                  ? Colors.green
                                  : Colors.black),
                        ),
                        Text(set1Team2Point,
                            style: TextStyle(
                                fontSize: 16,
                                color: int.parse(set1Team1Point) <
                                        int.parse(set1Team2Point)
                                    ? Colors.green
                                    : Colors.black)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: currentSet == '2'
                        ? BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(4),
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(set2Team1Point,
                            style: TextStyle(
                                fontSize: 16,
                                color: int.parse(set2Team1Point) >
                                        int.parse(set2Team2Point)
                                    ? Colors.green
                                    : Colors.black)),
                        Text(set2Team2Point,
                            style: TextStyle(
                                fontSize: 16,
                                color: int.parse(set2Team1Point) <
                                        int.parse(set2Team2Point)
                                    ? Colors.green
                                    : Colors.black)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: currentSet == '3'
                        ? BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(4),
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(set3Team1Point,
                            style: TextStyle(
                                fontSize: 16,
                                color: int.parse(set3Team1Point) >
                                        int.parse(set3Team2Point)
                                    ? Colors.green
                                    : Colors.black)),
                        Text(set3Team2Point,
                            style: TextStyle(
                                fontSize: 16,
                                color: int.parse(set3Team1Point) <
                                        int.parse(set3Team2Point)
                                    ? Colors.green
                                    : Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.map['MatchLevel']),
                  Text(
                    widget.map['MatchTime'].toString() == 'NotAssigned'
                        ? "NotAssigned"
                        : getDateString(widget.map['MatchTime'].toString()),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  // widget.map['MatchTime'].toString() == 'NotAssigned'
                  //     ? ElevatedButton(
                  //         onPressed: () {
                  //           _selectDate(context, assignDateController);
                  //         },
                  //         child: Text('Assign Date'))
                  //     : TextButton(
                  //         onPressed: () {
                  //           _selectDate(context, assignDateController);
                  //         },
                  //         child: Text(
                  //           getDateString(
                  //               widget.map['MatchTime'].toString()),
                  //           textAlign: TextAlign.center,
                  //           textScaleFactor: 1,
                  //           style: TextStyle(
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // return Visibility(
    //   visible: true,
    //   child: new Padding(
    //       padding: const EdgeInsets.all(15.0),
    //       child: InkWell(
    //         onTap: () async {
    //           print(map);
    //         },
    //         child: Container(
    //           decoration: new BoxDecoration(
    //               border: Border(
    //                   bottom:
    //                       BorderSide(color: Colors.grey.shade300, width: 1.0))),
    //           padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               new Padding(
    //                   padding: const EdgeInsets.only(top: 5.0),
    //                   child: map['MatchTime'].toString() == 'NotAssigned'
    //                       ? ElevatedButton(
    //                           onPressed: () {
    //
    //                             _selectDate(context);
    //                           },
    //                           child: Text('Assign Date'))
    //                       : TextButton(
    //                           onPressed: () {
    //                             _selectDate(context);
    //                           },
    //                           child: Text(
    //                             getDateString(map['MatchTime'].toString()),
    //                             textAlign: TextAlign.center,
    //                             textScaleFactor: 1,
    //                             style: TextStyle(
    //                                 color: Colors.grey,
    //                                 fontWeight: FontWeight.bold),
    //                           ),
    //                         )),
    //               new Padding(
    //                   padding: const EdgeInsets.only(top: 5.0),
    //                   child: Text(
    //                     map['MatchLevel'],
    //                     textAlign: TextAlign.center,
    //                     textScaleFactor: 1,
    //                     style: TextStyle(),
    //                   )),
    //               new Padding(
    //                   padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    //                   child: Row(
    //                     children: <Widget>[
    //                       Expanded(
    //                           flex: 4,
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             children: <Widget>[
    //
    //                               new Padding(
    //                                   padding: const EdgeInsets.only(top: 0.0),
    //                                   child: Text(
    //                                     map['Team1Name'],
    //                                     textAlign: TextAlign.center,
    //                                     textScaleFactor: 1.1,
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.bold),
    //                                   )),
    //                               new Padding(
    //                                   padding: const EdgeInsets.only(top: 0.0),
    //                                   child: Text(
    //                                     map['Team1Player1'] +
    //                                         " & " +
    //                                         map['Team1Player2'],
    //                                     textAlign: TextAlign.center,
    //                                     textScaleFactor: 1.1,
    //                                     style: TextStyle(
    //                                         fontWeight: FontWeight.bold),
    //                                   )),
    //                             ],
    //                           )),
    //
    //                       Expanded(
    //                           flex: 4,
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             children: <Widget>[
    //
    //
    //                             ],
    //                           )),
    //                     ],
    //                   )),
    //             ],
    //           ),
    //         ),
    //       )),
    // );
  }

  String getDateString(String string) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
    final f = new DateFormat('dd-MM-yyyy hh-mm a');
    String startingdate = f.format(dateTime);

    return startingdate;
  }

  void _getData() {
    pointType = widget.map['PointType'];
    if (widget.map['Sets'] != null) {
      List<dynamic> setMap = widget.map['Sets'];
      int i = 0;
      setMap.forEach((value) {
        if (i == 1) {
          print(value);
          set1Team1Point = value['Team1Point'].toString();
          set1Team2Point = value['Team2Point'].toString();
        }
        if (i == 2) {
          set2Team1Point = value['Team1Point'].toString();
          set2Team2Point = value['Team2Point'].toString();
        }
        if (i == 3) {
          set3Team1Point = value['Team1Point'].toString();
          set3Team2Point = value['Team2Point'].toString();
        }
        if (i == setMap.length - 1) {
          currentSet = i.toString();
          team1Point = int.parse(value['Team1Point'].toString());
          team2Point = int.parse(value['Team2Point'].toString());
        }
        i++;

        checkIsCompleted();
        setState(() {});
      });
    }
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


  void checkIsCompleted() {
    print('check points $team1Point $team2Point');
    if (pointType == 1) {
      if (team1Point == 15 || team2Point == 15) {
        checckWinTeam();
      }
    }
    if (pointType == 2) {
      if (team1Point == 21 || team2Point == 21) {
        checckWinTeam();
      }
    }
    if (pointType == 3) {
      if (team1Point == 30 || team2Point == 30) {
        checckWinTeam();
      } else if (team1Point >= 21 || team2Point >= 21) {
        if (team1Point > team2Point + 1) {
          checckWinTeam();
        } else if (team2Point > team1Point + 1) {
          checckWinTeam();
        }
      }
    }
  }

  void confirmDelete(Function function) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Are you sure to delete this team'),
          actions: <Widget>[
            FlatButton(
              child: Text('DELETE'),
              onPressed: () {
                function();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void checckWinTeam() {
    if (currentSet == '2' || currentSet == '3') {
      int team1Win = 0, team2Win = 0;
      if (int.parse(set1Team1Point) > int.parse(set1Team2Point)) {
        team1Win++;
      } else {
        team2Win++;
      }
      if (int.parse(set2Team1Point) > int.parse(set2Team2Point)) {
        team1Win++;
      } else {
        team2Win++;
      }
      if (int.parse(set3Team1Point) > 0 || int.parse(set3Team2Point) > 0) {
        if (int.parse(set3Team1Point) > int.parse(set3Team2Point)) {
          team1Win++;
        } else {
          team2Win++;
        }
      }
      print('Wins $team1Win $team2Win');
      if (team1Win > team2Win) {
        winTeam = 'Team1';
      } else if (team2Win > team1Win) {
        winTeam = 'Team2';
      }
    }
  }

}
