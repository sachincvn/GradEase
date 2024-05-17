import 'package:json_annotation/json_annotation.dart';

part 'upload_file_response_model.g.dart';

@JsonSerializable()
class UploadFileResponseModel {
  final String message;
  final String filePath;

  UploadFileResponseModel({required this.message, required this.filePath});

  factory UploadFileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UploadFileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFileResponseModelToJson(this);
}
