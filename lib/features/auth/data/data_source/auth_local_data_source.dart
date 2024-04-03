import 'package:grad_ease/features/auth/data/models/auth_login_model.dart';
import 'package:grad_ease/features/auth/data/models/student_model.dart';
import 'package:hive/hive.dart';

abstract interface class AuthLocalDataSource {
  void updateLoginDetail(AuthLoginModel authLoginModel, String authToken);
  void updateStudentDetails(StudentModel studentEntity);
  void clearLoginCredientials();

  AuthLoginModel? getLoginDetail();
  String? getLoginAuthToken();
  StudentModel? getStudentDetail();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl(this.box);

  @override
  void updateLoginDetail(AuthLoginModel authLoginModel, String authToken) {
    box.put('authToken', authToken);
    box.put('authLoginDetail', authLoginModel.toJson());
  }

  @override
  void updateStudentDetails(StudentModel studentModel) {
    box.put('studentDetail', studentModel.toJson());
  }

  @override
  String? getLoginAuthToken() {
    return box.get('authToken', defaultValue: null);
  }

  @override
  StudentModel? getStudentDetail() {
    final studentDetail = box.get('studentDetail', defaultValue: null);
    return StudentModel.fromJson(studentDetail);
  }

  @override
  AuthLoginModel? getLoginDetail() {
    final loginDetail = box.get('authLoginDetail', defaultValue: null);
    return AuthLoginModel.fromJson(loginDetail);
  }

  @override
  void clearLoginCredientials() {
    box.put('authToken', null);
    box.put('authLoginDetail', null);
  }
}
