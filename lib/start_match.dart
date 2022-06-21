import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/matchpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

DatabaseReference mRootReference = FirebaseDatabase.instance.reference();

class StartMatch extends StatefulWidget {
  String fixtureID, fixtureStatus;
  Map<dynamic, dynamic> map;

  StartMatch({Key key, this.fixtureID, this.fixtureStatus, this.map})
      : super(key: key);

  @override
  _StartMatchState createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  int radioValue = 1, live1Radio = 1, live2Radio = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Point Type',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.PrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Please select court',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: live1Radio,
                            groupValue: radioValue,
                            onChanged: (int i) {
                              setState(() {
                                radioValue = live1Radio;

                              });
                            },
                          ),
                          Text('Live 1')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: live2Radio,
                            groupValue: radioValue,
                            onChanged: (int i) {
                              setState(() {
                                radioValue = live2Radio;
                              });
                            },
                          ),
                          Text('Live 2')
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () {
                        _startMatch(1);
                      },
                      child: Center(
                          child: Text(
                        '15 Last',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                    ))),
            Expanded(
                flex: 3,
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () {
                        _startMatch(2);
                      },
                      child: Center(
                          child: Text(
                        '21 Last',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                    ))),
            Expanded(
                flex: 3,
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () {
                        _startMatch(3);
                      },
                      child: Center(
                          child: Text(
                        '30 Last',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                    ))),
        ],
        ),
      ),
    );
  }

  void _startMatch(int i) {
    print('radio values $live2Radio $live2Radio $radioValue');
    mRootReference.child('Fixtures').child("Live").once().then((snapShot) {
      bool isLive1Free = true, isLive2Free = true;
      if(radioValue==1){
        isLive2Free=false;
      }else{
        isLive1Free=false;
      }
      if (snapShot.value != null) {
        Map<dynamic, dynamic> liveMap = snapShot.value;
        liveMap.forEach((key, value) {
          if (value['GameStatus'] != 'Finished') {
            if (key == 'Live1') {
              isLive1Free = false;
            }
            if (key == 'Live2') {
              isLive2Free = false;
            }
          }
        });
      }
      if (isLive2Free || isLive1Free) {
        String id;
        if (isLive1Free) {
          id = "Live1";
        } else {
          id = 'Live2';
        }

        mRootReference
            .child('Fixtures')
            .child(widget.fixtureStatus)
            .child(widget.fixtureID)
            .once()
            .then((snapShotMatch) {
          Map<String, dynamic> mapMatch =Map<String,dynamic>.from(snapShotMatch.value);
          mapMatch['Status'] = 'Live';
          mapMatch['ID'] = id;
          mapMatch['FixtureID'] = mapMatch['FixtureID'];
          mapMatch['GameStatus'] = mapMatch['Started'];
          mapMatch['PointType'] = i;

          Map<String, dynamic> data = new Map();
          data['00'] = widget.map['Team1Player1'];
          data['01'] = widget.map['Team1Player2'];
          data['10'] = widget.map['Team2Player1'];
          data['11'] = widget.map['Team2Player2'];
          data['ServeTeam'] = widget.map['Team2'];
          data['CurrentBox'] = '10';
          data['Team1Point'] = 0;
          data['Team2Point'] = 0;

          print('live dat $mapMatch');
          print('live dat $id');
          mRootReference
              .child("Fixtures")
              .child('Live')
              .child(id)
              .set(mapMatch);
          //
          mRootReference
              .child("Fixtures")
              .child('Live')
              .child(id)
              .child('Sets')
              .child('1')
              .update(data);
          mRootReference
              .child('Fixtures')
              .child(widget.fixtureStatus)
              .child(widget.fixtureID).remove();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MatchPage(
                        fixtureID: id,
                        fixtureStatus: 'Live',
                        pointType: i,
                        currentSet: '1',
                      )));


        });
      }else{
        showAlert();
      }
    });
  }
  void showAlert() {

    String court='Live 1';
    if(radioValue==1){
      court='Live 1';
    }else{
      court='Live 2';
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Warning',
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .4,
            child: Center(child: Text('Unable To Start The Match \n  Games is Already Running in $court',textAlign: TextAlign.center,),),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: Text('\t \t OK \t  \t')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                },
                child: Text('\t \t EXIT \t \t')),

          ],
        );
      },
    );
  }

}


//
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10)
// ),
