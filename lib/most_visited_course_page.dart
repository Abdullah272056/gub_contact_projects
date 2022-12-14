import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() =>
      _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {


  List _teacherInfoList = [];


  @override
  void initState() {
    super.initState();


      _getMostVisitedCourseDataList();

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
              height: MediaQuery.of(context).size.height / 16,
              // height: 50,
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
                  child: ListView.builder(
                      itemCount: _teacherInfoList==null||_teacherInfoList.length<=0?0:
                      _teacherInfoList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return
                          //Container();

                          _buildMostVisitedCourseItemForList(_teacherInfoList[index]);
                      }),
                )
              ],
            )));
  }
  // Navigator.push(context,MaterialPageRoute(builder: (context)=>CourseDetailsScreen()));

  Widget _buildMostVisitedCourseItemForList(var response) {
    return InkResponse(
      onTap: (){
        // _showToast("ok");
      //  Navigator.push(context,MaterialPageRoute(builder: (context)=>CourseDetailsScreen(courseId: response["course_id"].toString(),)));
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
                        image:response["photo"],
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
                                    response["name"].toString(),
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
                                    response["primaryPhone"].toString(),
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
                                    response["email"].toString(),
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
                                    response["department"].toString()+" (${response["designation"].toString()})"
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
                  // tooltip: 'Increase volume by 10',
                  onPressed: (){
                    _callNumber("01994215664");
                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }

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


  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }

}
