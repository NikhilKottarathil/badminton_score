import 'dart:async';

import 'package:badminton_score/components/fixture_adapter.dart';
import 'package:badminton_score/matchpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();
StreamSubscription<Event> countrySubscription;
StreamSubscription<Event> shiftsSubscription;

class MatchPage2 extends StatefulWidget {
  String fixtureID, fixtureStatus;
  int pointType;

  MatchPage2({Key key, this.fixtureID, this.fixtureStatus, this.pointType})
      : super(key: key);

  @override
  _MatchPage2State createState() => _MatchPage2State();
}


class _MatchPage2State extends State<MatchPage2> {
  @override



  void didUpdateWidget(covariant MatchPage2 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('inits  Page 2 didupdate');

  }
  void initState() {

    super.initState();

    print('inits  Page 2 init');

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitUp,
    // ]);
    countrySubscription.cancel();
    shiftsSubscription.cancel();
    print('inits  Page 2 dispose');

    super.dispose();
  }

  @override
  String player00 = '', player01 = '', player10 = '', player11 = '';
  List<String> team1PlayerList = new List();
  List<String> team2PlayerList = new List();
  String currentBox = '10';
  String receiverBox = '01';
  String team1 = '', team2 = '';
  String set1Team1Point = '0', set2Team1Point = '0', set3Team1Point = '0';
  String set1Team2Point = '0', set2Team2Point = '0', set3Team2Point = '0';
  int team1Point = 0, team2Point = 0;
  String currentSet = '';
  String team1Player, team2Player;
  bool isOkToShowAlert=true;
  bool isOk = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitUp,
        ]);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .15,
                  color: Colors.grey.shade400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Set $currentSet',
                        style: TextStyle(fontSize: 24),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(team1),
                          Text(team2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(set1Team1Point),
                          Text(set1Team2Point),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(set2Team1Point),
                          Text(set2Team2Point),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(set3Team1Point),
                          Text(set3Team2Point),
                        ],
                      ),
                      Row(
                        children: [

                          IconButton(
                              icon: Icon(Icons.timer),
                              onPressed: () {
                                mRootReference
                                    .child('Fixtures')
                                    .child(widget.fixtureStatus)
                                    .child(widget.fixtureID)
                                    .child('ScreenType')
                                    .set('Timer');
                                showTimer();
                              }),
                          IconButton(
                              icon: Icon(Icons.slideshow),
                              onPressed: () {
                                mRootReference
                                    .child('Fixtures')
                                    .child(widget.fixtureStatus)
                                    .child(widget.fixtureID)
                                    .child('ScreenType')
                                    .set('Advertisement');
                                showAds();
                              }),
                          IconButton(
                              icon :Image.asset('images/two_way_arrow.png',),
                              onPressed: () {

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Court Shift?'),
                                      content: Text('Are you sure to shift the courts'),
                                      actions: <Widget>[

                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                              onPrimary: Colors.white
                                          ),
                                          child: Text('SHIFT',style: TextStyle(fontSize: 18),),
                                          onPressed: () {
                                            Map<String, dynamic> data = new Map();
                                            data['00'] = player11;
                                            data['01'] = player10;
                                            data['10'] = player01;
                                            data['11'] = player00;
                                            if(currentBox=='00') {
                                              data['CurrentBox'] = '11';
                                            }else if(currentBox=='01'){
                                              data['CurrentBox'] = '10';
                                            }else if(currentBox=='10'){
                                              data['CurrentBox'] = '01';
                                            }else if(currentBox=='11'){
                                              data['CurrentBox'] = '00';
                                            }
                                            data['Team1Player'] = team1Player;
                                            data['Team2Player'] = team2Player;
                                            data['ScoredBy']='CourtShift';
                                            mRootReference
                                                .child("Fixtures")
                                                .child(widget.fixtureStatus)
                                                .child(widget.fixtureID)
                                                .child('Sets')
                                                .child(currentSet)
                                                .child('Shifts')
                                                .push()
                                                .set(data);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );


                              }),
                        ],
                      ),

                      ElevatedButton(
                          onPressed: () {
                            mRootReference
                                .child('Fixtures')
                                .child(widget.fixtureStatus)
                                .child(widget.fixtureID)
                                .child('Sets')
                                .child(currentSet)
                                .child('Shifts')
                                .limitToLast(1)
                                .once()
                                .then((snapshot) {
                              Map map = snapshot.value;
                              var snapShotKeyToDel =
                                  map.keys.toList()[0].toString();
                              var mapData = map.values.toList()[0];
                              print(snapShotKeyToDel);
                              if (mapData['ScoredBy'] != 'Start') {


                                print('undo teamplayer list  $team1PlayerList ');
                                print(mapData['ScoredBy']);
                                if(mapData['ScoredBy']!='CourtShift') {
                                  if (team1PlayerList
                                      .contains(mapData['ScoredBy'])) {
                                    mRootReference
                                        .child("Fixtures")
                                        .child(widget.fixtureStatus)
                                        .child(widget.fixtureID)
                                        .child('Sets')
                                        .child(currentSet)
                                        .child('Team1Point')
                                        .set(team1Point - 1);
                                  } else {
                                    mRootReference
                                        .child("Fixtures")
                                        .child(widget.fixtureStatus)
                                        .child(widget.fixtureID)
                                        .child('Sets')
                                        .child(currentSet)
                                        .child('Team2Point')
                                        .set(team2Point - 1);
                                  }
                                }
                                mRootReference
                                    .child('Fixtures')
                                    .child(widget.fixtureStatus)
                                    .child(widget.fixtureID)
                                    .child('Sets')
                                    .child(currentSet)
                                    .child('Shifts')
                                    .child(snapShotKeyToDel)
                                    .remove();
                              } else {
                                showdia('cant undo');
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // background
                            onPrimary: Colors.black, // foreground
                          ),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Text("Undo", textAlign: TextAlign.center)))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .84,
                    color: Colors.grey.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (isOk) {
                                Map<String, dynamic> data = new Map();
                                if (currentBox == '01' || currentBox == '00') {
                                  print('click 1 left $player00 $player01'
                                      '');
                                  data['00'] = player01;
                                  data['01'] = player00;
                                  data['Team2Player'] = team2Player;
                                  if (team1Player == '00') {
                                    data['Team1Player'] = '01';
                                  } else {
                                    data['Team1Player'] = '00';
                                  }
                                  if (currentBox == '00') {
                                    data['CurrentBox'] = '01';
                                  } else {
                                    data['CurrentBox'] = '00';
                                  }

                                  data['10'] = player10;
                                  data['11'] = player11;
                                } else {
                                  print('click 2 left');

                                  data['00'] = player00;
                                  data['01'] = player01;

                                  if (team1Player == '00') {
                                    data['Team1Player'] = '01';
                                  } else {
                                    data['Team1Player'] = '00';
                                  }
                                  data['Team2Player'] = team2Player;

                                  data['CurrentBox'] = team1Player;

                                  data['10'] = player10;
                                  data['11'] = player11;
                                }
                                data['ScoredBy'] = player00;

                                setState(() {});
                                if (team1PlayerList.contains(player00)) {
                                  mRootReference
                                      .child("Fixtures")
                                      .child(widget.fixtureStatus)
                                      .child(widget.fixtureID)
                                      .child('Sets')
                                      .child(currentSet)
                                      .child('Team1Point')
                                      .set(team1Point + 1);
                                } else {
                                  mRootReference
                                      .child("Fixtures")
                                      .child(widget.fixtureStatus)
                                      .child(widget.fixtureID)
                                      .child('Sets')
                                      .child(currentSet)
                                      .child('Team2Point')
                                      .set(team2Point + 1);
                                }
                                mRootReference
                                    .child("Fixtures")
                                    .child(widget.fixtureStatus)
                                    .child(widget.fixtureID)
                                    .child('Sets')
                                    .child(currentSet)
                                    .child('Shifts')
                                    .push()
                                    .update(data);


                                isOk = false;
                              }
                            },
                            child: Container(
                              width: 30,
                              height: MediaQuery.of(context).size.height * .75,
                              child: Center(
                                  child: Text(
                                '+1',
                                style: TextStyle(fontSize: 24),
                              )),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * .35,
                              height: MediaQuery.of(context).size.height * .4,
                              child: Container(
                                color: currentBox == '00'
                                    ? Colors.grey
                                    : receiverBox == '00'
                                        ? Colors.grey.shade300
                                        : Colors.white,
                                child: Center(child: Text(player00)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * .35,
                              height: MediaQuery.of(context).size.height * .4,
                              child: Container(
                                  color: currentBox == '01'
                                      ? Colors.grey
                                      : receiverBox == '01'
                                          ? Colors.grey.shade300
                                          : Colors.white,
                                  child: Center(
                                    child: Text(player01),
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * .35,
                              height: MediaQuery.of(context).size.height * .4,
                              child: Container(
                                  color: currentBox == '10'
                                      ? Colors.grey
                                      : receiverBox == '10'
                                          ? Colors.grey.shade300
                                          : Colors.white,
                                  child: Center(
                                    child: Text(player10),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width * .35,
                              height: MediaQuery.of(context).size.height * .4,
                              child: Container(
                                  color: currentBox == '11'
                                      ? Colors.grey
                                      : receiverBox == '11'
                                          ? Colors.grey.shade300
                                          : Colors.white,
                                  child: Center(
                                    child: Text(player11),
                                  )),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (isOk) {
                                Map<String, dynamic> data = new Map();
                                if (currentBox == '10' || currentBox == '11') {
                                  print('click 1 right');

                                  data['10'] = player11;
                                  data['11'] = player10;
                                  if (team2Player == '10') {
                                    data['Team2Player'] = '11';
                                  } else {
                                    data['Team2Player'] = '10';
                                  }
                                  data['Team1Player'] = team1Player;
                                  if (currentBox == '10') {
                                    data['CurrentBox'] = '11';
                                  } else {
                                    data['CurrentBox'] = '10';
                                  }

                                  data['00'] = player00;
                                  data['01'] = player01;
                                } else {
                                  print('click 3 right');

                                  data['10'] = player10;
                                  data['11'] = player11;

                                  if (team2Player == '10') {
                                    data['Team2Player'] = '11';
                                  } else {
                                    data['Team2Player'] = '10';
                                  }
                                  data['Team1Player'] = team1Player;
                                  data['CurrentBox'] = team2Player;

                                  data['00'] = player00;
                                  data['01'] = player01;
                                }
                                data['ScoredBy'] =player11;

                                setState(() {});
                                print('team1PlayerList $team1PlayerList $player11');
                                if (team1PlayerList.contains(player11)) {
                                  mRootReference
                                      .child("Fixtures")
                                      .child(widget.fixtureStatus)
                                      .child(widget.fixtureID)
                                      .child('Sets')
                                      .child(currentSet)
                                      .child('Team1Point')
                                      .set(team1Point + 1);
                                } else {
                                  mRootReference
                                      .child("Fixtures")
                                      .child(widget.fixtureStatus)
                                      .child(widget.fixtureID)
                                      .child('Sets')
                                      .child(currentSet)
                                      .child('Team2Point')
                                      .set(team2Point + 1);
                                }
                                mRootReference
                                    .child("Fixtures")
                                    .child(widget.fixtureStatus)
                                    .child(widget.fixtureID)
                                    .child('Sets')
                                    .child(currentSet)
                                    .child('Shifts')
                                    .push()
                                    .update(data);

                                isOk = false;
                              }
                            },
                            child: Container(
                              width: 30,
                              height: MediaQuery.of(context).size.height * .75,
                              child: Center(
                                  child: Text(
                                '+1',
                                style: TextStyle(fontSize: 24),
                              )),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getData() async {
    await mRootReference
        .child('Fixtures')
        .child(widget.fixtureStatus)
        .child(widget.fixtureID)
        .once()
        .then((value) {
      Map<dynamic, dynamic> map = value.value;

      print(map);
      team1 = map['Team1Player1'] + " & " + map['Team1Player2'];
      team2 = map['Team2Player1'] + " & " + map['Team2Player2'];

      team1PlayerList.add(map['Team1Player1']);
      team1PlayerList.add(map['Team1Player2']);
      team2PlayerList.add(map['Team2Player2']);
      team2PlayerList.add(map['Team2Player1']);
      var setMap1 = map['Sets'];
      print('setmap $setMap1');
      List<dynamic> setMap = map['Sets'];
      print(setMap.length);
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
          team1Point = value['Team1Point'];
          team2Point = value['Team2Point'];
        }
        i++;
        setState(() {});
      });
      // setMap.forEach((key, value) {
      //
      // });
    });
    countrySubscription = await mRootReference
        .child('Fixtures')
        .child(widget.fixtureStatus)
        .child(widget.fixtureID)
        .child('Sets')
        .child(currentSet)
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic> map = event.snapshot.value;
      // player00 = map['00'];
      // player01 = map['01'];
      // player10 = map['10'];
      // player11 = map['11'];

      if (currentSet == '1') {
        set1Team1Point = map['Team1Point'].toString();
        set1Team2Point = map['Team2Point'].toString();
        team1Point = map['Team1Point'];
        team2Point = map['Team2Point'];
      }
      if (currentSet == '2') {
        set2Team1Point = map['Team1Point'].toString();
        set2Team2Point = map['Team2Point'].toString();
        team1Point = map['Team1Point'];
        team2Point = map['Team2Point'];
      }
      if (currentSet == '3') {
        set3Team1Point = map['Team1Point'].toString();
        set3Team2Point = map['Team2Point'].toString();
        team1Point = map['Team1Point'];
        team2Point = map['Team2Point'];
      }
      print('check points 0 $team1Point $team2Point');

      checkIsCompleted();

      setState(() {});
    });

    shiftsSubscription=await mRootReference
        .child('Fixtures')
        .child(widget.fixtureStatus)
        .child(widget.fixtureID)
        .child('Sets')
        .child(currentSet)
        .child('Shifts')
        .limitToLast(1)
        .onValue
        .listen((event) {
      if (event.snapshot != null) {
        Map<dynamic, dynamic> map =
            Map<dynamic, dynamic>.from(event.snapshot.value);
        print('ttt $map');
        // map.forEach((element) {
        //   print('dtttttt $element');
        // });
        map.forEach((key, value) {
          print(value);
          player00 = value['00'];
          player01 = value['01'];
          player10 = value['10'];
          player11 = value['11'];
          team1Player = value['Team1Player'];
          team2Player = value['Team2Player'];
          currentBox = value['CurrentBox'];
          if(currentBox=='00'){
            receiverBox='11';
          }if(currentBox=='01'){
            receiverBox='10';
          }if(currentBox=='10'){
            receiverBox='01';
          }if(currentBox=='11'){
            receiverBox='00';
          }
        });

        String currentPlayer='10';
        
        if(currentBox=='00'){
          currentPlayer=player00;
        }else if(currentBox=='01'){
          currentPlayer=player01;
        }else if(currentBox=='10'){
          currentPlayer=player10;
        }else if(currentBox=='11'){
          currentPlayer=player11;
        }
        Map<String,dynamic> mapUpdate=new Map();
        if(team1PlayerList.contains(player00)){
          mapUpdate['LeftSide']='Team1';
        }else{
          mapUpdate['LeftSide']='Team2';
        }
        if(team1PlayerList.contains(currentPlayer)){
         mapUpdate['ServingTeam']='Team1';
        }else{
          mapUpdate['ServingTeam']='Team2';
        }
        mRootReference.child('Fixtures').child(widget.fixtureStatus).child(widget.fixtureID).update(mapUpdate);

        // player00 = map['00'];
        // player01 = map['01'];
        // player10 = map['10'];
        // player11 = map['11'];
        // team1Player=map['Team1Player'];
        // team2Player=map['Team2Player'];
        // currentBox=map['CurrentBox'];

        // print('team2 playe $team2Player');
        setState(() {});
      }
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
  void showTimer() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Timer'),
          content: Text('The timer is running in screen'),
          actions: <Widget>[

            ElevatedButton(
              child: Text('Start Advertisement'),
              onPressed: () {
                mRootReference
                    .child('Fixtures')
                    .child(widget.fixtureStatus)
                    .child(widget.fixtureID)
                    .child('ScreenType')
                    .set('Advertisement');
                Navigator.of(context).pop();
                showAds();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white
              ),
              child: Text('Stop',style: TextStyle(fontSize: 18),),
              onPressed: () {
                mRootReference
                    .child('Fixtures')
                    .child(widget.fixtureStatus)
                    .child(widget.fixtureID)
                    .child('ScreenType')
                    .set('Score');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showAds() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Advertisement'),
          content: Text('The Advertisement is running in screen'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Start Timer'),
              onPressed: () {
                mRootReference
                    .child('Fixtures')
                    .child(widget.fixtureStatus)
                    .child(widget.fixtureID)
                    .child('ScreenType')
                    .set('Timer');
                Navigator.of(context).pop();
                showTimer();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white
              ),
              child: Text('Stop',style: TextStyle(fontSize: 18),),
              onPressed: () {
                mRootReference
                    .child('Fixtures')
                    .child(widget.fixtureStatus)
                    .child(widget.fixtureID)
                    .child('ScreenType')
                    .set('Score');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkIsCompleted() {
    isOk = true;

    print('check points $team1Point $team2Point');
    if (widget.pointType == 1) {
      if (team1Point == 15 || team2Point == 15) {
        checckWinTeam();
      }
    }
    if (widget.pointType == 2) {
      if (team1Point == 21 || team2Point == 21) {
        checckWinTeam();
      }
    }
    if (widget.pointType == 3) {
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

  void checckWinTeam() {
    isOk = false;

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
        if(isOkToShowAlert) {
          showAlert('Team1');
          isOkToShowAlert=false;
        }
      } else if (team2Win > team1Win) {
        if(isOkToShowAlert) {
          showAlert('Team2');
          isOkToShowAlert=false;
        }
      } else {
        if(isOkToShowAlert) {
          showAlert('');
          isOkToShowAlert=false;

        }
      }
    } else {
      if(isOkToShowAlert) {
        showAlert('');
        isOkToShowAlert=false;
      }
    }
  }

  void showAlert(String winTeam) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: Text(
              'This Game is Completed',
              textAlign: TextAlign.center,
            ),
            content: Container(
                width: MediaQuery.of(context).size.width * .5,
                height: MediaQuery.of(context).size.height * .7,
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new SizedBox(
                          width: MediaQuery.of(context).size.width*.3,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Text(
                                    team1,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.1,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  winTeam == 'Team1'
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Image.asset(
                                            'images/trophy.png',
                                            width: 35,
                                          ))
                                      : Container(),
                                ],
                              ),
                            )),
                        new Container(
                            height: 25,
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset('images/vs.png')),
                        new SizedBox(
                          width: MediaQuery.of(context).size.width*.3,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Text(
                                    team2,
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.1,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  winTeam == 'Team2'
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Image.asset(
                                            'images/trophy.png',
                                            width: 35,
                                          ))
                                      : Container(),
                                ],
                              ),
                            )),
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
                )
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Text(
                //           team1,
                //           style: TextStyle(fontSize: 18),
                //         ),
                //         Text(
                //           team2,
                //           style: TextStyle(fontSize: 18),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Text(
                //           team1Point.toString(),
                //           style: TextStyle(
                //               color:
                //                   message == 'Team1' ? Colors.green : Colors.black,
                //               fontSize: 24),
                //         ),
                //         Text(team2Point.toString(),
                //             style: TextStyle(
                //                 color: message == 'Team2'
                //                     ? Colors.green
                //                     : Colors.black,
                //                 fontSize: 24)),
                //       ],
                //     ),
                //   ],
                // ),
                ),
            actions: <Widget>[

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                  onPressed: (){
                Navigator.of(context).pop();
                isOkToShowAlert=true;

              },  child: Text('Dismiss')),
              winTeam != ''
                  ? ElevatedButton(
                      onPressed: () {
                        mRootReference
                            .child('Fixtures')
                            .child(widget.fixtureStatus)
                            .child(widget.fixtureID)
                            .once()
                            .then((snapShot) {
                          var map = Map<String, dynamic>.from(snapShot.value);
                          map['Status'] = 'Results';
                          mRootReference
                              .child('Fixtures')
                              .child('Live')
                              .child(widget.fixtureID)
                              .child('GameStatus').set('Finished');


                          mRootReference
                              .child('Fixtures')
                              .child('Results')
                              .child(map['FixtureID'])
                              .update(map);

                          isOkToShowAlert=true;
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitUp,
                          ]);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text('\t \t Finish \t \t'))
                  : currentSet == '1'
                      ? ElevatedButton(
                          onPressed: () {
                            mRootReference
                                .child('Fixtures')
                                .child(widget.fixtureStatus)
                                .child(widget.fixtureID)
                                .child('Sets')
                                .child('1')
                                .once()
                                .then((snapShot) {
                              Map<dynamic, dynamic> map = snapShot.value;
                              Map<String, dynamic> data = new Map();

                              data['00'] = map['11'];
                              data['01'] = map['10'];
                              data['10'] = map['01'];
                              data['11'] = map['00'];
                              data['Team1Point'] = 0;
                              data['Team2Point'] = 0;
                              data['CurrentBox'] = map['CurrentBox'];

                              mRootReference
                                  .child("Fixtures")
                                  .child(widget.fixtureStatus)
                                  .child(widget.fixtureID)
                                  .child('Sets')
                                  .child('2')
                                  .update(data);
                              isOkToShowAlert=true;
                              Navigator.of(context).pop();


                              dispose();
                              Navigator.pushReplacement(

                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchPage(
                                            fixtureID: widget.fixtureID,
                                            fixtureStatus: widget.fixtureStatus,
                                            pointType: widget.pointType,
                                            currentSet: '2',
                                          )));
                            });
                          },
                          child: Text("\t \tStart Game 2 \t \t"))
                      : ElevatedButton(
                          onPressed: () {
                            mRootReference
                                .child('Fixtures')
                                .child(widget.fixtureStatus)
                                .child(widget.fixtureID)
                                .child('Sets')
                                .child('2')
                                .once()
                                .then((snapShot) {
                              Map<dynamic, dynamic> map = snapShot.value;
                              Map<String, dynamic> data = new Map();

                              data['00'] = map['11'];
                              data['01'] = map['10'];
                              data['10'] = map['01'];
                              data['11'] = map['00'];
                              data['Team1Point'] = 0;
                              data['Team2Point'] = 0;
                              data['CurrentBox'] = map['CurrentBox'];

                              mRootReference
                                  .child("Fixtures")
                                  .child(widget.fixtureStatus)
                                  .child(widget.fixtureID)
                                  .child('Sets')
                                  .child('3')
                                  .update(data);


                              isOkToShowAlert=true;
                              Navigator.of(context).pop();
                              dispose();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchPage(
                                            fixtureID: widget.fixtureID,
                                            fixtureStatus: widget.fixtureStatus,
                                            pointType: widget.pointType,
                                            currentSet: '3',
                                          )));
                            });
                          },
                          child: Text("\t \t Start Game 3 \t \t")),
            ],
          ),
        );
      },
    );
  }

}

// onWillPop: ()async {
// SystemChrome.setPreferredOrientations([
// DeviceOrientation.portraitDown,
// DeviceOrientation.portraitUp,
// ]);
// // Navigator.of(context).pop();
// return true;
// },
