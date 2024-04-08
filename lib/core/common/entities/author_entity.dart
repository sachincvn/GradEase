import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/features/feeds/data/models/author_model.dart';

class AuthorEntity {
  final String id;
  final String fullName;
  final String email;
  final String? profileImage;

  AuthorEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
  });

  factory AuthorEntity.fromMap(Map<String, dynamic> json) {
    return AuthorEntity(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'profileImage': profileImage ?? StringConstants.avtarImage
    };
  }

  Author toAuthor() {
    return Author(
        id: id, fullName: fullName, email: email, profileImage: profileImage);
  }
}
