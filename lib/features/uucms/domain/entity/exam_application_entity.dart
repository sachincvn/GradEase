// ignore_for_file: non_constant_identifier_names

class ExamApplicationEntity {
  final String? examMonth;
  final String? examType;
  final int? programLevel;
  final int? Id;
  final String? status;
  final int? enbs_id;
  final String? plName;
  final String? termName;
  final bool? IsResultPublished;
  final bool? IsRejectionAllowed;
  final int? termID;

  ExamApplicationEntity({
    required this.examMonth,
    required this.examType,
    required this.programLevel,
    required this.Id,
    required this.status,
    required this.enbs_id,
    required this.plName,
    required this.termName,
    required this.IsResultPublished,
    required this.IsRejectionAllowed,
    required this.termID,
  });
}
