import 'package:badminton_score/app_colors.dart';
import 'package:badminton_score/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Visibility(child: new CircularProgressIndicator(),);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseDatabase.instance.setPersistenceEnabled(true);


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey.shade50,// status bar color
  ));
  ErrorWidget.builder = (errorDetails) {
    return Container( child:
    Center(
      child: CircularProgressIndicator(),
    )
    );
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async{



    runApp(
        MaterialApp(
            title: "BadmintonScore",
            theme: ThemeData(
              primaryColor: AppColors.PrimaryColor,
              scaffoldBackgroundColor: Colors.grey.shade50,
            ),
            debugShowCheckedModeBanner: false,
            home:  HomePage()
        )
    );
  });

}
