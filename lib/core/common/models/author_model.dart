import 'package:json_annotation/json_annotation.dart';

part 'author_model.g.dart';

@JsonSerializable()
class Author {
  @JsonKey(name: '_id')
  final String? id;
  final String? fullName;
  final String? email;
  final String? profileImage;

  Author({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
