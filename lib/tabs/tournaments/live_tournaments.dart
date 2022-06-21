import 'package:badminton_score/components/tournament_adapter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class LiveTournaments extends StatefulWidget {
  @override
  _LiveTournamentsState createState() => _LiveTournamentsState();
}

class _LiveTournamentsState extends State<LiveTournaments> {
  List<Map<dynamic, dynamic>> tournamentList = new List();

  @override
  void initState() {
    super.initState();
    check();
  }

  check() async {
    mRootReference.child('Tournaments').child('Live').onValue.listen((event) {
      tournamentList.clear();
      if(event.snapshot.value!=null) {
        event.snapshot.value.forEach((key, value) {
          tournamentList.add(value);
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
    return _buildBody();
  }

  Widget _buildBody() {
    return Visibility(
      visible: tournamentList == null ? false : true,
      child: ListView.builder(
        itemCount: tournamentList == null ? 0 : tournamentList.length,
        itemBuilder: (context, index) {
          return TournamentAdapter(
            tournament: tournamentList[index],
          );
        },
      ),
    );
  }
}
