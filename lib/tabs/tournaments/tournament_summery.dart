import 'dart:math';

import 'package:badminton_score/tabs/tournaments/add_tournament.dart';
import 'package:flutter/material.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class TournamentSummary extends StatefulWidget {
  String tournamentID, status;

  TournamentSummary({Key key, this.tournamentID, this.status})
      : super(key: key);

  @override
  _TournamentSummaryState createState() => _TournamentSummaryState();
}

class _TournamentSummaryState extends State<TournamentSummary> {
  int iter = 0;
  SharedPreferences sharedPreferences;
  String level;


  @override
  void initState() {

    super.initState();

  }

  Future getData() async {
    // Map<dynamic, dynamic> map3 = new Map();
    // map3['fhfsh'] = 'sgsfgh';
    Map<dynamic, dynamic> map;

    await mRootReference
        .child("Tournaments")
        .child(widget.status)
        .child(widget.tournamentID)
        .once()
        .then((DataSnapshot dataSnapshot) {
      map = dataSnapshot.value;

      // return  map;
      // throw Exception("Custom Error");
    });
    print(map);

    return map;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, mapData) {
        if (!mapData.hasData)
          return new Container(
            child: TextButton(
              child: Text("gsdh"),
              onPressed: () {
                print(mapData.data);
              },
            ),
          );
        return Container(
            height: MediaQuery.of(context).size.height * .82,
            child: ListView(
              children: <Widget>[
                Visibility(
                  visible: true,
                  child: new Padding(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 140,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: 110,
                                              height: 110,
                                              child: Container(
                                                child:
                                                    mapData.data['LogoUrl'] ==
                                                            "default"
                                                        ? CircleImageInkWell(
                                                            onPressed: () {},
                                                            size: 200,
                                                            // image: AssetImage(
                                                            //     'images/hometeam.png'),
                                                            image: NetworkImage(
                                                                "https://firebasestorage.googleapis.com/v0/b/badmintonscore-1cbbd.appspot.com/o/new%2F-MX7IQxIbIB_5_LvnVMI.jpg?alt=media&token=bef0363e-388f-450b-b7aa-8912f5d9d7ef"),
                                                            splashColor:
                                                                Colors.green,
                                                          )
                                                        : CircleImageInkWell(
                                                            onPressed: () {},
                                                            size: 200,
                                                            image: NetworkImage(
                                                                mapData.data[
                                                                    "LogoUrl"]),
                                                            splashColor:
                                                                Colors.green,
                                                          ),
                                              ),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            new Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 12.0),
                                                child: Text(
                                                  mapData
                                                      .data["TournamentName"],
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1.2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            new Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  mapData.data["NoOfTeams"]
                                                          .toString() +
                                                      " Teams",
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                  style: TextStyle(),
                                                )),
                                            new Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  mapData.data["GradeLevel"] +
                                                      " Level",
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                  style: TextStyle(),
                                                )),
                                            new Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  "Venue : " +
                                                      mapData.data["Venue"],
                                                  textAlign: TextAlign.center,
                                                  textScaleFactor: 1,
                                                  style: TextStyle(),
                                                )),
                                          ],
                                        )),
                                  ],
                                )),
                            mapData.data["TournamentLevel"]!=null? new Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  mapData.data["TournamentLevel"],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                )):Container(),
                            new Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddTournament()));
                                          },
                                          child: new Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.create,
                                                size: 20,
                                                color: Colors.teal,
                                              )),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            deletTurnament(widget.tournamentID);
                                          },
                                          child: new Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: Colors.red,
                                              )),
                                        )),
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
                Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Points Table",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  Future deletTurnament(String id) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.pop(context, "delete");
              },
            ),
          ],
        );
      },
    );
  }
}

