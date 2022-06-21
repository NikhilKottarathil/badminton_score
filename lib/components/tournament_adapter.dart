import 'package:badminton_score/tabs/tournaments/add_tournament.dart';
import 'package:badminton_score/tabs/tournaments/tournament_view.dart';
import 'package:flutter/material.dart';
import 'package:image_ink_well/image_ink_well.dart';
import 'package:intl/intl.dart';

class TournamentAdapter extends StatelessWidget {
  Map<dynamic, dynamic> tournament;

  TournamentAdapter({this.tournament});

  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(onPressed: (){
    //   print("tour $tournament");
    //
    // }, child: Text("fgfhfdh"));
    return Visibility(
      visible: true,
      child: new Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TournamentView(tournamentID:tournament['ID'],status: tournament["Status"],)));
            },
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
              ),
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        getDateString(tournament['StartingDate'].toString()) +
                            " - " +
                            getDateString(tournament['FinalDate'].toString()),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )),
                  new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 3,
                              child: Container(
                                height: 100,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Container(
                                      child: tournament['LogoUrl'] == "default"
                                          ? CircleImageInkWell(
                                              onPressed: () {},
                                              size: 80,
                                              image: AssetImage(
                                                  'images/hometeam.png'),
                                              splashColor: Colors.green,
                                            )
                                          : CircleImageInkWell(
                                              onPressed: () {},
                                              size: 80,
                                              image: NetworkImage(
                                                  tournament['LogoUrl']),
                                              splashColor: Colors.green,
                                            ),
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        tournament['TournamentName'],
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  tournament['NoOfTeams'] != null
                                      ? new Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            tournament['NoOfTeams'].toString() +
                                                " Teams",
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1,
                                            style: TextStyle(),
                                          ))
                                      : Container(),
                                  new Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "Venue : " + tournament['Venue'],
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1,
                                        style: TextStyle(),
                                      )),
                                ],
                              )),
                        ],
                      )),
                  tournament["TournamentLevel"]!=null? new Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 15.0),
                      child: Text(
                        tournament["TournamentLevel"],
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      )):Container(),
                ],
              ),
            ),
          )),
    );
  }

  String getDateString(String string) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(string));
    final f = new DateFormat('dd-MM-yyyy');
    String startingdate = f.format(dateTime);

    return startingdate;
  }
}
