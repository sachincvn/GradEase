import 'package:grad_ease/features/communities/data/models/communtiy_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'communites_reponse_model.g.dart';

@JsonSerializable()
class CommunityRespnseModel {
  final int statusCode;
  final String? message;
  final List<CommunityModel> data;

  CommunityRespnseModel(
      {required this.statusCode, required this.message, required this.data});

  factory CommunityRespnseModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityRespnseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityRespnseModelToJson(this);
}
