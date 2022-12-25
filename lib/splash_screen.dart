
import 'dart:convert';
import 'dart:io';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gub_contact/teacher_contact_list.dart';

import 'note.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'notes_database.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  @mustCallSuper
  initState() {
    super.initState();
    Future.delayed( const Duration(milliseconds: 1500), () {
      setState(() {
        Route route = MaterialPageRoute(builder: (context) => ContactListScreen());
        Navigator.pushReplacement(context, route);

       // Navigator.push(context,MaterialPageRoute(builder: (context)=>ContactListScreen()));

        //Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 500), child: SplashScreen3()));

      });

    }
    );
  }

  // @override
  // void dispose() {
  //   //NotesDataBase.instance.close();
  //   super.dispose();
  //
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:Container(
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedWidget(

                delayDuration: const Duration(milliseconds: 10),// Not required
                animationDuration: const Duration(milliseconds: 600),// Not required
                animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                child: Text("Welcome",
                style: TextStyle(fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.green
                  ,),
                ),


              ),
              SizedBox(height: 50,),

              Text("to",
                style: TextStyle(fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.5)
                  ,),
              ),
              SizedBox(height: 50,),
              DelayedWidget(

                delayDuration: const Duration(milliseconds: 10),// Not required
                animationDuration: const Duration(milliseconds: 600),// Not required
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                child:   Image.asset(
                  "assets/images/gub_logo.png",
                  width: 230,
                  height: 70,
                  fit: BoxFit.fill,
                ),


              ),


            ],

          ),
        ),
      ),
    );
  }


}

