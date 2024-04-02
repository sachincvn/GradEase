import 'package:grad_ease/core/common/entities/auth_login_entity.dart';

class AuthLoginModel extends AuthLoginEntity {
  AuthLoginModel({required super.email, required super.password});

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
