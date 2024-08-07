class Student {
  int? id;
  String name;
  int age;
  String studentCourse;
  String profilePic;

  Student(
      {this.id,
      required this.name,
      required this.age,
      required this.studentCourse,
      required this.profilePic});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'class': studentCourse,
      'profilePic': profilePic,
    };
    return map;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      studentCourse: map['class'],
      profilePic: map['profilePic'],
    );
  }
}
