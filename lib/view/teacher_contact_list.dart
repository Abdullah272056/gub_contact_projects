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


class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() =>
      _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {


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
    _getTeacherContactList();
    _getDepartmentDataList();
    refreshNotes();

    refreshDepartmentNotes();

  }

  @override
  void dispose() {
   // NotesDataBase.instance.close();
    super.dispose();

  }

  Future refreshNotes() async {
    TeacherNotesDataBase.instance;
    setState(() {
      isLoading=true;
    });
    this.notesList=await TeacherNotesDataBase.instance.readAllNotes();

    this.notesListCopy=notesList;
    this.notesListSearchAndFilter=notesList;
   // _showToast("notesListCopy"+notesListCopy.length.toString());


    setState(() {
      isLoading=false;
    });

  }

  Future refreshDepartmentNotes() async {
    DepartmentDataBase.instance;
    setState(() {
      isLoading=true;
    });

    this.departmentNotesList=await DepartmentDataBase.instance.readAllNotes();

    // _showToast("aas= "+departmentNotesList.length.toString());

    setState(() {
      isLoading=false;
    });

  }

  _showToas(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  TextEditingController? _searchController = TextEditingController();

  bool _searchBoxHideShowStatus=false;
  bool _filterBoxHideShowStatus=false;
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey();
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: CustomDrawer(),
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
                      if (_drawerKey.currentState!.isDrawerOpen) {
                        setState(() {
                          isDrawerOpen = false;
                        });
                        _drawerKey.currentState!.openEndDrawer();
                        return;
                      } else
                        _drawerKey.currentState!.openDrawer();
                      setState(() {
                        isDrawerOpen = true;
                      });
                    },
                    child: const Icon(
                      Icons.menu,
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
                          "Teacher Contacts",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),




                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(

                    onTap: () {
                      setState(() {
                        _searchBoxHideShowStatus=!_searchBoxHideShowStatus;
                      });
                    },
                    child:  Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: InkWell(

                    onTap: () {
                      setState(() {
                        _filterBoxHideShowStatus=!_filterBoxHideShowStatus;
                      });

                    },
                    child:  Icon(
                      Icons.group_rounded,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
              ],
            ),

            // Flex(
            //   direction: Axis.horizontal,
            //   children: [
            //     // Container(
            //     //   margin: new EdgeInsets.only(left: 30),
            //     //   child: InkResponse(
            //     //     onTap: () {
            //     //     //  Navigator.of(context).pop();
            //     //     },
            //     //     child: Icon(
            //     //       Icons.arrow_back,
            //     //       color: Colors.white,
            //     //       size: 30.0,
            //     //     ),
            //     //   ),
            //     // ),
            //     Expanded(
            //         child: Container(
            //           margin: new EdgeInsets.only(left: 25),
            //           child: Align(
            //             alignment: Alignment.centerLeft,
            //             child: Text(
            //               "Teacher Contacts",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ),
            //         )),
            //
            //
            //
            //   ],
            // ),
            if(_filterBoxHideShowStatus==true)...{
              DelayedWidget(
                delayDuration: const Duration(milliseconds: 10),// Not required
                animationDuration: const Duration(milliseconds: 500),// Not required
                animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                child: userInputSelectTopic(),
              ),

            },

            if(_searchBoxHideShowStatus==true)...{
              SizedBox(height: 15,),
              DelayedWidget(
                delayDuration: const Duration(milliseconds: 10),// Not required
                animationDuration: const Duration(milliseconds: 500),// Not required
                animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                child: userInputSearchField(_searchController!, 'Search by name', TextInputType.text),
              ),

            },




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
                  child:_shimmerStatus==false?
                  ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                      itemCount: notesListSearchAndFilter==null||notesListSearchAndFilter.length<=0?0:
                      notesListSearchAndFilter.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return
                          _buildTeacherContactItemForList(notesListSearchAndFilter[index]);

                      }):contactListShimmer(),
                )
              ],
            )));
  }


  Widget _buildTeacherContactItemForList(TeacherNote response) {
    return InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>
            TeacherInfoDetailsScreen(
              name: response.name,
              email: response.email,
              designation: response.designation,
              department: response.department,
              roomNo: response.room,
              primaryNumber: response.primaryPhone,
              secondaryNumber: response.secondaryPhone,
              image:response.photo,
              details: response.details,
              pbx: response.pbx,

            )
        ));
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
                        image:response.photo,
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
                                    response.name.toString(),
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
                                    response.primaryPhone.toString(),
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
                                    response.email.toString(),
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
                                    response.department.toString()+" (${response.designation.toString()})"
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
                IconButton(
                  icon: const Icon(Icons.call,size: 27,
                    color: Colors.green,
                  ),
                  onPressed: (){
                    _callNumber(response.primaryPhone.toString());
                    // _callNumber("01994215664");
                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }


  //shimmer design
  Widget contactItemShimmer() {
    return Container(
      margin: EdgeInsets.only(right: 10.0, top: 0, bottom: 10, left: 10),
      //width: 180,
      decoration: new BoxDecoration(
        color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [BoxShadow(
        //
        //   color: _darkOrLightStatus == 1?Colors.grey.withOpacity(.25):shimmer_containerBgColorDark1,
        //   //  blurRadius: 20.0, // soften the shadow
        //   blurRadius: _darkOrLightStatus == 1?20:6, // soften the shadow
        //   spreadRadius: 0.0, //extend the shadow
        //   offset: _darkOrLightStatus == 1 ? Offset(
        //     2.0, // Move to right 10  horizontally
        //     1.0, // Move to bottom 10 Vertically
        //   ):
        //   Offset(
        //     1.0, // Move to right 10  horizontally
        //     1.0, // Move to bottom 10 Vertically
        //   ),
        // )],
      ),
      //   height: 150,
      child:Container(
        margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
        //color: Colors.white,
        child: SizedBox(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Shimmer.fromColors(
                baseColor:_darkOrLightStatus==1? shimmer_baseColor:shimmer_baseColorDark,
                highlightColor:_darkOrLightStatus==1? shimmer_highlightColor:shimmer_highlightColorDark,
                child:ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
                    )),


              ),

              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Align(alignment: Alignment.topLeft,
                          child:  Shimmer.fromColors(
                            baseColor:_darkOrLightStatus==1? shimmer_baseColor:shimmer_baseColorDark,
                            highlightColor:_darkOrLightStatus==1? shimmer_highlightColor:shimmer_highlightColorDark,
                            child:Container(
                              height: 25,
                              // width: 130,
                              color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Align(alignment: Alignment.topLeft,
                          child:  Shimmer.fromColors(
                            baseColor:_darkOrLightStatus==1? shimmer_baseColor:shimmer_baseColorDark,
                            highlightColor:_darkOrLightStatus==1? shimmer_highlightColor:shimmer_highlightColorDark,
                            child:Container(
                              height: 15,
                              // width: 130,
                              color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(alignment: Alignment.topLeft,
                          child:  Shimmer.fromColors(
                            baseColor:_darkOrLightStatus==1? shimmer_baseColor:shimmer_baseColorDark,
                            highlightColor:_darkOrLightStatus==1? shimmer_highlightColor:shimmer_highlightColorDark,
                            child:Container(
                              height: 15,
                              // width: 130,
                              color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(alignment: Alignment.topLeft,
                          child:  Shimmer.fromColors(
                            baseColor:_darkOrLightStatus==1? shimmer_baseColor:shimmer_baseColorDark,
                            highlightColor:_darkOrLightStatus==1? shimmer_highlightColor:shimmer_highlightColorDark,
                            child:Container(
                              height: 15,
                              // width: 130,
                              color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
                            ),
                          ),
                        ),


                      ],
                    ),
                  )),
              SizedBox(
                width: 5,
              ),
              Align(alignment: Alignment.topLeft,
                child:  Shimmer.fromColors(
                  baseColor:_darkOrLightStatus==1? shimmer_baseColor:shimmer_baseColorDark,
                  highlightColor:_darkOrLightStatus==1? shimmer_highlightColor:shimmer_highlightColorDark,
                  child:Container(
                    height: 35,
                    width: 40,
                    // width: 130,
                    color:_darkOrLightStatus == 1 ? Colors.white:shimmer_containerBgColorDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
  Widget contactListShimmer() {
    return  ListView.builder(
        padding: EdgeInsets.zero,
        itemCount:10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return contactItemShimmer();
        });
  }

  _getTeacherContactList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // offerShimmerStatus = true;
        try {
          var response = await get(
            Uri.parse(
                'https://gub-contact-api.onrender.com/api/contact'
                // 'https://odd-blue-seal-gear.cyclic.app/api/contact'
            ),
            headers: {
              //"Authorization": "Token $accessToken",
            },
          );
         // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            setState(() {
             // _showToast("Success");
              var data = jsonDecode(response.body);
              _teacherInfoList = data["contacts"];

              _shimmerStatus=false;


              setState(() {
                insertData(data["contacts"]);
              });

            //   _showToast(_teacherInfoList.length.toString());

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
     // _showToast("No Internet Connection!");
    }
  }

  _getDepartmentDataList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // offerShimmerStatus = true;
        try {
          var response = await get(
            Uri.parse(
                'https://gub-contact-api.onrender.com/api/department'),
            headers: {
              //"Authorization": "Token $accessToken",
            },
          );
          // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            setState(() {
              // _showToast("Success");
              var data = jsonDecode(response.body);
              _departmentList = data["departments"];
              _shimmerStatus=false;


              setState(() {
                insertDataDepartment(data["departments"]);
              });

              //_showToast(_departmentList.length.toString());

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
    //  _showToast("No Internet Connection!");
    }
  }


  void insertDataDepartment(List departmentInfoList){

    // _showToast("length"+teacherInfoList.length.toString());

    DepartmentDataBase.instance.deleteAll();


    DepartmentNote departmentNote= DepartmentNote(
      departmentName: "All",
    );

    DepartmentDataBase.instance.create( departmentNote);


    for(int i=0;i<departmentInfoList.length;i++){


      DepartmentNote departmentNote= DepartmentNote(
        departmentName: departmentInfoList[i]["name"],
      );

      DepartmentDataBase.instance.create( departmentNote);

    }
    refreshDepartmentNotes();
  }

  void insertData(List teacherInfoList){

    // _showToast("length"+teacherInfoList.length.toString());

    TeacherNotesDataBase.instance.deleteAll();
    for(int i=0;i<teacherInfoList.length;i++){


      TeacherNote abc= TeacherNote(
        name: teacherInfoList[i]["name"],
        designation:  teacherInfoList[i]["designation"],
        department:  teacherInfoList[i]["department"],
        primaryPhone:  teacherInfoList[i]["primaryPhone"],
        secondaryPhone:  teacherInfoList[i]["secondaryPhone"],
        // secondaryPhone:  "",
        email:  teacherInfoList[i]["email"],
        pbx: teacherInfoList[i]["pbx"],
        room:  teacherInfoList[i]["room"],
        details: teacherInfoList[i]["details"],
        photo:  teacherInfoList[i]["photo"],
        userId: teacherInfoList[i]["_id"],
        // id: 1,

      );
      TeacherNotesDataBase.instance.create(abc);

    }

    refreshNotes();
  }

  Widget userInputSelectTopic() {
    return Container(
        height: 52,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 0,),

        decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(child: DropdownButton2(

              //   menuMaxHeight:55,
              value:  selectAssignmentId != null &&
                   selectAssignmentId.isNotEmpty ?
               selectAssignmentId : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 20,),
                  Text("Select Department",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              isExpanded: true,

              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 14),

              items: departmentNotesList.map((list) {
                return DropdownMenuItem(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(width: 20,),
                      Expanded(child: Text(
                          list.departmentName.toString(),
                          textAlign: TextAlign.left,
                          style:  TextStyle(
                              color: Colors.black,
                              //color: intello_text_color,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),),
                      const SizedBox(width: 20,),

                    ],
                  ),

                  // Text(list["country_name"].toString()),
                  value: list.departmentName.toString(),
                );

              },
              ).toList(),
              onChanged: (String? value) {


                setState(() {

                  _searchController?.text="";
                 notesListCopy=[];
                  notesListSearchAndFilter=[];
                  String data= selectAssignmentId=value.toString();

                // notesListCopy= notesListCopy.contains("x") as List<TeacherNote>;

                  if(value.toString().toLowerCase()=="all"){
                    notesListCopy=notesList;
                    notesListSearchAndFilter=notesList;

                  }
                  else{

                    for(int i=0;i<notesList.length;i++){
                      // _showToast(notesList[i].department);
                      if(data.toLowerCase() == notesList[i].department.toLowerCase()){
                       


                        TeacherNote note=TeacherNote(
                            name: notesList[i].name,
                            designation: notesList[i].designation,
                            department: notesList[i].department,
                            primaryPhone: notesList[i].primaryPhone,
                            secondaryPhone: notesList[i].secondaryPhone,
                            email: notesList[i].email,
                            pbx: notesList[i].pbx,
                            room: notesList[i].room,
                            details: notesList[i].details,
                            photo: notesList[i].photo,
                            userId: notesList[i].userId);
                        notesListCopy.add(note);
                        notesListSearchAndFilter.add(note);
                      }
                      else{

                        //  _showToast("not match");
                      }


                    }

                  }


                 // _showToast(notesListCopy.length.toString());
                  setState(() {

                  });




                  // _showToast(notesListCopy.length.toString());
                });


                // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
              },

            )
            )
          ],
        )
    );
  }




  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.search,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor:Colors.green,
          style: TextStyle(color:Colors.black,),
          autofocus: false,
          onChanged: (text){
           setState(() {
             String value=text.toLowerCase();
             notesListSearchAndFilter=[];
             if(text.isEmpty){

               notesListSearchAndFilter=notesListCopy;
               //  _getAllContactList();
             }
             else{
               for(int i=0;i<notesListCopy.length;i++){
                 if(notesListCopy[i].name.toString().toLowerCase().contains(value)){

                   // TeacherNote note=TeacherNote(
                   //     name: notesListCopy[i].name,
                   //     designation: notesListCopy[i].designation,
                   //     department: notesListCopy[i].department,
                   //     primaryPhone: notesListCopy[i].primaryPhone,
                   //     secondaryPhone: notesListCopy[i].secondaryPhone,
                   //     email: notesListCopy[i].email,
                   //     pbx: notesListCopy[i].pbx,
                   //     room: notesListCopy[i].room,
                   //     details: notesListCopy[i].details,
                   //     photo: notesListCopy[i].photo,
                   //     userId: notesListCopy[i].userId);
                   //  notesListSearchAndFilter.add(note);
                  notesListSearchAndFilter.add(notesListCopy[i]);
                 }
                 else{

                 //  notesListSearchAndFilter=[];

                   //  _showToast("not match");
                 }


               }

             }
           });

          },
          onSubmitted: (text){
            if(text.isEmpty){
             // _getAllContactList();
            }
            else{
             // _getAllContactSearchList(text);
            }

          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon:  Icon(
              Icons.search,
              color: hint_color,
              size: 25.0,
            ),

            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 16,
                color:novalexxa_hint_text_color,
                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
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


  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

}
