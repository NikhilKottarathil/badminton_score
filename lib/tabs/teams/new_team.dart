import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class NewTeam extends StatefulWidget {
  String tournamentID, status, teamIDExisting;

  NewTeam({this.tournamentID, this.status, this.teamIDExisting});

  @override
  NewTeamState createState() => new NewTeamState();
}

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class NewTeamState extends State<NewTeam> {
  bool isempty = false,
      teamplacevalid = true,
      player1NameValid = true,
      player1PhoneValid = true,
      player2NameValid = true,
      player2PhoneValid = true;

  TextEditingController teamplacecontroller = TextEditingController();

  TextEditingController player1Name = TextEditingController();
  TextEditingController player1Phone = TextEditingController();
  TextEditingController player2Name = TextEditingController();
  TextEditingController player2Phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.teamIDExisting != null) {
      getData();
      print("existing team");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.grey.shade50,
        title: Text("New Team"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height * .80,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .1),
          child: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: teamplacevalid == true
                                      ? Colors.grey
                                      : Colors.red,
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextFormField(
                              decoration: new InputDecoration(
                                hintText: 'Place',
                                contentPadding: const EdgeInsets.all(20.0),
                                fillColor: Colors.white,
                                focusedBorder: InputBorder.none,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              controller: teamplacecontroller,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    teamplacevalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    teamplacevalid = true;
                                  });
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: player1NameValid == true
                                      ? Colors.grey
                                      : Colors.red,
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextFormField(
                              decoration: new InputDecoration(
                                hintText: 'Player 1 Name',
                                contentPadding: const EdgeInsets.all(20.0),
                                fillColor: Colors.white,
                                focusedBorder: InputBorder.none,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              controller: player1Name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    player1NameValid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    player1NameValid = true;
                                  });
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: player1PhoneValid == true
                                      ? Colors.grey
                                      : Colors.red,
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextFormField(
                              maxLength: 10,
                              decoration: new InputDecoration(
                                hintText: 'Player 1 Phone Number',
                                contentPadding: const EdgeInsets.all(20.0),
                                fillColor: Colors.white,
                                focusedBorder: InputBorder.none,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              controller: player1Phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    player1PhoneValid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    player1PhoneValid = true;
                                  });
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: player2NameValid == true
                                      ? Colors.grey
                                      : Colors.red,
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextFormField(
                              decoration: new InputDecoration(
                                hintText: 'Player 2 Name',
                                contentPadding: const EdgeInsets.all(20.0),
                                fillColor: Colors.white,
                                focusedBorder: InputBorder.none,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              controller: player2Name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    player2NameValid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    player2NameValid = true;
                                  });
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: player2PhoneValid == true
                                      ? Colors.grey
                                      : Colors.red,
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TextFormField(
                              maxLength: 10,
                              decoration: new InputDecoration(
                                hintText: 'Player 2 Phone Number',
                                contentPadding: const EdgeInsets.all(20.0),
                                fillColor: Colors.white,

                                focusedBorder: InputBorder.none,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              controller: player2Phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    player2PhoneValid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    player2PhoneValid = true;
                                  });
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
      bottomSheet: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 60.0,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        validateForm();
                      }
                    },
                    child: new Text(
                      "Create Team",
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Dialog(
            child: Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
          );
        });

    if (isempty == false) {
      var teamPlace = teamplacecontroller.text;
      var player1NameString = player1Name.text;
      var player1PhoneString = player1Phone.text;
      var player2NameString = player2Name.text;
      var player2PhoneString = player2Phone.text;

      Map<String, dynamic> data = new Map();

      String teamID = mRootReference.push().key;

      data['TeamPlace'] = teamPlace;
      data['Player1Name'] = player1NameString;
      data['Player1Phone'] = player1PhoneString;
      data['Player2Name'] = player2NameString;
      data['Player2Phone'] = player2PhoneString;
      if (widget.teamIDExisting == null) {
        data['CreatedTime'] = DateTime.now().millisecondsSinceEpoch;
      } else {
        teamID = widget.teamIDExisting;
      }
      data['ID'] = teamID;

      mRootReference.child("Teams").child(teamID).set(data);
      if (widget.tournamentID != null) {
        mRootReference
            .child("Tournaments")
            .child(widget.status)
            .child(widget.tournamentID)
            .child("Teams")
            .child(teamID)
            .set(teamID);
        Navigator.of(context).pop();
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      isempty = false;
      Navigator.of(context).pop();

      showdia("Please fill name and place of your team");
    }

    // No-Internet Case
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

  void getData() {
    mRootReference
        .child("Teams")
        .child(widget.teamIDExisting)
        .once()
        .then((snapShot) {
      Map<dynamic, dynamic> data = snapShot.value;
      if (snapShot.value != null) {
        // data['LogoUrl'] = logoUrl;
        teamplacecontroller.text = data['TeamPlace'];
        // data['ID'];
        player1Name.text = data['Player1Name'];
        player1Phone.text = data['Player1Phone'];
        player2Name.text = data['Player2Name'];
        player2Phone.text = data['Player2Phone'];
        setState(() {});
      }
      // data['CreatedTime']
    }).onError((error, stackTrace) => null);
  }
}
