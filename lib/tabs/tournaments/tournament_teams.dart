import 'package:badminton_score/components/team_adapter.dart';
import 'package:badminton_score/tabs/teams/new_team.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

DatabaseReference mRootReference=FirebaseDatabase.instance.reference();
class TournamentTeams extends StatefulWidget {
  String tournamentID,tournamentStatus;
  TournamentTeams({Key key,this.tournamentID,this.tournamentStatus}):super(key: key);
  @override
  _TournamentTeamsState createState() => _TournamentTeamsState();
}

class _TournamentTeamsState extends State<TournamentTeams> {
  int numberOfTeamsLimit;
  int numberOfTeamsAdded;

  List<Map<dynamic,dynamic>> teams=new List();
  List<Map<dynamic,dynamic>> homeTeams=new List();
  bool delplayers = true;
  int iter = 0;
  List <String> teamIDs=new List();
  String level;
  bool isTeamNotAdded=true;
  List teamsare;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {

    mRootReference.child("Teams").once().then((DataSnapshot snapshot) {
      if(snapshot.value!=null) {
        Map<dynamic, dynamic> map = snapshot.value;
        homeTeams.clear();
        map.forEach((key, value) {
          homeTeams.add(value);
        });
      }
    },onError: (Object o) {
      final DatabaseError error = o;
      setState(() {});
    });
    mRootReference.child("Tournaments").child(widget.tournamentStatus).child(widget.tournamentID).onValue.listen((event) {

      Map<dynamic,dynamic> map=event.snapshot.value;
      numberOfTeamsLimit=map['NoOfTeams'];
      print("numberOfTeamsLimit $numberOfTeamsLimit");
      teamIDs.clear();
      teams.clear();
      if(map['Teams']!=null){
        isTeamNotAdded=false;
        Map<dynamic,dynamic> teamMap=map['Teams'];

        teamMap.forEach((key, value) {
          teamIDs.add(key);
          mRootReference.child("Teams").child(key).once()
              .then((DataSnapshot dataSnapshot) {
            Map<dynamic, dynamic> mapSingleTeam = dataSnapshot.value;
            teams.add(mapSingleTeam);
            setState(() {});

          });
        });
      }

      setState(() {});
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isTeamNotAdded == true
            ? Visibility(
          visible: isTeamNotAdded == true ? true : false,
          child: Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Text(
                  "No Teams Added",
                  textScaleFactor: 1.3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        )
            : Visibility(
          visible: isTeamNotAdded == true ? false : true,
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
                height: MediaQuery.of(context).size.height * .7,
                padding: EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: teams == null ? 0 : teams.length,
                  itemBuilder: (context, index) {
                    return TeamAdapter(map: teams[index],function: (){
                      mRootReference.child("Tournaments").child(widget.tournamentStatus).child(widget.tournamentID).child("Teams").child(teams[index]['ID']).remove();
                    },);

                  },
                ),
              )),
        ),
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
                      onPressed: () async {
                        if (teams != null) {
                          if (teams.length >= numberOfTeamsLimit) {
                            showdia("Can't add more teams");
                          } else {
                            selectHomeTeam();
                          }
                        } else {
                          selectHomeTeam();
                        }
                      },
                      child: new Text(
                        "Add Team",
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
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

  void selectHomeTeam() {
    showDialog(
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
                            itemCount: homeTeams.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  bool isPresent = false;

                                  setState(() {

                                    if(teamIDs.contains(homeTeams[index]['ID'])){
                                      isPresent=true;
                                    }

                                    print('clickerddfgfdhdfh');
                                    if (isPresent) {
                                      Navigator.of(context).pop();

                                      showdia("Team Already present");
                                    } else {
                                      mRootReference.child("Tournaments").child(widget.tournamentStatus).child(widget.tournamentID).child("Teams").child(homeTeams[index]["ID"]).set(homeTeams[index]["ID"]);
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                child: TeamAdapter(map: homeTeams[index])
                              );
                            }),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        child: ButtonTheme(
                          minWidth: 200.0,
                          height: 60.0,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.teal,
                            onPressed: () async {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewTeam(tournamentID: widget.tournamentID,status: widget.tournamentStatus,)));
                            },
                            child: new Text(
                              "Add New Team",
                              textScaleFactor: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
