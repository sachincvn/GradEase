// ignore_for_file: non_constant_identifier_names

class ExamResultEntity {
  final int? Slno;
  final String? CourseCode;
  final String? CourseName;
  final double? MaximumMarks;
  final double? MinimumMarks;
  final String? IAMarks;
  final String? SEMarks;
  final String? MarksScored;
  final double? Credit;
  final double? Grade;
  final double? GradePoint;
  final double? SGPA;
  final double? CGPA;
  final String? Status;
  final String? ERStatus;
  final String? LetterGrade;
  final String? TermGrade;
  final String? PromotionStatus;

  ExamResultEntity(
      {required this.Slno,
      required this.CourseCode,
      required this.CourseName,
      required this.MaximumMarks,
      required this.MinimumMarks,
      required this.IAMarks,
      required this.SEMarks,
      required this.MarksScored,
      required this.Credit,
      required this.Grade,
      required this.GradePoint,
      required this.SGPA,
      required this.CGPA,
      required this.Status,
      required this.ERStatus,
      required this.LetterGrade,
      required this.TermGrade,
      required this.PromotionStatus});
}
