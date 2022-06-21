import 'dart:io';
import 'package:badminton_score/home_page.dart';
import 'package:badminton_score/tabs/tournaments/tournament_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';


DatabaseReference mRootReference=FirebaseDatabase.instance.reference();
class AddTournament extends StatefulWidget {
  String tournamentIDExisting;
  AddTournament({this.tournamentIDExisting});
  @override
  AddTournamentState createState() => new AddTournamentState();
}

class AddTournamentState extends State<AddTournament> {
  bool tournamentNameValid = true,
      isEmpty = false,
      tournamentPlaceValid = true,
      numberOfTeamsValid = true,
      tournamentGradeValid = true,
      numberOfGroupsValid = true,
      startingDateValid = true,
      finalDateValid = true;
  File logo;
  String  grade;
  DateTime startingDateController;
  DateTime finalDateController;

  String startingDate, finalDate;

  TextEditingController tournamentNameController = TextEditingController();
  TextEditingController numberOfTeamsController = TextEditingController();
  TextEditingController tournamentPlaceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<GradeLevel> gradeLevel = GradeLevel.getCompanies();
  List<DropdownMenuItem<GradeLevel>> _dropdownMenuItems;
  GradeLevel _selectedGradeLevel;



  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(gradeLevel);
    _selectedGradeLevel = _dropdownMenuItems[0].value;
    grade = _selectedGradeLevel.name;


    setstates();
    super.initState();
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child:
                            new Text('Take a picture', textScaleFactor: 1.1)),
                    onTap: openCamera,
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child:
                          new Text('Select from gallery', textScaleFactor: 1.1),
                    ),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    Navigator.of(context).pop();

    setState(() {
      logo = image;
    });
  }

  void openGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Navigator.of(context).pop();

    setState(() {
      logo = image;
    });
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
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.grey.shade50,
        title: Text("New Tournament"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height * .81,
          margin: EdgeInsets.only(bottom: 60.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    _optionsDialogBox();
                  },
                  child: logo == null
                      ? Icon(
                          Icons.image,
                    size: MediaQuery.of(context).size.height*.2,
                        )
                      : Image.file(logo,
                          height: MediaQuery.of(context).size.height * .2,
                          width: MediaQuery.of(context).size.height * .2),
                ),
              ),
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
                                  color: tournamentNameValid == true
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
                                hintText: 'Tournament Name',
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
                              controller: tournamentNameController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    tournamentNameValid = false;
                                    isEmpty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    tournamentNameValid = true;
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
                                  color: numberOfTeamsValid == true
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
                                hintText: 'Number of Teams',
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
                              controller: numberOfTeamsController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    numberOfTeamsValid = false;
                                    isEmpty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    numberOfTeamsValid = true;
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
                                  color: tournamentPlaceValid == true
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
                                hintText: 'Venue',
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
                              controller: tournamentPlaceController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    tournamentPlaceValid = false;
                                    isEmpty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    tournamentPlaceValid = true;
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
                            width: MediaQuery.of(context).size.width * 1.0,
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: tournamentGradeValid == true
                                      ? Colors.grey
                                      : Colors.red,
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
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: startingDateValid == true
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
                              child: new Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    startingDate == null
                                        ? "starting date"
                                        : startingDate,
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                    style: TextStyle(),
                                  )),
                            ),
                          )),
                    ),
                    Visibility(
                      visible: true,
                      child: new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: () {
                              _selectDate2(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: finalDateValid == true
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
                              child: new Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    finalDate == null
                                        ? "final date"
                                        : finalDate,
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                    style: TextStyle(),
                                  )),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
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
                      "Create Tournament",
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != startingDateController)
      startingDateController = picked;
    final f = new DateFormat('dd-MM-yyyy');

    var now = new DateTime.now();
    var different = now.difference(startingDateController);

    setState(() {
      startingDateController = picked;
      startingDate = f.format(picked);
    });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != finalDateController)
      finalDateController = picked;
    final f = new DateFormat('dd-MM-yyyy');

    if (finalDateController.isAfter(startingDateController)) {
      setState(() {
        finalDateController = picked;
        finalDate = f.format(picked);
      });
    } else {
      showdia("Starting date must be before final date.");
    }
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

    var turnamentname = tournamentNameController.text;
    var turnamentplace = tournamentPlaceController.text;
    var numberofteams = numberOfTeamsController.text;

    int overs, teams=0, groups;

    var status;




    if (isEmpty == false) {
      if (startingDateController == null || finalDateController == null) {
        isEmpty = true;
        startingDateValid = false;
        finalDateValid = false;
      } else {
        var now = new DateTime.now();
        var different = now.difference(startingDateController);

        if (now.compareTo(startingDateController)>0) {
          status = "Live";
        } else {
          status = "UpComing";
        }
      }
      var logoUrl="default";
      Map<String,dynamic> data=new Map();

      String tournamentID=mRootReference.push().key;

      if(logo!=null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref("new/$tournamentID.jpg");
        await ref.putFile(logo);
         logoUrl = await ref.getDownloadURL();

      }
      if(numberOfTeamsController.text!=null) {
        teams = int.parse(numberofteams);
      }
      data['LogoUrl']=logoUrl;

      data['TournamentName']=turnamentname;
      data['Venue']=turnamentplace;
      data['Status']=status;
      data['NoOfTeams']=teams;
      data['GradeLevel']=grade;
      data['ID']=tournamentID;
      data['StartingDate']=startingDateController.millisecondsSinceEpoch;
      data['FinalDate']=finalDateController.millisecondsSinceEpoch;


      mRootReference.child("Tournaments").child(status).child(tournamentID).update(data);

      Navigator.of(context).pop();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TournamentView(tournamentID: tournamentID,status: status,)));
    } else {
      isEmpty = false;
      Navigator.of(context).pop();

      showdia("Please fill all the fields before proceeding");
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

  void setstates() {
    setState(() {
    });
  }
}

class GradeLevel {
  int id;
  String name;

  GradeLevel(this.id, this.name);

  static List<GradeLevel> getCompanies() {
    return <GradeLevel>[
      GradeLevel(1, 'A'),
      GradeLevel(2, 'B'),
      GradeLevel(2, 'C'),
      GradeLevel(2, 'D'),
    ];
  }
}

