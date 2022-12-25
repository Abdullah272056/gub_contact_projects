//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'note.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// import 'notes_database.dart';
//
//
// class LogInScreen extends StatefulWidget {
//   const LogInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LogInScreen> createState() => _LogInScreenState();
// }
//
// class _LogInScreenState extends State<LogInScreen> {
//   String countryName="en",countryIcon="icon_country.png";
//
//
//   late List<Note> notes;
//   bool isLoading =false;
//
//
//   @override
//   @mustCallSuper
//   initState() {
//     super.initState();
//     refreshNotes();
//
//   }
//
//   @override
//   void dispose() {
//     NotesDataBase.instance.close();
//     super.dispose();
//
//   }
//
//   Future refreshNotes() async {
//     NotesDataBase.instance;
//     setState(() {
//       isLoading=true;
//     });
//     this.notes=await NotesDataBase.instance.readAllNotes();
//     _showToast(notes.length.toString());
//     setState(() {
//       isLoading=false;
//     });
//
//   }
//
//   Future refreshNotes1() async {
//     NotesDataBase.instance;
//     setState(() {
//       isLoading=true;
//     });
//     this.notes=await NotesDataBase.instance.readAllNotes();
//
//     _showToast(notes.length.toString());
//
//     setState(() {
//       isLoading=false;
//     });
//
//   }
//
//   _showToast(String message) {
//     Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:Colors.white ,
//       body: SingleChildScrollView(
//         child: Column(
//
//           children: [
//
//             SizedBox(
//               height: 55,
//             ),
//
//             Padding(
//                 padding:
//                 const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
//                 child: Column(
//                   children: [
//                     Container(
//                       margin:EdgeInsets.only(right: 20.0,top: 50,left: 10),
//                       child:Align(alignment: Alignment.topLeft,
//
//                       ),
//                     ),
//
//                     _buildLogInButton(),
//
//                     SizedBox(
//                       height: 35,
//                     ),
//                     _buildreadButton(),
//                     SizedBox(
//                       height: 35,
//                     ),
//
//
//
//                   ],
//                 ))
//
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildNotes()=> GridView.custom(
//     padding: EdgeInsets.only(
//       bottom: 16,
//       left: 16,
//       right: 16,
//     ),
//     gridDelegate: SliverQuiltedGridDelegate(
//       crossAxisCount: 6,
//       mainAxisSpacing: 8,
//       crossAxisSpacing: 8,
//       repeatPattern: QuiltedGridRepeatPattern.inverted,
//       pattern: const [
//         QuiltedGridTile(4, 4),
//         QuiltedGridTile(2, 2),
//         QuiltedGridTile(2, 2),
//       ],
//     ),
//     childrenDelegate: SliverChildBuilderDelegate((context, index) {
//       return GestureDetector(
//         onTap: () async{
//
//         },
//         child:Text("Abdullah"),
//       );
//     },
//         childCount: notes.length
//     ),
//   );
//
//   Widget _buildLogInButton() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//       child: ElevatedButton(
//         onPressed: () {
//           DateTime dt=DateTime.now();
//           Note abc= Note(
//               name: 'Abdullah',
//               designation: 'App Developer',
//               department: 'CSE' ,
//               primaryPhone: '01994215664',
//               secondaryPhone: '01994215665',
//               email: 'abc@gmail.com',
//               pbx: 'as',
//               room: 'B404',
//               details: 'dfvb',
//               photo: 'dfvb',
//               userId: 'wefg'
//             // id: 1,
//
//           );
//           NotesDataBase.instance.create( abc);
//
//         },
//         style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(7))),
//         child: Ink(
//
//           decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Colors.black38, Colors.black38,],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//               borderRadius: BorderRadius.circular(7.0)
//           ),
//           child: Container(
//
//             height: 50,
//             alignment: Alignment.center,
//             child:  Text(
//               "Login",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'PT-Sans',
//                 fontSize: 20,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildreadButton() {
//     return Container(
//       margin: const EdgeInsets.only(left: 10.0, right: 10.0),
//       child: ElevatedButton(
//         onPressed: () {
//
//           refreshNotes1();
//
//         },
//         style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(7))),
//         child: Ink(
//
//           decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Colors.black38, Colors.black38,],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//               borderRadius: BorderRadius.circular(7.0)
//           ),
//           child: Container(
//
//             height: 50,
//             alignment: Alignment.center,
//             child:  Text(
//               "get data",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'PT-Sans',
//                 fontSize: 20,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
