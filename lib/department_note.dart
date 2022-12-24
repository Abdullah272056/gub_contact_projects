


final String tableNotesDepartment="department_notes";

class DepartmentNoteFields{
  static final List<String> values =[
    id, departmentName
  ];

  static final String id='_id';
  static final String departmentName='departmentName';



}

class DepartmentNote{

  final int? id;
  final String departmentName;


  const DepartmentNote({
    this.id,
    required this.departmentName,

});

  DepartmentNote copy({
    int? id,
    String? departmentName,

})=>
      DepartmentNote(
    id: id?? this.id,
    departmentName: departmentName?? this.departmentName,


  );


static DepartmentNote fromJson(Map<String, Object?> json)=> DepartmentNote(
  id: json[DepartmentNoteFields.id] as int?,

  departmentName: json[DepartmentNoteFields.departmentName] as String,


  );

  Map<String,Object?> toJson() =>{
    DepartmentNoteFields.id:id,
    DepartmentNoteFields.departmentName:departmentName,


  };


}