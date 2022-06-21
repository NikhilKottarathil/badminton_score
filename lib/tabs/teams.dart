import 'dart:async';

import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/components/team_adapter.dart';
import 'package:badminton_score/tabs/teams/new_team.dart';
import 'package:badminton_score/tabs/teams/team_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();
StreamSubscription<Event> teamSubscription;

class Teams extends StatefulWidget {
  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List<Map<dynamic, dynamic>> teams = new List();

  @override
  void dispose() {
    // TODO: implement dispose
    teamSubscription.cancel();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // mRootReference
    //     .child("Teams").keepSynced(true);
    getData();
  }

  getData() async {
   teamSubscription= mRootReference.child("Teams").onValue.listen((event)   {
      teams.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value;
        map.forEach((key, value) {
          teams.add(value);
        });
        setState(() {

        });
      }
      setState(() {});

    }, onError: (Object o) {
      final DatabaseError error = o;
    });
   //
   //  mRootReference.child("TeamTest").onValue.listen((event)   {
   //    teams.clear();
   //    if (event.snapshot.value != null) {
   //      List<dynamic> map = event.snapshot.value;
   //      map.forEach((value) {
   //        Map<String,dynamic> data=Map<String,dynamic>.from(value);
   //        String teamID=mRootReference.push().key;
   //        data['Player1Phone']='';
   //        data['Player2Phone']='';
   //        data['ID']=teamID;
   //        data['CreatedTime']=DateTime.now().millisecondsSinceEpoch;
   //        mRootReference.child("Teams").child(teamID).set(data);
   //      });
   //
   //    }
   //
   //  }, onError: (Object o) {
   //    final DatabaseError error = o;
   //  });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:teams.length!=0? ListView.builder(
        itemCount: teams == null ? 0 : teams.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTeam(teamIDExisting: teams[index]['ID'],)));
            },
            child:              Padding(
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
                  child:  TeamAdapter(
                  map: teams[index],function: (){
                  mRootReference.child("Teams").child(teams[index]['ID']).remove();
                },
                ),
                )),

          );
        },
      ):Center(child: Text('No Teams'),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.PrimaryColor,
        heroTag: 'teams',
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTeam()));
        },
      ),
    );
  }

}
