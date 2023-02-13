import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:email_launcher/email_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Colors/colors.dart';


class TeacherInfoDetailsScreen extends StatefulWidget {
  String name ;
  String email ;
  String designation ;
  String department ;
  String roomNo ;
  String primaryNumber ;
  String secondaryNumber;
  String image;
  String details;
  String pbx;


  TeacherInfoDetailsScreen(
  {
    required this.name,
    required this.email,
    required this.designation,
    required this.department,
    required this.roomNo,
    required this.primaryNumber,
    required this.secondaryNumber,
    required this.image,
    required this.details,
    required this.pbx
    }
    ); // TeacherInfoDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TeacherInfoDetailsScreen> createState() =>
      _TeacherInfoDetailsScreenState(
          this.name,
          this.email,
          this.designation,
          this.department,
          this.roomNo,
          this.primaryNumber,
          this.secondaryNumber,
          this.image,
          this.details,
          this.pbx
      );
}

class _TeacherInfoDetailsScreenState extends State<TeacherInfoDetailsScreen> {

  List _teacherInfoList = [];

  String _name="";
  String _email="";
  String _designation="";
  String _department="";
  String _roomNo="";
  String _primaryNumber="";
  String _secondaryNumber="";
  String _pbx="";
  String _image="";
  String _details="";
  _TeacherInfoDetailsScreenState(
          this._name,
         this._email,
         this._designation,
         this._department,
         this._roomNo,
         this._primaryNumber,
         this._secondaryNumber,
         this._image,
         this._details,
         this._pbx

      );






  @override
  void initState() {
    super.initState();


     // _getMostVisitedCourseDataList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(

        child: Flex(
          direction: Axis.vertical,
          children: [

            Container(
              // height: MediaQuery.of(context).size.height / 3.5,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15,bottom: 25),
              child: Column(
               children: [
                 ClipRRect(
                     borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 12),
                     child: Container(
                       height: MediaQuery.of(context).size.height / 7,
                       width: MediaQuery.of(context).size.height / 7,
                       child:FadeInImage.assetNetwork(

                         fit: BoxFit.fill,
                         placeholder: 'assets/images/images_avater.png',
                         image:_image,
                         imageErrorBuilder: (context, url, error) =>
                             Image.asset(
                               'assets/images/images_avater.png',
                               fit: BoxFit.fill,
                             ),
                       ),
                     )),
                 SizedBox(height: 10,),
                 Text(_name,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                       color:Colors.white,
                       fontSize: 20,
                       fontWeight: FontWeight.bold),
                   softWrap: false,
                   maxLines: 1,
                 )
               ],
              ),
              // height: 30,
            ),

            Expanded(
              child: _buildBottomDesignForList(),
            ),


          ],
        ),

        /* add child content here */
      ),
    );
  }

  Widget _buildBottomDesignForList() {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
            padding: EdgeInsets.only(left: 0, top:  15, right: 0, bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child:SingleChildScrollView(
                    child: Column(
                      children: [

                        _buildINfoItem("Name",_name,15),
                        Container(
                          margin: EdgeInsets.only(right: 20.0, top: 0, bottom: 7, left: 20),
                          //width: 180,
                          decoration: new BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(

                                color: Colors.grey.withOpacity(.25),
                                //  blurRadius: 20.0, // soften the shadow
                                blurRadius:20, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                )
                            )],
                          ),
                          //   height: 150,
                          child:Container(
                            margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
                            //color: Colors.white,
                            child: SizedBox(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [

                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child:Container(

                                        child: Column(

                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          // direction: Axis.vertical,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children:  [
                                                  Expanded(
                                                    child: Text(
                                                      "Email",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:teacherDetailsItemKeyTextColorColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500),
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),


                                                  ),
                                                  SizedBox(width: 7,),

                                                ],
                                              ),

                                            ),
                                            SizedBox(height: 5,),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children:  [
                                                  Expanded(
                                                    child: Text(
                                                      _email,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:teacherDetailsItemValueTextColorColor,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500),
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),


                                                  ),
                                                  SizedBox(width: 5,),

                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.email,size: 27,
                                      color: Colors.green,
                                    ),
                                    onPressed: () async {
                                      String email = Uri.encodeComponent(_email);
                                      // String email = Uri.encodeComponent("mail@fluttercampus.com");
                                      // String subject = Uri.encodeComponent("Hello Flutter");
                                      // String body = Uri.encodeComponent("Hi! I'm Flutter Developer");

                                      Uri mail = Uri.parse("mailto:$email");
                                      // Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                                      if (await launchUrl(mail)) {
                                      //email app opened
                                      }else{
                                      //email app is not opened
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20.0, top: 0, bottom: 10, left: 20),
                          //width: 180,
                          decoration: new BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(

                                color: Colors.grey.withOpacity(.25),
                                //  blurRadius: 20.0, // soften the shadow
                                blurRadius:20, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                )
                            )],
                          ),
                          //   height: 150,
                          child:Container(
                            margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
                            //color: Colors.white,
                            child: SizedBox(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [

                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child:Container(

                                        child: Column(

                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          // direction: Axis.vertical,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children:  [
                                                  Expanded(
                                                    child: Text(
                                                      "Primary Phone Number",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:teacherDetailsItemKeyTextColorColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500),
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),


                                                  ),
                                                  SizedBox(width: 7,),

                                                ],
                                              ),

                                            ),
                                            SizedBox(height: 5,),

                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children:  [
                                                  Expanded(
                                                    child: Text(
                                                      _primaryNumber,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:teacherDetailsItemValueTextColorColor,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500),
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),


                                                  ),
                                                  SizedBox(width: 5,),

                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.call,size: 27,
                                      color: Colors.green,
                                    ),
                                    // tooltip: 'Increase volume by 10',
                                    onPressed: (){
                                      _callNumber(_primaryNumber);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20.0, top: 0, bottom: 10, left: 20),
                          //width: 180,
                          decoration: new BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(

                                color: Colors.grey.withOpacity(.25),
                                //  blurRadius: 20.0, // soften the shadow
                                blurRadius:20, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  2.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                )
                            )],
                          ),
                          //   height: 150,
                          child:Container(
                            margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
                            //color: Colors.white,
                            child: SizedBox(
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [

                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child:Container(

                                        child: Column(

                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          // direction: Axis.vertical,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children:  [
                                                  Expanded(
                                                    child: Text(
                                                      "Secondary Phone Number",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:teacherDetailsItemKeyTextColorColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500),
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),


                                                  ),
                                                  SizedBox(width: 7,),

                                                ],
                                              ),

                                            ),
                                            SizedBox(height: 5,),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children:  [
                                                  Expanded(
                                                    child: Text(_secondaryNumber!=""?
                                                      _secondaryNumber:"----------------",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:teacherDetailsItemValueTextColorColor,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w500),
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),


                                                  ),
                                                  SizedBox(width: 5,),

                                                ],
                                              ),

                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.call,size: 27,
                                      color: Colors.green,
                                    ),
                                    // tooltip: 'Increase volume by 10',
                                    onPressed: (){
                                      _callNumber(_secondaryNumber);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        _buildINfoItem("Designation",_designation,0),
                        _buildINfoItem("Department",_department,0),
                        // _buildINfoItem("Designation","Lecturer"),
                        _buildINfoItem("Room",_roomNo,0),
                        _buildINfoItem("Pbx",_pbx,0),
                        _buildINfoItem("Details",_details,0)
                        // _buildINfoItem("designation","Lecturer");

                      ],
                    ),
                  ),
                )
              ],
            )));
  }
  void _launchEmail() async {
    List<String> to = "abdullah@gmail.com".split(',');
    Email email = Email(to: to,);
    EmailLauncher.launch(email).then((value) {
      // success
      print(value);
    }).catchError((error) {
      _showToast("error");
      print(error);
    });
  }
  Widget _buildINfoItem(String keyName, String keyValue,double marginTop) {
    return Container(
      margin: EdgeInsets.only(right: 20.0, top: marginTop, bottom: 7, left: 20),
      //width: 180,
      decoration: new BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(

            color: Colors.grey.withOpacity(.25),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            )
        )],
      ),
      //   height: 150,
      child:Container(
        margin: EdgeInsets.only(right: 10.0, top: 15, bottom: 15, left: 10),
        //color: Colors.white,
        child: SizedBox(
          child: Flex(
            direction: Axis.horizontal,
            children: [

              SizedBox(
                width: 15,
              ),
              Expanded(
                  child:Container(

                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // direction: Axis.vertical,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Flex(
                            direction: Axis.horizontal,
                            children:  [
                              Expanded(
                                child: Text(
                                  keyName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color:teacherDetailsItemKeyTextColorColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  softWrap: false,
                                  maxLines: 1,
                                ),


                              ),
                              SizedBox(width: 7,),

                            ],
                          ),

                        ),
                        SizedBox(height: 5,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Flex(
                            direction: Axis.horizontal,
                            children:  [
                              Expanded(
                                child: Text(
                                  keyValue,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color:teacherDetailsItemValueTextColorColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  softWrap: false,
                                  maxLines: 1,
                                ),


                              ),
                              SizedBox(width: 5,),

                            ],
                          ),

                        ),
                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
  // Navigator.push(context,MaterialPageRoute(builder: (context)=>CourseDetailsScreen()));


  _getMostVisitedCourseDataList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // offerShimmerStatus = true;
        try {
          var response = await get(
            Uri.parse(
                'https://odd-blue-seal-gear.cyclic.app/api/contact'),
            headers: {
              //"Authorization": "Token $accessToken",
            },
          );
         // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            setState(() {
              _showToast("Success");
              var data = jsonDecode(response.body);
              _teacherInfoList = data["contacts"];
              _showToast(_teacherInfoList.length.toString());

            });
          }
          else {
            // Fluttertoast.cancel();
          }
        } catch (e) {
          // Fluttertoast.cancel();

        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Future<void> _launchUrl( email) async {
  //   if (!await launchUrl(_url)) {
  //     throw 'Could not launch $_url';
  //   }
  // }
  // void _launchURL() async {
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: 'my.mail@example.com',
  //   );
  //   String  url = params.toString();
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     print( 'Could not launch $url');
  //   }
  // }

  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

}
