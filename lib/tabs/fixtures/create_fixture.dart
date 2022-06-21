import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateFixture extends StatefulWidget {
  String tournamentID, tournamentStatus;

  CreateFixture({Key key, this.tournamentID, this.tournamentStatus})
      : super(key: key);

  @override
  _CreateFixtureState createState() => _CreateFixtureState();
}

final _formKey = GlobalKey<FormState>();

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class _CreateFixtureState extends State<CreateFixture> {
  bool isNotGenerated = true;
  List<Map<dynamic, dynamic>> teams = new List();
  List<String> teamIDs = new List();

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();
  TextEditingController textEditingController6 = TextEditingController();
  TextEditingController textEditingController7 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 25, bottom: 15, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Enter the round name from Final to Starting level',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Final',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController1,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Round 2',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController2,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Round 3',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController3,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Round 4',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController4,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Round 5',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController5,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Round 6',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController6,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: teamnamevalid == true
                    //         ? Colors.grey
                    //         : Colors.red,
                    //     blurRadius: 4.0,
                    //   ),
                    // ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(5.0)),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'First Round',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: textEditingController7,
                    validator: (value) {
                      // if (value.isEmpty) {
                      //   setState(() {
                      //     teamnamevalid = false;
                      //     isempty = true;
                      //   });
                      //   return null;
                      // } else {
                      //   setState(() {
                      //     teamnamevalid = true;
                      //   });
                      // }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: ElevatedButton(
          child: Container(
              width: double.infinity,
              height: 60,
              child: Center(
                  child: Text(
                "SAVE",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ))),
          onPressed: () {
            String currentRound;
            Map<String, dynamic> data = new Map();

            bool isEmpty = true;
            if (textEditingController7.text.isNotEmpty) {
              data['7'] = textEditingController7.text;
              currentRound = '7';
              if (textEditingController6.text.isNotEmpty) {
                data['6'] = textEditingController6.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController5.text.isNotEmpty) {
                data['5'] = textEditingController5.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController4.text.isNotEmpty) {
                data['4'] = textEditingController4.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController3.text.isNotEmpty) {
                data['3'] = textEditingController3.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController2.text.isNotEmpty) {
                data['2'] = textEditingController2.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController1.text.isNotEmpty) {
                data['1'] = textEditingController1.text;
              } else {
                isEmpty = false;
              }
            } else if (textEditingController6.text.isNotEmpty) {
              currentRound = '6';
              data['6'] = textEditingController6.text;
              if (textEditingController5.text.isNotEmpty) {
                data['5'] = textEditingController5.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController4.text.isNotEmpty) {
                data['4'] = textEditingController4.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController3.text.isNotEmpty) {
                data['3'] = textEditingController3.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController2.text.isNotEmpty) {
                data['2'] = textEditingController2.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController1.text.isNotEmpty) {
                data['1'] = textEditingController1.text;
              } else {
                isEmpty = false;
              }
            } else if (textEditingController5.text.isNotEmpty) {
              currentRound = '5';

              data['5'] = textEditingController5.text;

              if (textEditingController4.text.isNotEmpty) {
                data['4'] = textEditingController4.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController3.text.isNotEmpty) {
                data['3'] = textEditingController3.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController2.text.isNotEmpty) {
                data['2'] = textEditingController2.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController1.text.isNotEmpty) {
                data['1'] = textEditingController1.text;
              } else {
                isEmpty = false;
              }
            } else if (textEditingController4.text.isNotEmpty) {
              currentRound = '4';

              data['4'] = textEditingController4.text;

              if (textEditingController3.text.isNotEmpty) {
                data['3'] = textEditingController3.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController2.text.isNotEmpty) {
                data['2'] = textEditingController2.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController1.text.isNotEmpty) {
                data['1'] = textEditingController1.text;
              } else {
                isEmpty = false;
              }
            } else if (textEditingController3.text.isNotEmpty) {
              currentRound = '3';

              data['3'] = textEditingController3.text;
              if (textEditingController2.text.isNotEmpty) {
                data['2'] = textEditingController2.text;
              } else {
                isEmpty = false;
              }
              if (textEditingController1.text.isNotEmpty) {
                data['1'] = textEditingController1.text;
              } else {
                isEmpty = false;
              }
            } else if (textEditingController2.text.isNotEmpty) {
              currentRound = '2';

              data['2'] = textEditingController2.text;
              if (textEditingController1.text.isNotEmpty) {
                data['1'] = textEditingController1.text;
              } else {
                isEmpty = false;
              }
            } else if (textEditingController1.text.isNotEmpty) {
              currentRound = '1';
              data['1'] = textEditingController1.text;
            }else{
              isEmpty=false;
            }

            data['0'] = 'Winner';

            if(isEmpty) {
              mRootReference
                  .child('Tournaments')
                  .child(widget.tournamentStatus)
                  .child(widget.tournamentID)
                  .child("Levels")
                  .update(data);
              mRootReference
                  .child('Tournaments')
                  .child(widget.tournamentStatus)
                  .child(widget.tournamentID)
                  .child("TeamsInLevels")
                  .update(data);
              mRootReference
                  .child('Tournaments')
                  .child(widget.tournamentStatus)
                  .child(widget.tournamentID)
                  .child("Fixture")
                  .update(data);
              mRootReference
                  .child('Tournaments')
                  .child(widget.tournamentStatus)
                  .child(widget.tournamentID).child('CurrentLevel').set(currentRound);
              mRootReference
                  .child('Tournaments')
                  .child(widget.tournamentStatus)
                  .child(widget.tournamentID).child('Teams').once().then((snapshot) {
                    var vv=snapshot.value;
                    print("vvvvvvvvvv $vv");
                mRootReference
                    .child('Tournaments')
                    .child(widget.tournamentStatus)
                    .child(widget.tournamentID)
                    .child("TeamsInLevels")
                    .child(currentRound).set(snapshot.value);
                Navigator.of(context).pop();

              }
              );

            }else{
              showdia('fill the round names');
            }

          },
        ),
      ),
    );
  }
 va

}
