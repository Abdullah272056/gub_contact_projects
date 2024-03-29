
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gub_contact/view/splash_screen.dart';
import 'package:gub_contact/view/teacher_info_details.dart';


import 'log_in.dart';
import 'view/teacher_contact_list.dart';


Future<void> main() async {

  runApp( MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Color(0xFF00BE56),
    systemNavigationBarColor: Colors.green,

    // systemNavigationBarIconBrightness: Brightness.light,
    // systemNavigationBarDividerColor: null,
    statusBarColor: Colors.green,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body:SplashScreen()
          // body:ContactListScreen()
      ),
    );
  }


}