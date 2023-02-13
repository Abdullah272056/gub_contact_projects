import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gub_contact/view/teacher_info_details.dart';
import 'package:gub_contact/data_base/teacher_note.dart';
import 'package:gub_contact/data_base/teacher_notes_database.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Colors/colors.dart';
import '../data_base/department_database.dart';
import '../data_base/department_note.dart';
import '../data_base/notes_database.dart';
import 'custom_drawer.dart';


class DeveloperInfoListScreen extends StatefulWidget {
  const DeveloperInfoListScreen({Key? key}) : super(key: key);

  @override
  State<DeveloperInfoListScreen> createState() =>
      _DeveloperInfoListScreenState();
}

class _DeveloperInfoListScreenState extends State<DeveloperInfoListScreen> {


  List _teacherInfoList = [];
  List _departmentList = [];
  int _darkOrLightStatus = 1;
  bool _shimmerStatus = false;
  List<TeacherNote> notesList=[];
  List<TeacherNote> notesListCopy=[];
  List<TeacherNote> notesListSearchAndFilter=[];
  List<DepartmentNote> departmentNotesList=[];
  bool isLoading =false;

  String selectAssignmentId="";

  @override
  @mustCallSuper
  initState() {
    super.initState();


  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.green,
      body: Container(

        child: Flex(
          direction: Axis.vertical,
          children: [


            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
              // height: 50,
            ),

            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),

                Expanded(
                    child: Container(
                      margin: new EdgeInsets.only(left: 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Developer Info",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),





              ],
            ),





            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
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
            padding: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child:

                    _buildTeacherContactItemForList(
                        image: '',
                        name: 'Abdullah',
                        designation: 'Mobile Apps Developer (iOs & Android)',
                        department: 'CSE',
                        sId: '212015049',
                        phone: '01994215664',
                        email: 'abdullah272056@gmail.com'
                    ),


                )
              ],
            )));
  }


  Widget _buildTeacherContactItemForList(
        {
          required String image,
          required String name,
          required String designation,
          required String department,
          required String sId,
          required String phone,
          required String email
        }
      ) {
    return InkResponse(
      onTap: (){

      },
      child:
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
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child:FadeInImage.assetNetwork(
                        height: 90,
                        width: 90,
                        fit: BoxFit.fill,
                        placeholder: 'assets/images/images_avater.png',
                        image:image,
                        imageErrorBuilder: (context, url, error) =>
                            Image.asset(
                              'assets/images/images_avater.png',
                              fit: BoxFit.fill,
                            ),
                      ),
                    )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child:Container(
                      height: 90,
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
                                    name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                    maxLines: 1,
                                  ),


                                ),
                                SizedBox(width: 5,),

                              ],
                            ),

                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Flex(
                              direction: Axis.horizontal,
                              children:  [
                                Expanded(
                                  child: Text(
                                    designation.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                    maxLines: 1,
                                  ),


                                ),
                                SizedBox(width: 5,),

                              ],
                            ),

                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Flex(
                              direction: Axis.horizontal,
                              children:  [
                                Expanded(
                                  child: Text(
                                     phone.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                    maxLines: 1,
                                  ),


                                ),
                                SizedBox(width: 5,),

                              ],
                            ),

                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Flex(
                              direction: Axis.horizontal,
                              children:  [
                                Expanded(
                                  child: Text(
                                    email.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                    maxLines: 1,
                                  ),


                                ),
                                SizedBox(width: 5,),

                              ],
                            ),

                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Flex(
                              direction: Axis.horizontal,
                              children:  [
                                Expanded(
                                  child: Text(
                                    department.toString()
                                    ,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color:Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
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
      ),

    );
  }











  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

}
