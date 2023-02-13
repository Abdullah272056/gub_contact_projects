


final String teacherTableNotes="notes_teacher";

class TeacherNoteFields{
  static final List<String> values =[
    // id, isImportant, number, title, description, time
    id, name, designation, department, primaryPhone, secondaryPhone,email,pbx,room,details,photo,userId
  ];

  static final String id='_id';
  static final String name='name';
  static final String designation='designation';
  static final String department='department';
  static final String primaryPhone='primaryPhone';
  static final String secondaryPhone='secondaryPhone';
  static final String email='email';
  static final String pbx='pbx';
  static final String room='room';
  static final String details='details';
  static final String photo='photo';
  static final String userId='userId';


}

class TeacherNote{

  final int? id;
  final String name;
  final String designation;
  final String department;
  final String primaryPhone;
  final String secondaryPhone;
  final String email;
  final String pbx;
  final String room;
  final String details;
  final String photo;
  final String userId;

  const TeacherNote({
    this.id,
    required this.name,
    required this.designation,
    required this.department,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.email,
    required this.pbx,
    required this.room,
    required this.details,
    required this.photo,
    required this.userId,
});

  TeacherNote copy({
    int? id,
    String? name,
    String? designation,
    String? department,
    String? primaryPhone,
    String? secondaryPhone,
    String? email,
    String? pbx,
    String? room,
    String? details,
    String? photo,
    String? userId,
})=>
      TeacherNote(
    id: id?? this.id,
      name: name?? this.name,
      designation: designation?? this.designation,
      department: department?? this.department,
      primaryPhone: primaryPhone?? this.primaryPhone,
      secondaryPhone: secondaryPhone?? this.secondaryPhone,
      email: email?? this.email,
      pbx: pbx?? this.pbx,
      room: room?? this.room,
      details: details?? this.details,
      photo: photo?? this.photo,
      userId: userId?? this.userId,

  );


static TeacherNote fromJson(Map<String, Object?> json)=> TeacherNote(
  id: json[TeacherNoteFields.id] as int?,

  name: json[TeacherNoteFields.name] as String,
  designation: json[TeacherNoteFields.designation] as String,
  department: json[TeacherNoteFields.department] as String,
  primaryPhone: json[TeacherNoteFields.primaryPhone] as String,
  secondaryPhone: json[TeacherNoteFields.secondaryPhone] as String,
  email: json[TeacherNoteFields.email] as String,
  pbx: json[TeacherNoteFields.pbx] as String,
  room: json[TeacherNoteFields.room] as String,
  details: json[TeacherNoteFields.details] as String,
  photo: json[TeacherNoteFields.photo] as String,
  userId: json[TeacherNoteFields.userId] as String,

  );

  Map<String,Object?> toJson() =>{
    TeacherNoteFields.id:id,
    TeacherNoteFields.name:name,
    TeacherNoteFields.designation:designation,
    TeacherNoteFields.department:department,
    TeacherNoteFields.primaryPhone:primaryPhone,
    TeacherNoteFields.secondaryPhone:secondaryPhone,
    TeacherNoteFields.email:email,
    TeacherNoteFields.pbx:pbx,
    TeacherNoteFields.room:room,
    TeacherNoteFields.details:details,
    TeacherNoteFields.photo:photo,
    TeacherNoteFields.userId:userId,

  };


}