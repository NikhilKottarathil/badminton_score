import 'package:badminton_score/tabs/tournaments/tournament_teams.dart';
import 'package:badminton_score/tabs/tournaments/tournament_fixture.dart';
import 'package:badminton_score/tabs/tournaments/tournament_summery.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

class TournamentView extends StatefulWidget {
  String tournamentID,status;
  TournamentView({Key key,this.tournamentID,this.status}):super(key: key);
  @override
  TournamentViewState createState() => new TournamentViewState();
}

class TournamentViewState extends State<TournamentView>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    controller.addListener(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.grey.shade50,
        title: Text("Turnament Details"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height * .9,
          child: Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: new BubbleTabIndicator(
                        indicatorHeight: 30.0,
                        indicatorColor: Colors.teal,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      controller: controller,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: <Tab>[
                        new Tab(text: "Summary"),
                        new Tab(text: "Teams"),
                        new Tab(text: "Fixture"),
                      ]),
                ),
                Expanded(
                  flex: 10,
                  child: new Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: new TabBarView(
                          controller: controller,
                          children: <Widget>[
                            TournamentSummary(tournamentID: widget.tournamentID,status: widget.status,),
                            TournamentTeams(tournamentID: widget.tournamentID,tournamentStatus: widget.status,),
                            TournamentFixture(tournamentID: widget.tournamentID,tournamentStatus: widget.status,),
                          ])),
                )
              ],
            ),
          )),
    );
  }


}
