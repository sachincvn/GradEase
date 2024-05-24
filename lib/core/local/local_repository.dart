import 'package:grad_ease/core/common/entities/auth_login_entity.dart';
import 'package:grad_ease/core/common/entities/author_entity.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/features/auth/data/models/auth_login_model.dart';
import 'package:grad_ease/features/auth/data/models/student_model.dart';
import 'package:hive/hive.dart';

abstract interface class LocalDetailsRepository {
  void updateLoginDetail(AuthLoginModel authLoginModel, String authToken);
  void updateStudentDetails(AuthLoginDetailModel studentEntity);
  void clearLoginCredientials();
  void removeUUCMSCookie();
  void updateUUCMSLoginCookie(String cookie);
  void updateAdminLogin(bool value);
  void clearAllLocalData();

  AuthLoginEntity? getLoginDetail();
  String? getLoginAuthToken();
  String? getUserId();
  AuthDetailEntity? getStudentDetail();
  AuthorEntity? getAuthorEntity();
  String? getUUCMSLoginCookie();
  bool? isAdminLogin();
}

class LocalDetailsRepositoryImpl implements LocalDetailsRepository {
  final Box box;

  LocalDetailsRepositoryImpl(this.box);

  @override
  void updateLoginDetail(AuthLoginModel authLoginModel, String authToken) {
    box.put('authToken', authToken);
    box.put('authLoginDetail', authLoginModel.toJson());
  }

  @override
  void updateStudentDetails(AuthLoginDetailModel studentModel) {
    _updateUserId(studentModel.id);
    _updateAuthorDetail(AuthorEntity(
        id: studentModel.id,
        fullName: studentModel.fullName,
        email: studentModel.email!,
        profileImage: studentModel.profileImage!));
    box.put('studentDetail', studentModel.toMap());
  }

  void _updateUserId(String userId) {
    box.put('userId', userId);
  }

  void _updateAuthorDetail(AuthorEntity authorEntity) {
    box.put('authorDetail', authorEntity.toMap());
  }

  @override
  String? getLoginAuthToken() {
    return box.get('authToken', defaultValue: null);
  }

  @override
  AuthDetailEntity? getStudentDetail() {
    final studentDetail = box.get('studentDetail', defaultValue: null);
    if (studentDetail == null) {
      return null;
    }
    return AuthLoginDetailModel.fromMap(studentDetail).toEntity();
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

  @override
  String? getUserId() {
    return box.get('userId', defaultValue: null);
  }

  @override
  AuthorEntity? getAuthorEntity() {
    final loginDetail = box.get('authorDetail', defaultValue: null);
    return AuthorEntity.fromMap(loginDetail);
  }

  @override
  String? getUUCMSLoginCookie() {
    return box.get('uucmslogincookie', defaultValue: null);
  }

  @override
  void updateUUCMSLoginCookie(String cookie) {
    box.put('uucmslogincookie', cookie);
  }

  @override
  void removeUUCMSCookie() {
    box.put('uucmslogincookie', null);
  }

  @override
  void updateAdminLogin(bool value) {
    box.put('isadmin', value);
  }

  @override
  bool? isAdminLogin() {
    return box.get('isadmin', defaultValue: null);
  }

  @override
  void clearAllLocalData() {
    box.put('authToken', null);
    box.put('authLoginDetail', null);
    box.put('userId', null);
    box.put('studentDetail', null);
    box.put('isadmin', null);
    box.put('uucmslogincookie', null);
  }
}
