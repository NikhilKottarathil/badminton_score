
import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/tabs/fixtures/AddFixture.dart';
import 'package:badminton_score/tabs/fixtures/live_fixtures.dart';
import 'package:badminton_score/tabs/fixtures/recent_fixtures.dart';
import 'package:badminton_score/tabs/fixtures/up_coming_fixtures.dart';
import 'package:badminton_score/tabs/teams/team_live_fixtures.dart';
import 'package:badminton_score/tabs/teams/team_recent_fixtures.dart';
import 'package:badminton_score/tabs/teams/team_upcomin_fixtures.dart';
import 'package:badminton_score/tabs/tournaments/add_tournament.dart';
import 'package:badminton_score/tabs/tournaments/live_tournaments.dart';
import 'package:badminton_score/tabs/tournaments/recentturnaments.dart';
import 'package:badminton_score/tabs/tournaments/tournament_view.dart';
import 'package:badminton_score/tabs/tournaments/upcomingturnaments.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

import 'fixtures/create_new_fixture.dart';

class Fixtures extends StatefulWidget {
  @override
  FixturesState createState() => new FixturesState();
}

class FixturesState extends State<Fixtures>
    with SingleTickerProviderStateMixin {
  Widget recenttext = new Text(
    "Results",
    style: TextStyle(color: Colors.black),
  );
  Widget livetext = new Text(
    "Live",
    style: TextStyle(color: Colors.white),
  );
  Widget upcomingtext = new Text(
    "Upcoming",
    style: TextStyle(color: Colors.black),
  );

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 1);
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
      body: Column(
        children: <Widget>[
          new TabBar(
            labelPadding: EdgeInsets.only(top: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: new BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor:AppColors.PrimaryColor,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              controller: controller,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: <Tab>[
                new Tab(text: "Results"),
                new Tab(text: "Live"),
                new Tab(text: "Upcoming"),
              ]),
          Expanded(
            child: new TabBarView(controller: controller, children: <Widget>[
              new RecentFixtures(),
              new LiveFixtures(),
              new UpComingFixtures()
            ]),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Fixture',
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateNewFixture()));
        },
      ),
    );

  }
}
