import 'package:badminton_score/tabs/teams/new_team.dart';
import 'package:flutter/material.dart';
import 'package:image_ink_well/image_ink_well.dart';

class TeamAdapter extends StatelessWidget {
  Map<dynamic, dynamic> map;

  Function function;

  TeamAdapter({this.map, this.function});

  @override
  Widget build(BuildContext context) {
    void showdia(Function function) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text('Are you sure to delete this team'),
            actions: <Widget>[
              FlatButton(
                child: Text('DELETE'),
                onPressed: () {
                  function();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return new Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // decoration: new BoxDecoration(
              // border: Border(
              //     bottom: BorderSide(color: Colors.grey.shade300, width: 1.0))),
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Player 1 : " + map['Player1Name'],
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.4,
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal),
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Player 2 : " + map['Player2Name'],
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.4,
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal),
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Text(
                                    map['TeamPlace'],
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1.3,
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal),
                                  )),
                              Visibility(
                                visible: function != null,
                                child: new Padding(
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
                                                            NewTeam(
                                                              teamIDExisting:
                                                                  map['ID'],
                                                            )));
                                              },
                                              child: new Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
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
                                                showdia(function);
                                              },
                                              child: new Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 20,
                                                    color: Colors.red,
                                                  )),
                                            )),
                                      ],
                                    )),
                              )
                            ],
                          )),
                    ],
                  )),
            ],
          ),
        ));
  }
  
  
}
