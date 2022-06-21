
import 'package:flutter/material.dart';
class RecentTournaments extends StatefulWidget {
  @override
  _RecentTournamentsState createState() => _RecentTournamentsState();
}

class _RecentTournamentsState extends State<RecentTournaments> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


//
// import 'package:abd360/models/turnamentmodel/turnament_dao.dart';
// import 'package:abd360/models/turnamentmodel/turnament_model.dart';
// import 'package:abd360/turnament/singleturnamentview/turnamentview.dart';
// import 'package:flutter/material.dart';
// import 'package:image_ink_well/image_ink_well.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class RecentTournaments extends StatefulWidget {
//   @override
//   _RecentTournamentsState createState() => _RecentTournamentsState();
// }
//
// class _RecentTournamentsState extends State<RecentTournaments> {
//   TurnamentDao _fruitDao = TurnamentDao();
//   List tunaments;
//   String turnamentState;
//   @override
//   void initState() {
//     super.initState();
//     // Obtaining the FruitBloc instance through BlocProvider which is an InheritedWidget
//     check();
//   }
//
//   check() async {
//     List<TurnamentModel> tunament = await _fruitDao.getRecentTurnaments("_db");
//
//     setState(() {
//       tunaments = tunament;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   Widget _buildBody() {
//     return Visibility(
//       visible: tunaments == null ? false : true,
//       child: ListView.builder(
//         itemCount: tunaments == null ? 0 : tunaments.length,
//         itemBuilder: (context, index) {
//           return Visibility(
//             visible: true,
//             child: new Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: InkWell(
//                   onTap: () async {
//                     SharedPreferences sharedPreferences =
//                         await SharedPreferences.getInstance();
//                     sharedPreferences.setString(
//                         'selectedturnamentid', tunaments[index].id.toString());
//                     turnamentState = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => TurnamentView()));
//
//                     print("pagestate is");
//                     print(turnamentState);
//                     if (turnamentState == "delete") {
//                       check();
//                     }
//                   },
//                   child: Container(
//                     decoration: new BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 4.0,
//                         ),
//                       ],
//                       color: Colors.white,
//                       borderRadius:
//                           new BorderRadius.all(const Radius.circular(5.0)),
//                     ),
//                     padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         new Padding(
//                             padding: const EdgeInsets.only(top: 15.0),
//                             child: Text(
//                               getDateString(
//                                       tunaments[index].startdate.toString()) +
//                                   " - " +
//                                   getDateString(
//                                       tunaments[index].finaldate.toString()),
//                               textAlign: TextAlign.center,
//                               textScaleFactor: 1,
//                               style: TextStyle(
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold),
//                             )),
//                         new Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                     flex: 3,
//                                     child: Container(
//                                       height: 100,
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: SizedBox(
//                                           width: 80,
//                                           height: 80,
//                                           child: Container(
//                                             child: tunaments[index].logourl ==
//                                                     "default"
//                                                 ? CircleImageInkWell(
//                                                     onPressed: () {},
//                                                     size: 80,
//                                                     image: AssetImage(
//                                                         'images/hometeam.png'),
//                                                     splashColor: Colors.green,
//                                                   )
//                                                 : CircleImageInkWell(
//                                                     onPressed: () {},
//                                                     size: 80,
//                                                     image: AssetImage(
//                                                         tunaments[index]
//                                                             .logourl),
//                                                     splashColor: Colors.green,
//                                                   ),
//                                           ),
//                                         ),
//                                       ),
//                                     )),
//                                 Expanded(
//                                     flex: 4,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         new Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 12.0),
//                                             child: Text(
//                                               tunaments[index].name,
//                                               textAlign: TextAlign.center,
//                                               textScaleFactor: 1.2,
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             )),
//                                         new Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 5.0),
//                                             child: Text(
//                                               tunaments[index]
//                                                       .numberofteams
//                                                       .toString() +
//                                                   " Teams",
//                                               textAlign: TextAlign.center,
//                                               textScaleFactor: 1,
//                                               style: TextStyle(),
//                                             )),
//                                         new Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 5.0),
//                                             child: Text(
//                                               tunaments[index].type == "Test"
//                                                   ? "Test "
//                                                   : tunaments[index]
//                                                           .overs
//                                                           .toString() +
//                                                       " Overs",
//                                               textAlign: TextAlign.center,
//                                               textScaleFactor: 1,
//                                               style: TextStyle(),
//                                             )),
//                                         new Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 5.0),
//                                             child: Text(
//                                               "Stadium : " +
//                                                   tunaments[index].stadium,
//                                               textAlign: TextAlign.center,
//                                               textScaleFactor: 1,
//                                               style: TextStyle(),
//                                             )),
//                                       ],
//                                     )),
//                               ],
//                             )),
//                         new Padding(
//                             padding:
//                                 const EdgeInsets.only(top: 12.0, bottom: 15.0),
//                             child: Text(
//                               tunaments[index].winner + " won the Turnament",
//                               textAlign: TextAlign.center,
//                               textScaleFactor: 1.2,
//                               style: TextStyle(
//                                   color: Colors.teal,
//                                   fontWeight: FontWeight.bold),
//                             )),
//                       ],
//                     ),
//                   ),
//                 )),
//           );
//         },
//       ),
//     );
//   }
//
//   String getDateString(String string) {
//     DateTime dateTime = DateTime.parse(string);
//     final f = new DateFormat('dd-MM-yyyy');
//     String startingdate = f.format(dateTime);
//
//     return startingdate;
//   }
// }
