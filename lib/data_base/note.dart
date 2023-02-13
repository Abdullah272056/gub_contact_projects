//
//
//
// final String tableNotes="notes_teacher";
//
// class NoteFields{
//   static final List<String> values =[
//     // id, isImportant, number, title, description, time
//     id, name, designation, department, primaryPhone, secondaryPhone,email,pbx,room,details,photo,userId
//   ];
//
//   static final String id='_id';
//   static final String name='name';
//   static final String designation='designation';
//   static final String department='department';
//   static final String primaryPhone='primaryPhone';
//   static final String secondaryPhone='secondaryPhone';
//   static final String email='email';
//   static final String pbx='pbx';
//   static final String room='room';
//   static final String details='details';
//   static final String photo='photo';
//   static final String userId='userId';
//
//
// }
//
// class Note{
//
//   final int? id;
//   final String name;
//   final String designation;
//   final String department;
//   final String primaryPhone;
//   final String secondaryPhone;
//   final String email;
//   final String pbx;
//   final String room;
//   final String details;
//   final String photo;
//   final String userId;
//
//   const Note({
//     this.id,
//     required this.name,
//     required this.designation,
//     required this.department,
//     required this.primaryPhone,
//     required this.secondaryPhone,
//     required this.email,
//     required this.pbx,
//     required this.room,
//     required this.details,
//     required this.photo,
//     required this.userId,
// });
//
//   Note copy({
//     int? id,
//     String? name,
//     String? designation,
//     String? department,
//     String? primaryPhone,
//     String? secondaryPhone,
//     String? email,
//     String? pbx,
//     String? room,
//     String? details,
//     String? photo,
//     String? userId,
// })=>
//   Note(
//     id: id?? this.id,
//       name: name?? this.name,
//       designation: designation?? this.designation,
//       department: department?? this.department,
//       primaryPhone: primaryPhone?? this.primaryPhone,
//       secondaryPhone: secondaryPhone?? this.secondaryPhone,
//       email: email?? this.email,
//       pbx: pbx?? this.pbx,
//       room: room?? this.room,
//       details: details?? this.details,
//       photo: photo?? this.photo,
//       userId: userId?? this.userId,
//
//   );
//
//
// static Note fromJson(Map<String, Object?> json)=> Note(
//   id: json[NoteFields.id] as int?,
//
//   name: json[NoteFields.name] as String,
//   designation: json[NoteFields.designation] as String,
//   department: json[NoteFields.department] as String,
//   primaryPhone: json[NoteFields.primaryPhone] as String,
//   secondaryPhone: json[NoteFields.secondaryPhone] as String,
//   email: json[NoteFields.email] as String,
//   pbx: json[NoteFields.pbx] as String,
//   room: json[NoteFields.room] as String,
//   details: json[NoteFields.details] as String,
//   photo: json[NoteFields.photo] as String,
//   userId: json[NoteFields.userId] as String,
//
//   );
//
//   Map<String,Object?> toJson() =>{
//     NoteFields.id:id,
//     NoteFields.name:name,
//     NoteFields.designation:designation,
//     NoteFields.department:department,
//     NoteFields.primaryPhone:primaryPhone,
//     NoteFields.secondaryPhone:secondaryPhone,
//     NoteFields.email:email,
//     NoteFields.pbx:pbx,
//     NoteFields.room:room,
//     NoteFields.details:details,
//     NoteFields.photo:photo,
//     NoteFields.userId:userId,
//
//   };
//
//
// }