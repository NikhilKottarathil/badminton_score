import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'match_page_2.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

StreamSubscription<Event> countrySubscription;

class MatchPage extends StatefulWidget {
  String fixtureID, fixtureStatus, currentSet;
  int pointType;

  MatchPage(
      {Key key,
      this.fixtureID,
      this.fixtureStatus,
      this.pointType,
      this.currentSet})
      : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    print('inits  Page 1 init');
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _getData();
  }

  String player00 = '', player01 = '', player10 = '', player11 = '';
  String currentBox = '';
  int leftSide = 1, rightSide = 0, radioValue = 0;


  @override
  void dispose()  {
    // TODO: implement dispose
    countrySubscription.cancel();


    print('inits  Page 1 dispose');


    super.dispose();

  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    print('inits  Page 1 deactive');

    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: () async{
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitUp,
        ]);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.height * .375,
                          child: Container(
                            color:
                                currentBox == '00' ? Colors.grey : Colors.white,
                            child: Center(child: Text(player00)),
                          ),
                        ),
                        IconButton(
                            icon: Image.asset('images/two_way_arrow_up.png'),
                            onPressed: () {
                              Map<String, dynamic> data = new Map();
                              data['00'] = player01;
                              data['01'] = player00;
                              data['CurrentBox'] = currentBox;

                              mRootReference
                                  .child("Fixtures")
                                  .child(widget.fixtureStatus)
                                  .child(widget.fixtureID)
                                  .child('Sets')
                                  .child(widget.currentSet)
                                  .update(data);
                            }),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.height * .375,
                          child: Container(
                              color:
                                  currentBox == '01' ? Colors.grey : Colors.white,
                              child: Center(
                                child: Text(player01),
                              )),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Image.asset('images/two_way_arrow.png'),
                        onPressed: () {
                          Map<String, dynamic> data = new Map();
                          data['00'] = player10;
                          data['01'] = player11;
                          data['10'] = player00;
                          data['11'] = player01;
                          data['CurrentBox'] = currentBox;
                          mRootReference
                              .child("Fixtures")
                              .child(widget.fixtureStatus)
                              .child(widget.fixtureID)
                              .child('Sets')
                              .child(widget.currentSet)
                              .update(data);
                        }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.height * .375,
                          child: Container(
                              color:
                                  currentBox == '10' ? Colors.grey : Colors.white,
                              child: Center(
                                child: Text(player10),
                              )),
                        ),
                        IconButton(
                            icon: Image.asset('images/two_way_arrow_up.png'),
                            onPressed: () {
                              Map<String, dynamic> data = new Map();
                              data['10'] = player11;
                              data['11'] = player10;
                              data['CurrentBox'] = currentBox;

                              mRootReference
                                  .child("Fixtures")
                                  .child(widget.fixtureStatus)
                                  .child(widget.fixtureID)
                                  .child('Sets')
                                  .child(widget.currentSet)
                                  .update(data);
                            }),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.height * .375,
                          child: Container(
                              color:
                                  currentBox == '11' ? Colors.grey : Colors.white,
                              child: Center(
                                child: Text(player11),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.pointType == 1
                        ? Text('3 games of  15 Point',
                            textAlign: TextAlign.center)
                        : widget.pointType == 2
                            ? Text('3 games of  21 Point',
                                textAlign: TextAlign.center)
                            : Text('3 games of  30 Point',
                                textAlign: TextAlign.center),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Serving Side',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: rightSide,
                              groupValue: radioValue,
                              onChanged: (int i) {
                                radioValue = rightSide;
                                setState(() {
                                  currentBox = '10';
                                  print('right $i');
                                });
                              },
                            ),
                            Text('Right Side')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: leftSide,
                              groupValue: radioValue,
                              onChanged: (int i) {
                                setState(() {
                                  currentBox = '01';
                                  radioValue = leftSide;
                                  print('left $i');
                                });
                              },
                            ),
                            Text('Left Side')
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> data = new Map();
                          if (currentBox == '01') {
                            data['CurrentBox'] = '01';
                            data['StartedBy'] = player01;
                          } else {
                            data['CurrentBox'] = '10';
                            data['StartedBy'] = player10;
                          }
                          data['StartedTime'] =
                              DateTime.now().millisecondsSinceEpoch;
                          mRootReference
                              .child("Fixtures")
                              .child(widget.fixtureStatus)
                              .child(widget.fixtureID)
                              .child('Sets')
                              .child(widget.currentSet)
                              .update(data);

                          Map<String, dynamic> data1 = new Map();
                          data1['00'] = player00;
                          data1['01'] = player01;
                          data1['10'] = player10;
                          data1['11'] = player11;
                          if (currentBox == '01') {
                            data1['CurrentBox'] = '01';
                            data1['Team1Player'] = '00';
                            data1['Team2Player'] = '11';
                          } else {
                            data1['CurrentBox'] = '10';
                            data1['Team1Player'] = '00';
                            data1['Team2Player'] = '11';
                          }
                          data1['ScoredBy'] = 'Start';
                          mRootReference
                              .child("Fixtures")
                              .child(widget.fixtureStatus)
                              .child(widget.fixtureID)
                              .child('Sets')
                              .child(widget.currentSet)
                              .child('Shifts')
                              .push()
                              .set(data1);


                          dispose();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(

                                  builder: (context) => MatchPage2(
                                        fixtureID: widget.fixtureID,
                                        fixtureStatus: widget.fixtureStatus,
                                        pointType: widget.pointType,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // background
                          onPrimary: Colors.black, // foreground
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width * .17,
                            child:
                                Text("Start Match", textAlign: TextAlign.center)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getData() {
    countrySubscription = mRootReference
        .child('Fixtures')
        .child(widget.fixtureStatus)
        .child(widget.fixtureID)
        .child('Sets')
        .child(widget.currentSet)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic> map = event.snapshot.value;
      player00 = map['00'];
      player01 = map['01'];
      player10 = map['10'];
      player11 = map['11'];
      currentBox = map['CurrentBox'];
      setState(() {});
    });
  }
}
