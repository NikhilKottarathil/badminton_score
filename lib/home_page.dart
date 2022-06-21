
import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/tabs/fixtures.dart';
import 'package:badminton_score/tabs/teams.dart';
import 'package:badminton_score/tabs/tournaments.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Widget title = Text("Fixtures");

  int _currentIndex = 0;

  List<Widget> _tabList = [
    // Tournaments(),
    Fixtures(),
    Teams()
  ];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setStates();
    _tabController = TabController(length: _tabList.length, vsync: this);

    _tabController.animateTo(_currentIndex);

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
        switch (_tabController.index) {
          // case 0:
          //   title = Text("Tournaments");
          //   break;
          case 0:
            title = Text("Fixtures");
            break;
          case 1:
            title = Text("Teams");
            break;
        }
      });
    });
    isSignedIN();
  }

  void isSignedIN() async {}

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor:Colors.white,

          title: title,
          centerTitle: true,
          elevation: 5.0,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.grey.shade50,
          color: AppColors.PrimaryColor,
          height: 60,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            // Icon(
            //   Icons.smart_button_sharp,
            //   size: 30,
            //   color: Colors.grey.shade50,
            // ),
            Icon(
              Icons.view_list,
              size: 30,
              color: Colors.grey.shade50,
            ),

            Icon(
              Icons.group_add,
              size: 30,
              color: Colors.grey.shade50,
            ),

          ],
          index: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            _tabController.animateTo(_currentIndex);
          },
        ),
        body: Container(
          height: ((MediaQuery.of(context).size.height * .9) - 60.0),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _tabList,
          ),
        ));
  }


  void setStates() {}
}

