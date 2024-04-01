enum GenderEnum { MALE, FEMALE, OTHER }

enum CourseEnum { MCA, MBA } // Define your CourseEnum

class StudentModel {
  final String fullName;
  final String fatherName;
  final DateTime dob;
  final GenderEnum gender;
  final CourseEnum course;
  final int courseYear;
  final String email;
  final String studentPhone;
  final String parentPhone;

  StudentModel({
    required this.fullName,
    required this.fatherName,
    required this.dob,
    required this.gender,
    required this.course,
    required this.courseYear,
    required this.email,
    required this.studentPhone,
    required this.parentPhone,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      fullName: json['fullName'],
      fatherName: json['fatherName'],
      dob: DateTime.parse(json['dob']),
      gender: _parseGender(json['gender']),
      course: _parseCourse(json['course']),
      courseYear: json['courseYear'],
      email: json['email'],
      studentPhone: json['studentPhone'],
      parentPhone: json['parentPhone'],
    );
  }

  static GenderEnum _parseGender(String gender) {
    switch (gender) {
      case 'Male':
        return GenderEnum.MALE;
      case 'Female':
        return GenderEnum.FEMALE;
      case 'Other':
        return GenderEnum.OTHER;
      default:
        throw Exception('Invalid gender value: $gender');
    }
  }

  static CourseEnum _parseCourse(String course) {
    switch (course) {
      case 'MCA':
        return CourseEnum.MCA;
      case 'MBA':
        return CourseEnum.MBA;
      default:
        throw Exception('Invalid course value: $course');
    }
  }
}
